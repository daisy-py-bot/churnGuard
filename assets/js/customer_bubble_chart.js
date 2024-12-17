



// Initial chart data setup
const customerChurn = document.getElementById('customer-chart').getContext('2d');
let customerChart = null; // Global variable to hold the chart instance



// Define color mapping for services
const serviceColors = {
    'Savings': '#FFD700',  // Gold
    'Checking': '#32CD32', // Green
    'Credit Card': '#42a5f5' // Light Blue 
};
// Function to get the color for the service type (updated)
const getColor = (service) => {
    return serviceColors[service] || '#42a5f5'; // Default to Light Blue if service is unknown
};



// Function to fetch customer data from the server
async function fetchCustomerData() {
    try {
        const response = await fetch('../db/bubble_chart_data.php'); // Replace with your actual endpoint
        const data = await response.json();
        return data;
    } catch (error) {
        console.error('Error fetching customer data:', error);
        return []; // Return an empty array in case of error
    }
}

// Function to filter customers based on the threshold
function filterCustomers(customers, threshold) {
    return customers.filter(customer => customer.churn >= threshold);
}

// Function to update the chart based on the selected threshold
async function updateChart(threshold) {
    // Fetch the latest customer data
    const customerData = await fetchCustomerData();

    // Destroy the previous chart if it exists
    if (customerChart) {
        customerChart.destroy();
    }

    const filteredData = filterCustomers(customerData, threshold);

    // Extract the filtered data for plotting
    const xData = filteredData.map(customer => customer.satisfaction); // Satisfaction
    const yData = filteredData.map(customer => customer.tenure); // Tenure
    const sizeData = filteredData.map(customer => customer.churn * 15); // Churn prediction (scaled for size)
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
                    max: 6, 
                    title: {
                        display: true,
                        text: 'Satisfaction Score'
                    },
                    ticks: {
                        color: 'white' // Set x-axis label color to white
                    }
                },
                y: {
                    min: 0,
                    max: 10, // Adjust this based on your data range
                    title: {
                        display: true,
                        text: 'Tenure (Years)'
                    },
                    ticks: {
                        color: 'white' // Set y-axis label color to white
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
            },
            legend: {
                display: false,
                
            }
        }
    });
     // Add custom legend to the page (outside the chart)
     addCustomLegend();
}

// Initialize chart with default threshold
updateChart(0.5);

// Event listener to update chart when the threshold slider is changed
document.getElementById('churn-threshold').addEventListener('input', (e) => {
    const threshold = parseFloat(e.target.value);
    document.getElementById('threshold-value').textContent = threshold.toFixed(2);
    updateChart(threshold);
});


// Function to add a custom legend outside the chart
function addCustomLegend() {
    const legendContainer = document.getElementById('custom-legend'); // A div where you want the legend to appear
    legendContainer.innerHTML = ''; // Clear previous legend

    for (const service in serviceColors) {
        const color = serviceColors[service];
        const legendItem = document.createElement('div');
        legendItem.style.display = 'inline-block';
        legendItem.style.marginRight = '15px';
        legendItem.innerHTML = `
            <span style="background-color: ${color}; width: 20px; height: 20px; display: inline-block; margin-right: 5px;"></span>
            <span>${service}</span>
        `;
        legendContainer.appendChild(legendItem);
    }
}