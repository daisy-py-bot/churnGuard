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
            hoverBackgroundColor: ['#f71404', '#ccc6c6'],
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

// Update the churn rate dynamically every 5 seconds
function updateChurnRate(newRate) {
    churnRate = newRate;
    churnGauge.data.datasets[0].data = [churnRate, 100 - churnRate];
    churnGauge.update();

    // Update the text overlay
    document.getElementById('churnRateText').textContent = `${churnRate}%`;
}

// Get the churn rate from the server
function fetchChurnRate() {
    fetch('/api/churn-rate')
        .then(response => response.json())
        .then(data => {
            updateChurnRate(data.churnRate);
        });
}

// updating the churn rate dynamically
setInterval(() => {
    const randomChurnRate = Math.floor(Math.random() * 30) + 10; // Random value for demo purposes
    updateChurnRate(randomChurnRate);

    // Uncomment the line below to fetch the churn rate from the server
    // fetchChurnRate(); // get the churn rate from the server
}, 5000);



// dummy function that updates the churn rates in the server for every customer
// randomly generate 10 customer IDs and update their churn rates
// churn rates are randomly generated between 10 and 40
// send a json object with the customer ID and churn rate to the server
// function updateChurnRates() {
//     const customerIds = Array.from({ length: 10 }, () => Math.floor(Math.random() * 100) + 1);
//     customerIds.forEach(id => {
//         const churnRate = Math.floor(Math.random() * 30) + 10;
//         fetch('/api/update-churn-rate', {
//             method: 'POST',
//             headers: { 'Content-Type': 'application/json' },
//             body: JSON.stringify({ id, churnRate })
//         });
//     });
// }

// set the interval to update the churn rates
// setInterval(updateChurnRates, 10000); // Update churn rates every 10 seconds
