// Chart.js example for churn summary (mockup)
// const churn_summary = document.getElementById('churnChart').getContext('2d');
// new Chart(churn_summary, {
//     type: 'line',
//     data: {
//         labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
//         datasets: [{
//             label: 'Churn Rate',
//             data: [3, 5, 2, 8, 6, 7],
//             // backgroundColor: 'rgba(22, 59, 171, 0.2)',
//             backgroundColor: '#f9f9f9',
//             borderColor: 'rgb(22, 59, 171)',
//             borderWidth: 2
//         }]
//     }
// });


document.addEventListener('DOMContentLoaded', function () {
    const churn_summary = document.getElementById('churnChart').getContext('2d');

    // Fetch churn data from the PHP endpoint
    fetch('../db/churn_summary.php')
        .then(response => response.json())
        .then(data => {
            if (data.error) {
                console.error(data.error);
                return;
            }

            // Initialize Chart.js with the data
            new Chart(churn_summary, {
                type: 'line',
                data: {
                    labels: data.months, // Use months from the response
                    datasets: [{
                        label: 'Churn Rate',
                        data: data.churned_customers, // Use churned customers from the response
                        backgroundColor: '#f9f9f9',
                        borderColor: 'rgb(22, 59, 171)',
                        borderWidth: 2
                    }]
                }
            });
        })
        .catch(error => {
            console.error('Error fetching churn data:', error);
        });
});
