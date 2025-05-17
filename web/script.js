// Debug function
function showDebugInfo(message) {
    const debugDiv = document.getElementById('debug-info');
    if (debugDiv) {
        debugDiv.textContent = message;
        console.log('Debug Info:', message);
    }
}

// Initialize variables
let isEditMode = false;
let editingProductId = null;
let sortOrder = {};
let products = [];

// Enhanced error handling
window.onerror = function(msg, url, lineNo, columnNo, error) {
    const errorMessage = `Error: ${msg}\nURL: ${url}\nLine: ${lineNo}\nColumn: ${columnNo}\nStack: ${error ? error.stack : 'No stack trace'}`;
    showDebugInfo(errorMessage);
    console.error('Global Error:', errorMessage);
    return false;
};

// Page load handler with enhanced error checking
document.addEventListener('DOMContentLoaded', function() {
    showDebugInfo('Page loaded, checking environment...');
    
    // Check if running on a server
    const isLocalhost = window.location.hostname === 'localhost' || 
                       window.location.hostname === '127.0.0.1';
    showDebugInfo(`Running on ${isLocalhost ? 'localhost' : 'live server'}`);
    
    // Check if all required elements exist
    const requiredElements = [
        'productsTable',
        'searchBar',
        'productModal',
        'debug-info'
    ];
    
    const missingElements = requiredElements.filter(id => !document.getElementById(id));
    if (missingElements.length > 0) {
        showDebugInfo(`Missing elements: ${missingElements.join(', ')}`);
    }
    
    try {
        loadProducts();
    } catch (error) {
        showDebugInfo('Error during initialization: ' + error.message);
        console.error('Initialization Error:', error);
    }
});

// Load Products Function
function loadProducts() {
    showDebugInfo('Loading products...');
    try {
        // Sample data for testing
        products = [
            { id: '1', name: 'T-Shirt', description: 'Cotton T-Shirt', size: 'M', color: 'Blue', price: 29.99, quantity: 100 },
            { id: '2', name: 'Jeans', description: 'Denim Jeans', size: '32', color: 'Black', price: 49.99, quantity: 50 }
        ];
        displayProducts();
        showDebugInfo('Products loaded successfully');
    } catch (error) {
        showDebugInfo('Error loading products: ' + error.message);
        console.error('Error loading products:', error);
    }
}

// Display Products Function
function displayProducts() {
    showDebugInfo('Displaying products...');
    try {
        const tbody = document.querySelector('#productsTable tbody');
        if (!tbody) {
            throw new Error('Table body element not found');
        }
        tbody.innerHTML = '';
        
        products.forEach(product => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${product.id}</td>
                <td>${product.name}</td>
                <td>${product.description}</td>
                <td>${product.size}</td>
                <td>${product.color}</td>
                <td>${product.price}</td>
                <td>${product.quantity}</td>
                <td>
                    <button class="action-btn" onclick="editProduct('${product.id}')">Edit</button>
                    <button class="action-btn delete" onclick="deleteProduct('${product.id}')">Delete</button>
                </td>
            `;
            tbody.appendChild(row);
        });
        showDebugInfo('Products displayed successfully');
    } catch (error) {
        showDebugInfo('Error displaying products: ' + error.message);
        console.error('Error displaying products:', error);
    }
}

// Search Products Function
function searchProducts() {
    const searchText = document.getElementById('searchBar').value.toLowerCase();
    const rows = document.querySelectorAll('#productsTable tbody tr');
    
    rows.forEach(row => {
        const text = row.textContent.toLowerCase();
        row.style.display = text.includes(searchText) ? '' : 'none';
    });
}

// Sort Table Function
function sortTable(columnIndex) {
    const tbody = document.querySelector('#productsTable tbody');
    const rows = Array.from(tbody.querySelectorAll('tr'));
    
    sortOrder[columnIndex] = !sortOrder[columnIndex];
    
    rows.sort((a, b) => {
        const aValue = a.cells[columnIndex].textContent;
        const bValue = b.cells[columnIndex].textContent;
        
        if (columnIndex === 5 || columnIndex === 6) { // Price or Quantity columns
            return sortOrder[columnIndex] ? 
                parseFloat(aValue) - parseFloat(bValue) : 
                parseFloat(bValue) - parseFloat(aValue);
        }
        
        return sortOrder[columnIndex] ? 
            aValue.localeCompare(bValue) : 
            bValue.localeCompare(aValue);
    });
    
    tbody.innerHTML = '';
    rows.forEach(row => tbody.appendChild(row));
}

// Form Functions
function openForm(isEdit) {
    isEditMode = isEdit;
    const modal = document.getElementById('productModal');
    const title = document.getElementById('modalTitle');
    
    title.textContent = isEdit ? 'Edit Product' : 'Add New Product';
    modal.style.display = 'block';
    
    if (!isEdit) {
        clearForm();
    }
}

function closeForm() {
    document.getElementById('productModal').style.display = 'none';
    clearForm();
}

function clearForm() {
    document.getElementById('productId').value = '';
    document.getElementById('productName').value = '';
    document.getElementById('productDesc').value = '';
    document.getElementById('productSize').value = '';
    document.getElementById('productColor').value = '';
    document.getElementById('productPrice').value = '';
    document.getElementById('productQty').value = '';
    editingProductId = null;
}

function editProduct(id) {
    const product = products.find(p => p.id === id);
    if (product) {
        editingProductId = id;
        document.getElementById('productId').value = product.id;
        document.getElementById('productName').value = product.name;
        document.getElementById('productDesc').value = product.description;
        document.getElementById('productSize').value = product.size;
        document.getElementById('productColor').value = product.color;
        document.getElementById('productPrice').value = product.price;
        document.getElementById('productQty').value = product.quantity;
        openForm(true);
    }
}

function saveProduct() {
    const product = {
        id: document.getElementById('productId').value,
        name: document.getElementById('productName').value,
        description: document.getElementById('productDesc').value,
        size: document.getElementById('productSize').value,
        color: document.getElementById('productColor').value,
        price: parseFloat(document.getElementById('productPrice').value),
        quantity: parseInt(document.getElementById('productQty').value)
    };
    
    if (isEditMode) {
        const index = products.findIndex(p => p.id === editingProductId);
        if (index !== -1) {
            products[index] = product;
        }
    } else {
        products.push(product);
    }
    
    displayProducts();
    closeForm();
}

function deleteProduct(id) {
    if (confirm('Are you sure you want to delete this product?')) {
        products = products.filter(p => p.id !== id);
        displayProducts();
    }
} 