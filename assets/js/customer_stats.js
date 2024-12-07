document.addEventListener('DOMContentLoaded', function() {
    // Fetch user stats when the page loads
    fetchUserStats();
});

function fetchUserStats() {
    fetch('../db/customer_stats.php')
        .then(response => response.json())
        .then(data => {
            // Update the HTML elements with the fetched data
            document.getElementById('total-customers').innerText = data.total_customers;
            document.getElementById('total-accounts').innerText = data.total_accounts;
            document.getElementById('avg-age').innerText = data.avg_age + ' years';
            document.getElementById('churn-rate').innerText = data.avg_churn_rate + '%';
            document.getElementById('avg-tenure').innerText = data.avg_tenure + ' years';
        })
        .catch(error => {
            console.error('Error fetching user stats:', error);
        });
}
