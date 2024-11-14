// Churn gauge chart

const ctx = document.getElementById('churnRateGauge').getContext('2d');

// Set initial churn rate value
let churnRate = 15; // Example starting value

// Create the gauge chart
const churnGauge = new Chart(ctx, {
    type: 'doughnut',
    data: {
        labels: ['Churn Rate', 'Remaining'],
        datasets: [{
            data: [churnRate, 100 - churnRate], // Churn rate and remainder
            backgroundColor: ['#f44336', '#ddd'],
            hoverBackgroundColor: ['#f44336', '#ddd'],
            borderWidth: 0
        }]
    },
    options: {
        rotation: 1 * Math.PI, // Start angle for half-circle
        circumference: 1 * Math.PI, // End angle for half-circle
        cutout: '80%', // Makes the doughnut shape
        responsive: true,
        plugins: {
            tooltip: { enabled: false } // Disable tooltips
        }
    }
});

// Update the churn rate dynamically (e.g., every 5 seconds)
function updateChurnRate(newRate) {
    churnRate = newRate;
    churnGauge.data.datasets[0].data = [churnRate, 100 - churnRate];
    churnGauge.update();

    // Update the text overlay
    document.getElementById('churnRateText').textContent = `${churnRate}%`;
}

// Example of updating the churn rate dynamically
setInterval(() => {
    const randomChurnRate = Math.floor(Math.random() * 30) + 10; // Random value for demo purposes
    updateChurnRate(randomChurnRate);
}, 5000);
