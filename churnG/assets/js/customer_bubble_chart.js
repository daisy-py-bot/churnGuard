// Sample data for customers (you would typically load this from an API or database)
const customerData = [
    { name: 'Alice', satisfaction: 0.9, tenure: 5, churn: 0.8, service: 'Savings Account', ageGroup: '25-34', location: 'USA' },
    { name: 'Bob', satisfaction: 0.6, tenure: 2, churn: 0.3, service: 'Checking Account', ageGroup: '35-44', location: 'Canada' },
    { name: 'Charlie', satisfaction: 0.75, tenure: 4, churn: 0.7, service: 'Savings Account', ageGroup: '45-54', location: 'UK' },
    { name: 'David', satisfaction: 0.4, tenure: 3, churn: 0.21, service: 'Savings Account', ageGroup: '55+', location: 'Australia' },
    { name: 'Eva', satisfaction: 0.8, tenure: 7, churn: 0.5, service: 'Checking Account', ageGroup: '25-34', location: 'USA' },
    { name: 'Frank', satisfaction: 0.5, tenure: 1, churn: 0.65, service: 'Other', ageGroup: '35-44', location: 'Canada' },
    { name: 'Grace', satisfaction: 0.55, tenure: 2, churn: 0.4, service: 'Checking Account', ageGroup: '45-54', location: 'UK' },
    { name: 'Boby', satisfaction: 0.6, tenure: 6, churn: 0.1, service: 'Checking Account', ageGroup: '35-44', location: 'Canada' },
    { name: 'Charlies', satisfaction: 0.75, tenure: 5, churn: 0.7, service: 'Savings Account', ageGroup: '45-54', location: 'UK' },
    { name: 'David', satisfaction: 0.4, tenure: 3, churn: 0.9, service: 'Savings Account', ageGroup: '55+', location: 'Australia' },
    { name: 'Evlyn', satisfaction: 0.3, tenure: 1, churn: 0.5, service: 'Checking Account', ageGroup: '25-34', location: 'USA' },
    { name: 'Frank J', satisfaction: 0.65, tenure: 8, churn: 0.6, service: 'Other', ageGroup: '35-44', location: 'Canada' },
    { name: 'Gracious', satisfaction: 0.15, tenure: 2, churn: 0.4, service: 'Checking Account', ageGroup: '45-54', location: 'UK' },
    { name: 'Helen', satisfaction: 0.5, tenure: 6, churn: 0.2, service: 'Savings Account', ageGroup: '25-34', location: 'Australia' }
];

// Initial chart data setup
const customerChurn = document.getElementById('customer-chart').getContext('2d');
let customerChart = null; // Global variable to hold the chart instance

// Function to get the color for the service type
const getColor = (service) => {
    if (service === 'Savings Account') return 'green';
    if (service === 'Checking Account') return 'blue';
    return 'gray'; // For 'Other' or undefined service types
};

// Function to filter customers based on the threshold
function filterCustomers(threshold) {
    return customerData.filter(customer => customer.churn > threshold);
}

// Function to update the chart based on the selected threshold
function updateChart(threshold) {
    // Destroy the previous chart if it exists
    if (customerChart) {
        customerChart.destroy();
    }

    const filteredData = filterCustomers(threshold);
    
    // Extract the filtered data for plotting
    const xData = filteredData.map(customer => customer.satisfaction); // Satisfaction
    const yData = filteredData.map(customer => customer.tenure); // Tenure
    const sizeData = filteredData.map(customer => customer.churn * 10); // Churn prediction (scaled for size)
    const colorData = filteredData.map(customer => getColor(customer.service)); // Service color

    // Create or update the chart
    customerChart = new Chart(customerChurn, {
        type: 'bubble',
        data: {
            datasets: [{
                label: 'Customers',
                data: xData.map((x, index) => ({
                    x: x,
                    y: yData[index],
                    r: sizeData[index],
                    customer: filteredData[index] // Add customer data here for tooltip
                })),
                backgroundColor: colorData,
                borderColor: colorData,
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                x: {
                    min: 0,
                    max: 1,
                    title: {
                        display: true,
                        text: 'Satisfaction Score'
                    }
                },
                y: {
                    min: 0,
                    max: 10,
                    title: {
                        display: true,
                        text: 'Tenure (Years)'
                    }
                }
            },
            plugins: {
                tooltip: {
                    callbacks: {
                        // Custom tooltip content
                        label: function (context) {
                            const customer = context.raw.customer; // Access the customer data
                            return [
                                `Name: ${customer.name}`,
                                `Age Group: ${customer.ageGroup}`,
                                `Location: ${customer.location}`,
                                `Churn Prediction: ${(customer.churn * 100).toFixed(2)}%`
                            ];
                        }
                    }
                }
            }
        }
    });
}

// Initialize chart with default threshold
updateChart(0.5);

// Event listener to update chart when the threshold slider is changed
document.getElementById('churn-threshold').addEventListener('input', (e) => {
    const threshold = parseFloat(e.target.value);
    document.getElementById('threshold-value').textContent = threshold.toFixed(2);
    updateChart(threshold);
});
