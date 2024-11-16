// Sample data with 'followUp' status added
const high_risk_customer_data = [
    { name: 'Alice', churn: 0.8, service: 'Savings Account', ageGroup: '25-34', location: 'Zimbabwe', followUp: false },
    { name: 'Bob', churn: 0.3, service: 'Checking Account', ageGroup: '35-44', location: 'Ghana', followUp: false },
    { name: 'Charlie', churn: 0.7, service: 'Savings Account', ageGroup: '45-54', location: 'USA', followUp: true },
    { name: 'David', churn: 0.2, service: 'Savings Account', ageGroup: '55+', location: 'Zimbabwe', followUp: false },
    { name: 'Eva', churn: 0.5, service: 'Checking Account', ageGroup: '25-34', location: 'Ghana', followUp: false },
    // Add more customers as needed
];

// Function to filter high-risk customers based on the threshold
function filterHighRiskCustomers(threshold) {
    return high_risk_customer_data.filter(customer => customer.churn >= threshold);
}

// Function to generate the table rows dynamically
function updateCustomerTable(threshold) {
    const filteredCustomers = filterHighRiskCustomers(threshold);
    const tableBody = document.getElementById('high-risk-table-body');
    
    // Clear the existing table rows
    tableBody.innerHTML = '';

    filteredCustomers.forEach((customer, index) => {
        const row = document.createElement('tr');

        // Add customer details as table cells
        // use customer id insted\ad
        row.innerHTML = `
            <td>${customer.name}</td>
            <td>${customer.ageGroup}</td>
            <td>${customer.location}</td>
            <td>${(customer.churn * 100).toFixed(2)}%</td>
            <td>${customer.service}</td>
            <td>
                <a href="customer_detail.html?name=${encodeURIComponent(customer.name)}" class="btn btn-info btn-sm">
                    View Details
                </a>
            </td>

            
           
            <td>
                <input type="checkbox" id="follow-up-${index}" ${customer.followUp ? 'checked' : ''} onchange="toggleFollowUp(${index})">
            </td>
        `;
        //  <td><a href="mailto:${customer.name.toLowerCase()}@example.com">Initiate Contact</a></td>
        
        // Append the row to the table body
        tableBody.appendChild(row);
    });
}

// Function to toggle the follow-up status
function toggleFollowUp(index) {
    // Toggle the 'followUp' status for the customer
    customerData[index].followUp = !customerData[index].followUp;
}

// Initialize table with the default threshold
updateCustomerTable(0.5);

// Event listener to update the table when the threshold slider is changed
document.getElementById('high-risk-churn-threshold').addEventListener('input', (e) => {
    const threshold = parseFloat(e.target.value);
    document.getElementById('high-risk-threshold-value').textContent = threshold.toFixed(2);
    updateCustomerTable(threshold);
});
