// function applyFilters() {
//     // Get filter values
//     const nameSearch = document.getElementById('name-search').value.toLowerCase();
//     const statusFilter = document.getElementById('status-filter').value;
//     const riskFilter = document.getElementById('risk-level-filter').value;
//     const locationFilter = document.getElementById('location-filter').value;
//     const accountFilter = document.getElementById('account-filter').value;

//     // Get all rows in the customer table (you'll need to adjust this to match your table structure)
//     const tableRows = document.querySelectorAll('#customerTable tbody tr');

//     tableRows.forEach(row => {
//         const name = row.querySelector('.customer-name').textContent.toLowerCase();
//         const status = row.querySelector('.account-status').textContent.toLowerCase();
//         const risk = row.querySelector('.risk-tag').textContent.toLowerCase();
//         const location = row.querySelector('.location').textContent.toLowerCase();

//         // Check if the row matches the filters
//         const matchesName = name.includes(nameSearch) || !nameSearch;
//         const matchesStatus = status === statusFilter || !statusFilter;
//         const matchesRisk = risk === riskFilter || !riskFilter;
//         const matchesLocation = location === locationFilter || !locationFilter;

//         // Show or hide the row based on the filters
//         if (matchesName && matchesStatus && matchesRisk && matchesLocation) {
//             row.style.display = '';
//         } else {
//             row.style.display = 'none';
//         }
//     });
// }


const customerData = [
    {
        name: "John Doe",
        contact: "john.doe@example.com",
        status: "Active",
        accountType: "Checking Account",
        churnPrediction: 0.85,
        risk: "Medium Risk",
        detailsLink: "#/customer-detail/1",
        location: "Ghana"
    },
    {
        name: "Jane Smith",
        contact: "jane.smith@example.com",
        status: "Inactive",
        accountType: "Credit Card",
        churnPrediction: 0.95,
        risk: "High Risk",
        detailsLink: "#/customer-detail/2",
        location: "Zimbabwe"
    },
    {
        name: "Alice Brown",
        contact: "alice.brown@example.com",
        status: "Active",
        accountType: "Savings Account",
        churnPrediction: 0.75,
        risk: "Low Risk",
        detailsLink: "#/customer-detail/3",
        location: "US"
    }
];

// Function to dynamically populate the table
function populateCustomerTable(customers) {
    const tbody = document.getElementById('customer-table-body');
    tbody.innerHTML = ''; // Clear existing rows

    customers.forEach(customer => {
        const row = document.createElement('tr');

        row.innerHTML = `
            <td data-label="Name">${customer.name}</td>
            <td data-label="Location">${customer.location}</td>
            <td data-label="Account Status" style="color: ${
                customer.status === 'Active' ? 'green' : 'red'
            }">${customer.status}</td>
            <td data-label="Account Type">${customer.accountType}</td>
            <td data-label="Churn Prediction">${customer.churnPrediction}</td>
            <td data-label="Tags">
                <span class="tag ${
                    customer.risk.toLowerCase().replace(' ', '-')
                }">${customer.risk}</span>
                <button class="btn btn-sm btn-primary follow-up-btn" onclick="followUp('${customer.name}')">Follow Up</button>
            </td>
            <td data-label="Actions"><a href="${customer.detailsLink}">View Details</a></td>
        `;
        tbody.appendChild(row);
    });
}

// Load more customers dynamically
function loadMoreCustomers() {
    const additionalCustomers = [
        {
            name: "Chris Evans",
            contact: "chris.evans@example.com",
            status: "Inactive",
            accountType: "Savings Account",
            churnPrediction: 0.88,
            risk: "High Risk",
            detailsLink: "#/customer-detail/4"
        },
        {
            name: "Natasha Romanoff",
            contact: "natasha.romanoff@example.com",
            status: "Active",
            accountType: "Credit Card",
            churnPrediction: 0.60,
            risk: "Medium Risk",
            detailsLink: "#/customer-detail/5"
        }
    ];
    customerData.push(...additionalCustomers);
    populateCustomerTable(customerData);
}

// Follow-Up Action
function followUp(customerName) {
    alert(`Follow-up added for ${customerName}!`);
}

// Initial load
document.addEventListener('DOMContentLoaded', () => {
    populateCustomerTable(customerData);
});





function applyFilters() {
    // Get the values from the filter inputs
    const nameSearch = document.getElementById('name-search').value.trim().toLowerCase();
    const statusFilter = document.getElementById('status-filter').value;
    const riskFilter = document.getElementById('risk-level-filter').value;
    const locationFilter = document.getElementById('location-filter').value;
    const accountFilter = document.getElementById('account-filter').value;

    console.log("Filters applied:");
    console.log("Name:", nameSearch);
    console.log("Account Status:", statusFilter);
    console.log("Risk Level:", riskFilter);
    console.log("Location:", locationFilter);
    console.log("Account Type:", accountFilter);

    // Example: Filter the customer data (assuming `customerData` is your dataset)
    const filteredData = customerData.filter(customer => {
        return (
            (!nameSearch || customer.name.toLowerCase().includes(nameSearch)) &&
            (!statusFilter || customer.status.toLowerCase() === statusFilter) &&
            (!riskFilter || customer.risk.toLowerCase() === riskFilter.toLowerCase()) &&
            (!locationFilter || customer.location.toLowerCase() === locationFilter.toLowerCase()) &&
            (!accountFilter || customer.accountType.toLowerCase() === accountFilter.toLowerCase())
        );
    });

    // Call a function to update the table with the filtered data
    populateCustomerTable(filteredData);
}



