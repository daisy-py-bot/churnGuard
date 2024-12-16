

// Fetch customer data from the server
async function fetchCustomerData() {
    try {
        const response = await fetch('../db/view_customers.php'); // Adjust endpoint if needed
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        const customers = await response.json();
        return customers;
    } catch (error) {
        console.error('Error fetching customer data:', error);
        return [];
    }
}
const userRole = document.getElementById('user-role').dataset.role;
// Now you can use the userRole variable in your JavaScript code
let isAdmin = (userRole === 'Admin');

// Function to dynamically populate the table
function populateCustomerTable(customers) {
    const tbody = document.getElementById('customer-table-body');
    tbody.innerHTML = ''; // Clear existing rows

    customers.forEach(customer => {
        const row = document.createElement('tr');

        // set row attribute at the customer id
        row.setAttribute('data-id', customer.CustomerID);

        // console.log(customer.CustomerID)
        let customer_id = customer.CustomerID
        row.innerHTML = `
            <td data-label="Name">${customer.CustomerName}</td>
            <td data-label="Location">${customer.Country || 'N/A'}</td>
            <td data-label="Churned Status" style="color: ${
                customer.churn_status === 'churned' ? 'red' : 'green'
            }">${customer.churn_status || 'Active'}</td>
            <td data-label="Account Type">${customer.AccountTypeName || 'N/A'}</td>
            <td data-label="Churn Prediction">${customer.ChurnProbability || 'N/A'}</td>
            <td data-label="Tags">
                <span class="tag ${
                    customer.RiskLevel?.toLowerCase().replace(' ', '-') || ''
                }">${customer.RiskLevel || 'N/A'}</span>
            </td>
            

            ${isAdmin ? `
            <td data-label="Actions">
            
                <button class="btn btn-primary" onclick="viewCustomer(${customer_id})">View</button>
                <button class="btn btn-danger" onclick="churnCustomer(${customer_id})">Churn</button>
                
            </td>
            ` : ''}
                        
            
        `;
        tbody.appendChild(row);
    });
}



// Initial load
document.addEventListener('DOMContentLoaded', async () => {
    const customers = await fetchCustomerData(); // Fetch data on initial load
    populateCustomerTable(customers);
});



// Apply filters based on the user inputs
async function applyFilters() {
    try {
        // Get filter values from the form
        const name = document.getElementById('name-search').value.trim();
        const status = document.getElementById('status-filter').value.trim();
        const risk = document.getElementById('risk-level-filter').value.trim();
        const region = document.getElementById('location-filter').value.trim();
        const accountType = document.getElementById('account-filter').value.trim();

        // Build query parameters
        const params = new URLSearchParams({
            name,
            status,
            risk,
            region,
            accountType,
        });

        // Fetch data with filters applied
        const response = await fetch(`../actions/filter_customer_data.php?${params.toString()}`);
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        const filteredCustomers = await response.json();

        // Update the table with filtered data
        populateCustomerTable(filteredCustomers);
    } catch (error) {
        console.error('Error applying filters:', error);
    }
}

// churn the customer
async function churnCustomer(customer_id) {
    // confirm if the user wants to churn the customer
    if(confirm('Are you sure you want to churn this customer?')){
        // continue with the churn process
    
    // get the role with the id
    const row = document.querySelector(`tr[data-id="${customer_id}"]`);
    const churnStatus = row.querySelector('td[data-label="Churned Status"]');

    try {
        // create the json object to send to the server to churn the
        // customer with the id passed as a parameter to the function
        const requestBody = {
            customer_id : customer_id,
            reason : "Customer no longer needs the service."
        };

        
        const response = await fetch(`../actions/churn_customer.php`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(requestBody),
        }
        );
        if (!response.ok) {
            throw new Error(`Failed to churn customer with ID: ${customer_id}`);
        }
        // update the churn status in the table
        churnStatus.textContent = 'churned';

        // change the text color to red
        churnStatus.style.color = 'red';
        alert('Customer churned successfully');
        // location.reload(); // Reload the page to reflect the changes
    } catch (error) {
        console.error('Error churning customer:', error);
        alert('Failed to churn customer. Please try again later.');
    }

}

}


// view the customer
function viewCustomer(customer_id) {
    console.log(customer_id);
    window.location.href = `../actions/view_one_customer.php?customer_id=${customer_id}`;
}