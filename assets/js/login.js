document.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector("form");

    form.addEventListener("submit", async (event) => {
        event.preventDefault(); // Prevent form submission

        // Retrieve input values
        const email = document.getElementById("email").value.trim();
        const password = document.getElementById("password").value.trim();

        // Client-side validation
        if (!email || !password) {
            alert("All fields are required.");
            return;
        }

        if (!validateEmail(email)) {
            alert("Please enter a valid email address.");
            return;
        }

        // Prepare data for the POST request
        const requestData = {
            email: email,
            password: password,
        };

        try {
            // Send POST request to the login endpoint
            const response = await fetch("../actions/login.php", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                },
                body: JSON.stringify(requestData),
            });

            // Parse the response
            const result = await response.json();

            if (response.ok) {
                alert(result.message);
                if (result.redirect) {
                    window.location.href = result.redirect; // Redirect to the dashboard
                }
            } else {
                alert(result.message || "Login failed. Please try again.");
            }
        } catch (error) {
            console.error("Error:", error);
            alert("An error occurred. Please try again later.");
        }
    });

    // Email validation function
    function validateEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }
});
