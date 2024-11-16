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
