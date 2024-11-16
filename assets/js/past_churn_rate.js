
    const monthlyChurnCtx = document.getElementById('monthlyChurnChart').getContext('2d');

    // Data for different years
    const churnData = {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'], // x-axis labels
        datasets: [
            {
                label: '2022',
                data: [5, 6, 4, 7, 5, 8, 6, 9, 5, 7, 6, 8], // Churn rates for 2022
                borderColor: 'rgba(75, 192, 192, 1)',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                fill: false,
                tension: 0.3 // Adds slight curve to the line
            },
            {
                label: '2023',
                data: [6, 5, 7, 6, 8, 7, 5, 8, 6, 9, 7, 5], // Churn rates for 2023
                borderColor: 'rgba(255, 99, 132, 1)',
                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                fill: false,
                tension: 0.3
            },
            {
                label: '2024',
                data: [7, 6, 5, 8, 6, 9, 7, 8, 6, 7, 5, 6], // Churn rates for 2024
                borderColor: 'rgba(54, 162, 235, 1)',
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                fill: false,
                tension: 0.3
            }
        ]
    };

    // Initialize the Chart
    new Chart(monthlyChurnCtx, {
        type: 'line',
        data: churnData,
        options: {
            responsive: true,
            plugins: {
                legend: { position: 'top' }, // Place legend at the top
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            return `${context.dataset.label}: ${context.raw}%`;
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
                    min:0,
                    max:10,
                    title: {
                        display: true,
                        text: 'Churn Rate (%)'
                    },
                    beginAtZero: true
                }
            }
        }
    });
