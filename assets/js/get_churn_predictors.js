// Function to dynamically update the churn predictors
function updateChurnPredictors(factors) {
    // Get the container element
    const container = document.getElementById('top-churn-predictors');

    // Clear the existing bubbles
    container.innerHTML = '';

    // Add new bubbles for each factor
    factors.forEach(factor => {
        const bubble = document.createElement('div');
        bubble.className = 'factor-bubble'; // Add the CSS class for styling
        bubble.textContent = factor; // Set the text content of the bubble
        container.appendChild(bubble); // Append the bubble to the container
    });
}

// Example: New factors to display
const newFactors = [
    'Unfriendly staff',
    'Inconvenient app',
    'High maintenance costs',
    'No reward programs',
    'Inconsistent service',
    'Delayed response',
    'Limited features',
    'High-interest rates'
];

// Call the function to update the predictors
updateChurnPredictors(newFactors);

// Optional: Simulate dynamic updates after a delay
setTimeout(() => {
    const updatedFactors = [
        'Poor mobile experience',
        'Long wait times',
        'Unclear policies',
        'Better rates elsewhere',
        'Service outages'
    ];
    updateChurnPredictors(updatedFactors);
}, 30000); // Update after 30 seconds
