// customers_comments.js

// Fetch the customer reviews from the API endpoint
fetch('../db/customer_comments.php')
    .then(response => response.json())
    .then(data => {
        const feedbackContainer = document.querySelector('.feedback-list');

        // Clear existing feedback items (if any)
        feedbackContainer.innerHTML = '';

        // Loop through the fetched reviews and create HTML elements for each
        data.forEach(review => {
            const feedbackItem = document.createElement('div');
            feedbackItem.classList.add('feedback-item');

            // Apply styling based on sentiment
            if (review.sentiment === 'Positive') {
                feedbackItem.classList.add('positive-feedback');
            } else if (review.sentiment === 'Negative') {
                feedbackItem.classList.add('negative-feedback');
            } else {
                feedbackItem.classList.add('neutral-feedback');
            }

            // Set the feedback text
            feedbackItem.innerHTML = `"${review.comment}" - ${review.customer_name}`;

            // Append the feedback item to the feedback list
            feedbackContainer.appendChild(feedbackItem);
        });
    })
    .catch(error => console.error('Error fetching customer reviews:', error));
