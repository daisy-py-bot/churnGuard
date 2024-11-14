const sentimentData = {
    months: ["January", "February", "March", "April", "May", "June"],  // x-axis labels
    positive: [30, 45, 40, 50, 55, 60],    // Positive sentiment counts
    neutral: [20, 25, 30, 35, 30, 25],     // Neutral sentiment counts
    negative: [10, 15, 20, 18, 16, 20]     // Negative sentiment counts
};

document.addEventListener("DOMContentLoaded", function() {
    const sentiment = document.getElementById('sentimentTrendChart').getContext('2d');
    const sentimentTrendChart = new Chart(sentiment, {
        type: 'line',
        data: {
            labels: sentimentData.months,
            datasets: [
                {
                    label: 'Positive',
                    data: sentimentData.positive,
                    borderColor: 'rgba(75, 192, 192, 1)',
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    fill: false,
                    tension: 0.3 // Adds slight curve to the line
                },
                {
                    label: 'Neutral',
                    data: sentimentData.neutral,
                    borderColor: 'rgba(201, 203, 207, 1)',
                    backgroundColor: 'rgba(201, 203, 207, 0.2)',
                    fill: false,
                    tension: 0.3
                },
                {
                    label: 'Negative',
                    data: sentimentData.negative,
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
});
