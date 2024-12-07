document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form");

    form.addEventListener("submit", async function (event) {
        event.preventDefault(); // Prevent default form submission

        // Get form values
        const firstname = document.getElementById("firstname").value.trim();
        const lastname = document.getElementById("lastname").value.trim();
        const email = document.getElementById("email").value.trim();
        const password = document.getElementById("password").value.trim();
        const confirmPassword = document.getElementById("confirmPassword").value.trim();

        // Basic validation
        if (!firstname || !lastname || !email || !password || !confirmPassword) {
            alert("All fields are required!");
            return;
        }

        if (!validateEmail(email)) {
            alert("Please enter a valid email address.");
            return;
        }

        if (password !== confirmPassword) {
            alert("Passwords do not match.");
            return;
        }

        // Password validation
        if (!validatePassword(password)) {
            alert("Password must be at least 8 characters long, contain at least one uppercase letter, and one special character.");
            return;
        }

        try {
            // Prepare data for the API
            const data = {
                firstname,
                lastname,
                email,
                password
            };

            // Send POST request to the server
            const response = await fetch("../actions/register.php", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(data)
            });

            const result = await response.json();

            if (response.ok) {
                alert(result.message);
                if (result.redirect) {
                    window.location.href = result.redirect;
                }
            } 
            else {
                alert(result.message || "An error occurred while registering.");
            }
        } 
        catch (error) {
            console.error("Error:", error);
            alert("An error occurred. Please try again later.");
        }
    });

    // Helper function to validate email
    function validateEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    // Helper function to validate password
    function validatePassword(password) {
        const passwordRegex = /^(?=.*[A-Z])(?=.*[\W_]).{8,}$/;
        return passwordRegex.test(password);
    }
});
