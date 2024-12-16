<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/css/feedback_submission.css">
    <title>Feedback Form</title>

</head>
<body>

    <div class="container">
        <h2 class="text-center">Bank of America</h2>
        <p class="text-center">We value your feedback! Help us improve our services.</p>
        <form action="../actions/customer_feedback.php" method="POST">
            <input type="hidden" name="CustomerID" value="1">
            <!-- Personal Information -->
            <div class="section">
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" class="form-control" id="name" name="name" required placeholder="Your Full Name">
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required placeholder="example@domain.com">
                </div>
            </div>
        
            <!-- Feedback Section -->
            <div class="section">
                <h3>Feedback</h3>
                <div class="form-group">
                    <label for="OverallSatisfaction">How satisfied are you with our services?</label>
                    <select class="form-control" id="OverallSatisfaction" name="OverallSatisfaction" required>
                        <option value="1">1 - Very Poor</option>
                        <option value="2">2 - Poor</option>
                        <option value="3">3 - Average</option>
                        <option value="4">4 - Good</option>
                        <option value="5">5 - Excellent</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="feedbackMessage">Additional Comments</label>
                    <textarea class="form-control" id="feedbackMessage" name="feedbackMessage" rows="4" placeholder="Let us know your thoughts..."></textarea>
                </div>
            </div>
        
            <!-- Issues Faced Section -->
           <!-- Issues Section -->
            <div class="section">
                <h3>Issues Faced</h3>
                <p>Please select the issues you have faced while using our services:</p>
                <div class="form-group">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="issueDelay" name="issues[]" value="Transaction delays">
                        <label class="form-check-label" for="issueDelay">Transaction delays</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="issueFees" name="issues[]" value="Unexpected fees">
                        <label class="form-check-label" for="issueFees">Unexpected fees</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="issueSupport" name="issues[]" value="Poor customer support">
                        <label class="form-check-label" for="issueSupport">Poor customer support</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="issueAccess" name="issues[]" value="Issues with online banking">
                        <label class="form-check-label" for="issueAccess">Issues with online banking</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="issueOther" name="issues[]" value="Other">
                        <label class="form-check-label" for="issueOther">Other</label>
                    </div>
                    <div class="form-group mt-3">
                        <label for="otherIssueDescription">If Other, please describe:</label>
                        <textarea class="form-control" id="otherIssueDescription" name="otherIssueDescription" rows="3" placeholder="Describe your issue here..."></textarea>
                    </div>
                </div>
            </div>

            <!-- Recommendation -->
            <div class="section">
                <div class="form-group">
                    <label for="RecommendationLikelihood">How likely are you to recommend us to a friend or colleague?</label>
                    <select class="form-control" id="RecommendationLikelihood" name="RecommendationLikelihood" required>
                        <option value="1">1 - Not likely</option>
                        <option value="2">2 - Unlikely</option>
                        <option value="3">3 - Neutral</option>
                        <option value="4">4 - Likely</option>
                        <option value="5">5 - Very Likely</option>
                    </select>
                </div>
            </div>
        
            <!-- Follow-up -->
            <div class="section">
                <div class="form-group">
                    <label for="followUpContact">Would you like to be contacted about your feedback?</label>
                    <select class="form-control" id="followUpContact" name="followUpContact" required>
                        <option value="yes">Yes</option>
                        <option value="no">No</option>
                    </select>
                </div>
            </div>
        
            <!-- Submit Button -->
            <button type="submit" class="btn btn-primary d-block mx-auto">Submit Feedback</button>
        </form>
    </div>

</body>
</html>
