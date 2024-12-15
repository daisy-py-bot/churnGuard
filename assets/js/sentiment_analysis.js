


// Declare the chart globally
let sentimentTrendChart;

document.addEventListener("DOMContentLoaded", function() {
    const sentiment = document.getElementById('sentimentTrendChart').getContext('2d');
    sentimentTrendChart = new Chart(sentiment, {
        type: 'line',
        data: {
            labels: [], // Initially empty, will be updated after data is fetched
            datasets: [
                {
                    label: 'Positive',
                    data: [],
                    borderColor: 'green',
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    fill: false,
                    tension: 0.3 // Adds slight curve to the line
                },
                {
                    label: 'Neutral',
                    data: [],
                    borderColor: 'gray',
                    backgroundColor: 'rgba(201, 203, 207, 0.2)',
                    fill: false,
                    tension: 0.3
                },
                {
                    label: 'Negative',
                    data: [],
                    borderColor: 'red',
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    fill: false,
                    tension: 0.3
                }
            ]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top',
                },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            return `${context.dataset.label}: ${context.raw}`;
                        }
                    }
                }
            },
            scales: {
                x: {
                    title: {
                        display: true,
                        text: 'Month'
                    },
                    ticks: {
                        color: 'white' // Set x-axis label color to white
                
                    } 
                },
                y: {
                    title: {
                        display: true,
                        text: 'Sentiment Count'
                    },
                    beginAtZero: true,
                    ticks: {
                        color: 'white' // Set x-axis label color to white
                
                    }
                }
            }
        }
    });

    // Handle year selection
    document.getElementById('yearFilter').addEventListener('change', function() {
        const selectedYear = this.value;
        fetchSentimentData(selectedYear);
    });

    // Fetch sentiment data from server
    function fetchSentimentData(year) {
        // Send a GET request to the PHP endpoint with the year as a query parameter
        fetch(`../db/view_sentiments.php?year=${year}`)
            .then(response => response.json())
            .then(data => {
                // Update the chart with the fetched data
                updateSentimentChart(data);
            })
            .catch(error => console.error('Error fetching sentiment data:', error));
    }

    // Update the chart with new data
    function updateSentimentChart(data) {
        sentimentTrendChart.data.labels = data.months;  // Update months (x-axis)

        sentimentTrendChart.data.datasets[0].data = data.positive;  // Positive sentiment
        sentimentTrendChart.data.datasets[1].data = data.neutral;   // Neutral sentiment
        sentimentTrendChart.data.datasets[2].data = data.negative;  // Negative sentiment

        sentimentTrendChart.update();  // Refresh the chart
    }

    // Fetch data for the current year when the page loads
    const currentYear = new Date().getFullYear();
    fetchSentimentData(currentYear);
});
