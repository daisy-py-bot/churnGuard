

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

// Function to dynamically populate the table
function populateCustomerTable(customers) {
    const tbody = document.getElementById('customer-table-body');
    tbody.innerHTML = ''; // Clear existing rows

    customers.forEach(customer => {
        const row = document.createElement('tr');

        // console.log(customer.CustomerID)
        let customer_id = customer.CustomerID
        row.innerHTML = `
            <td data-label="Name">${customer.CustomerName}</td>
            <td data-label="Location">${customer.Country || 'N/A'}</td>
            <td data-label="Account Status" style="color: ${
                customer.account_status === 'Active' ? 'green' : 'red'
            }">${customer.account_status || 'N/A'}</td>
            <td data-label="Account Type">${customer.AccountTypeName || 'N/A'}</td>
            <td data-label="Churn Prediction">${customer.ChurnProbability || 'N/A'}</td>
            <td data-label="Tags">
                <span class="tag ${
                    customer.RiskLevel?.toLowerCase().replace(' ', '-') || ''
                }">${customer.RiskLevel || 'N/A'}</span>
            </td>
            

            <td data-label="Actions">
                <a href="../actions/get_customer_detail.php?customerID=${customer_id}">View Details</a>
            </td>
                        
            
        `;
        tbody.appendChild(row);
    });
}

// Load more customers dynamically
async function loadMoreCustomers() {
    try {
        const additionalCustomers = await fetchCustomerData(); // Fetch additional data
        customerData.push(...additionalCustomers); // Add new customers to the existing array
        populateCustomerTable(customerData);
    } catch (error) {
        console.error('Error loading more customers:', error);
    }
}

// Follow-Up Action
function followUp(customerName) {
    alert(`Follow-up added for ${customerName}!`);
}

// Initial load
document.addEventListener('DOMContentLoaded', async () => {
    const customers = await fetchCustomerData(); // Fetch data on initial load
    populateCustomerTable(customers);
});



