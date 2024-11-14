
    // Initial data for churn prediction per service
    const serviceData = {
        labels: ["Savings Account", "Checking Account", "Credit Card"],
        datasets: [{
            label: 'Churn Prediction (%)',
            data: [20, 35, 15], // Initial churn rates (adjust as needed)
            backgroundColor: ['#f44336', '#ffa726', '#42a5f5'],
        }]
    };

    // Configure the chart
    const service_chart = document.getElementById('customerServiceChart').getContext('2d');
    const customerServiceChart = new Chart(service_chart, {
        type: 'bar',
        data: serviceData,
        options: {
            indexAxis: 'y', // Make it horizontal
            scales: {
                x: {
                    beginAtZero: true,
                    max: 100 // Assume churn rate is a percentage (0-100%)
                }
            },
            plugins: {
                legend: {
                    display: false
                }
            }
        }
    });

    // Function to update the chart data at intervals
    function updateChartData() {
        customerServiceChart.data.datasets[0].data = [
            Math.floor(Math.random() * 100), // Savings Account churn rate
            Math.floor(Math.random() * 100), // Checking Account churn rate
            Math.floor(Math.random() * 100)  // Credit Card churn rate
        ];
        customerServiceChart.update();
    }

    // Set interval to update chart data every 5 seconds
    setInterval(updateChartData, 5000);