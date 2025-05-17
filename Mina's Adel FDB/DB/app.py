from flask import Flask, request, jsonify
from flask_cors import CORS
import mysql.connector

app = Flask(__name__)
CORS(app)

# Database connection configuration
db = mysql.connector.connect(
    host='localhost',
    user='root',           # Change if your MySQL username is different
    password='123456',   # Change to your MySQL password
    database='online_store'
)

cursor = db.cursor(dictionary=True)

# Get all products
@app.route('/products', methods=['GET'])
def get_products():
    cursor.execute("SELECT * FROM Products")
    products = cursor.fetchall()
    return jsonify(products)

# Add a new product
@app.route('/products', methods=['POST'])
def add_product():
    data = request.json
    query = """
        INSERT INTO Products (Product_ID, Name, Description, Size, Color, Price, Quantity)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
    """
    values = (
        data['Product_ID'], data['Name'], data['Description'],
        data['Size'], data['Color'], data['Price'], data['Quantity']
    )
    cursor.execute(query, values)
    db.commit()
    return jsonify({'message': 'Product added successfully!'}), 201

# Update a product
@app.route('/products/<int:product_id>', methods=['PUT'])
def update_product(product_id):
    data = request.json
    query = """
        UPDATE Products SET Name=%s, Description=%s, Size=%s, Color=%s, Price=%s, Quantity=%s
        WHERE Product_ID=%s
    """
    values = (
        data['Name'], data['Description'], data['Size'],
        data['Color'], data['Price'], data['Quantity'], product_id
    )
    cursor.execute(query, values)
    db.commit()
    return jsonify({'message': 'Product updated successfully!'}), 200

# Delete a product
@app.route('/products/<int:product_id>', methods=['DELETE'])
def delete_product(product_id):
    query = "DELETE FROM Products WHERE Product_ID=%s"
    cursor.execute(query, (product_id,))
    db.commit()
    return jsonify({'message': 'Product deleted successfully!'}), 200

if __name__ == '__main__':
    app.run(port=5000)
