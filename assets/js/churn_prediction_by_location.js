// get the labels from the locations on the server
// get the average churn rate per the locations on the server

    // Initial data for churn prediction per service
    const locationData = {
        labels: ["Ghana", "Zimbabwe", "USA"],
        datasets: [{
            label: 'Churn Prediction (%)',
            data: [20, 35, 15], // Initial churn rates (adjust as needed)
            backgroundColor: ['#f44336', '#ffa726', '#42a5f5'],
        }]
    };

    // Configure the chart
    const location_chart = document.getElementById('customerLocationChart').getContext('2d');
    const customerlocationChart = new Chart(location_chart, {
        type: 'bar',
        data: locationData,
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
        customerlocationChart.data.datasets[0].data = [
            Math.floor(Math.random() * 100), // Savings Account churn rate
            Math.floor(Math.random() * 100), // Checking Account churn rate
            Math.floor(Math.random() * 100)  // Credit Card churn rate
        ];
        customerlocationChart.update();
    }

    // Set interval to update chart data every 5 seconds
    setInterval(updateChartData, 5000);