
const churnRateGaugeCtx = document.getElementById('churnRateGauge').getContext('2d');
const customerLocationCtx = document.getElementById('customerLocationChart').getContext('2d');
const customerServiceCtx = document.getElementById('customerServiceChart').getContext('2d');

// Initialize charts
let churnRateGauge = new Chart(churnRateGaugeCtx, {
    type: 'doughnut',
    data: {
        labels: ['Churn Rate', 'Remaining'],
        datasets: [{
            data: [0, 100],
            backgroundColor: ['#f44336', '#ddd'],
        }]
    },
    options: {
        rotation: 1 * Math.PI,
        circumference: 1 * Math.PI,
        cutout: '80%',
        responsive: true,
        plugins: { tooltip: { enabled: false } }
    }
});

let customerLocationChart = new Chart(customerLocationCtx, {
    type: 'bar',
    data: {
        labels: [],
        datasets: [{
            label: 'Churn Prediction (%)',
            data: [],
            backgroundColor: ['#f44336', '#ffa726', '#42a5f5'],
        }]
    },
    options: {
        indexAxis: 'y',
        scales: { x: { beginAtZero: true, max: 100 } },
        plugins: { legend: { display: false } }
    }
});

let customerServiceChart = new Chart(customerServiceCtx, {
    type: 'bar',
    data: {
        labels: [],
        datasets: [{
            label: 'Churn Prediction (%)',
            data: [],
            backgroundColor: ['#f44336', '#ffa726', '#42a5f5'],
        }]
    },
    options: {
        indexAxis: 'y',
        scales: { x: { beginAtZero: true, max: 100 } },
        plugins: { legend: { display: false } }
    }
});

// Fetch churn data and update charts
function fetchChurnData() {
    fetch('../db/view_churn_predictions.php')
        .then(response => response.json())
        .then(data => {
            // Update overall churn gauge
            churnRateGauge.data.datasets[0].data = [data.overall, 100 - data.overall];
            churnRateGauge.update();

            // Update location chart
            customerLocationChart.data.labels = Object.keys(data.byLocation);
            customerLocationChart.data.datasets[0].data = Object.values(data.byLocation);
            customerLocationChart.update();

            // Update service chart
            customerServiceChart.data.labels = Object.keys(data.byAccountType);
            customerServiceChart.data.datasets[0].data = Object.values(data.byAccountType);
            customerServiceChart.update();
        })
        .catch(error => console.error('Error fetching churn data:', error));
}

// Set interval to fetch data every 10 seconds
setInterval(fetchChurnData, 10000);

// Fetch initial data
fetchChurnData();
