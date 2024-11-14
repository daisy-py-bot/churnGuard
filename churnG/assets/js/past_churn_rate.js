// Chart.js for Monthly Churn Rates
const monthlyChurnCtx = document.getElementById('monthlyChurnChart').getContext('2d');
new Chart(monthlyChurnCtx, {
    type: 'line',
    data: {
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        datasets: [{
            label: 'Churn Rate (%)',
            data: [5, 6, 4, 7, 5, 8, 6, 9, 5, 7, 6, 8], // Example data
            borderColor: 'rgba(75, 192, 192, 1)',
            fill: false
        }]
    },
    options: {
        responsive: true,
        plugins: { legend: { position: 'top' } },
        scales: { y: { beginAtZero: true } }
    }
});



// Chart.js for Model Performance
const modelPerformanceCtx = document.getElementById('modelPerformanceChart').getContext('2d');
new Chart(modelPerformanceCtx, {
    type: 'radar',
    data: {
        labels: ['Accuracy', 'Precision', 'Recall', 'F1 Score'],
        datasets: [{
            label: 'Model Performance',
            data: [85, 82, 78, 80], // Example data
            backgroundColor: 'rgba(255, 99, 132, 0.2)',
            borderColor: 'rgba(255, 99, 132, 1)',
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        plugins: { legend: { position: 'top' } }
    }
});

