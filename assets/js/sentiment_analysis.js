const sentimentDataByYear = {
    2023: {
        months: ["January", "February", "March", "April", "May", "June"],
        positive: [30, 45, 40, 50, 55, 60],
        neutral: [20, 25, 30, 35, 30, 25],
        negative: [10, 15, 20, 18, 16, 20]
    },
    2024: {
        months: ["January", "February", "March", "April", "May", "June"],
        positive: [35, 50, 45, 55, 60, 65],
        neutral: [15, 20, 25, 30, 25, 20],
        negative: [5, 10, 15, 12, 10, 15]
    },
    2025: {
        months: ["January", "February", "March", "April", "May", "June"],
        positive: [40, 55, 50, 60, 65, 70],
        neutral: [10, 15, 20, 25, 20, 15],
        negative: [0, 5, 10, 8, 5, 10]
    }
};

// Declare the chart globally
let sentimentTrendChart;

document.addEventListener("DOMContentLoaded", function() {
    const sentiment = document.getElementById('sentimentTrendChart').getContext('2d');
    sentimentTrendChart = new Chart(sentiment, {
        type: 'line',
        data: {
            labels: sentimentDataByYear[2023].months,
            datasets: [
                {
                    label: 'Positive',
                    data: sentimentDataByYear[2023].positive,
                    borderColor: 'rgba(75, 192, 192, 1)',
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    fill: false,
                    tension: 0.3 // Adds slight curve to the line
                },
                {
                    label: 'Neutral',
                    data: sentimentDataByYear[2023].neutral,
                    borderColor: 'rgba(201, 203, 207, 1)',
                    backgroundColor: 'rgba(201, 203, 207, 0.2)',
                    fill: false,
                    tension: 0.3
                },
                {
                    label: 'Negative',
                    data: sentimentDataByYear[2023].negative,
                    borderColor: 'rgba(255, 99, 132, 1)',
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
                    }
                },
                y: {
                    title: {
                        display: true,
                        text: 'Sentiment Count'
                    },
                    beginAtZero: true
                }
            }
        }
    });

    // Handle year selection
    document.getElementById('yearFilter').addEventListener('change', function() {
        const selectedYear = this.value;
        const newData = sentimentDataByYear[selectedYear];
        updateSentimentChart(newData);
    });
});

function updateSentimentChart(newData) {
    // Update the chart's labels (x-axis)
    sentimentTrendChart.data.labels = newData.months;

    // Update each dataset's data
    sentimentTrendChart.data.datasets[0].data = newData.positive; // Positive sentiment
    sentimentTrendChart.data.datasets[1].data = newData.neutral;  // Neutral sentiment
    sentimentTrendChart.data.datasets[2].data = newData.negative; // Negative sentiment

    // Refresh the chart
    sentimentTrendChart.update();
}
