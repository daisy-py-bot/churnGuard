
const feedbackData = [
    {
        id: 1,
        name: "John Doe",
        date: "2024-11-12",
        type: "Complaint",
        description: "The product arrived damaged and the support team has not responded.",
        priority: "High",
        followUp: false,
        resolved: false,
    },
    {
        id: 2,
        name: "Jane Smith",
        date: "2024-11-10",
        type: "Positive",
        description: "Excellent customer service! Keep up the great work.",
        priority: "Low",
        followUp: true,
        resolved: true,
    },
];

// Function to render feedback table
function renderFeedbackTable(data) {
    const tableBody = document.getElementById("feedback-table-body");
    tableBody.innerHTML = ""; // Clear table

    data.forEach((feedback) => {
        const row = document.createElement("tr");

        row.innerHTML = `
            <td>${feedback.id}</td>
            <td>${feedback.name}
            <button class="btn btn-secondary" onclick="goToCustomerDetails(${feedback.id})">View</button>
            </td>
            <td>${feedback.date}</td>
            <td>${feedback.type}</td>
            <td>
                <button class="btn btn-info" onclick="viewDescription('${feedback.description}')">View</button>
            </td>
            <td>${feedback.priority}</td>
            <td>${feedback.followUp ? "Yes" : "No"}</td>
            <td>${feedback.resolved ? "Resolved" : "Not Resolved"}</td>
            <td>
                <button class="btn btn-success" onclick="markResolved(${feedback.id})">Mark Resolved</button>
                <button class="btn btn-warning" onclick="togglePriority(${feedback.id})">${feedback.priority === "High" ? "Mark Low Priority" : "Mark High Priority"}</button>
                <button class="btn btn-danger" onclick="removeFeedback(${feedback.id})">Remove</button>
                
            </td>
        `;

        tableBody.appendChild(row);
    });
}

// View full description in a modal or alert
// function viewDescription(description) {
//     alert(`Feedback Description: ${description}`);
// }

// Apply Filters and Sorting
function applyFeedbackFilters() {
    const typeFilter = document.getElementById("feedback-type-filter").value;
    const followUpFilter = document.getElementById("follow-up-filter").value;
    const resolutionFilter = document.getElementById("resolution-filter").value;
    const dateSort = document.getElementById("date-sort").value;
    const prioritySort = document.getElementById("priority-sort").value;

    let filteredData = feedbackData;

    // Filter by Type
    if (typeFilter) {
        filteredData = filteredData.filter((f) =>
            typeFilter === "positive" ? f.type === "Positive" : f.type === "Complaint"
        );
    }

    // Filter by Follow-Up
    if (followUpFilter) {
        filteredData = filteredData.filter((f) =>
            followUpFilter === "followed-up" ? f.followUp : !f.followUp
        );
    }

    // Filter by Resolution
    if (resolutionFilter) {
        filteredData = filteredData.filter((f) =>
            resolutionFilter === "resolved" ? f.resolved : !f.resolved
        );
    }

    // Sort by Date
    if (dateSort) {
        filteredData.sort((a, b) => 
            dateSort === "recent" ? new Date(b.date) - new Date(a.date) : new Date(a.date) - new Date(b.date)
        );
    }

    // Sort by Priority
    if (prioritySort) {
        const priorityOrder = { High: 1, Medium: 2, Low: 3 };
        filteredData.sort((a, b) =>
            prioritySort === "high"
                ? priorityOrder[a.priority] - priorityOrder[b.priority]
                : priorityOrder[b.priority] - priorityOrder[a.priority]
        );
    }

    renderFeedbackTable(filteredData);
}

// Actions
function markResolved(id) {
    const feedback = feedbackData.find((f) => f.id === id);
    if (feedback) {
        feedback.resolved = true;
        renderFeedbackTable(feedbackData);
    }
}

function togglePriority(id) {
    const feedback = feedbackData.find((f) => f.id === id);
    if (feedback) {
        feedback.priority = feedback.priority === "High" ? "Low" : "High";
        renderFeedbackTable(feedbackData);
    }
}

function removeFeedback(id) {
    const index = feedbackData.findIndex((f) => f.id === id);
    if (index > -1) {
        feedbackData.splice(index, 1);
        renderFeedbackTable(feedbackData);
    }
}

// Initial Render
renderFeedbackTable(feedbackData);

function viewDescription(description) {
    const modal = document.getElementById("description-modal");
    document.getElementById("description-text").textContent = description;
    modal.style.display = "block";
}

function closeModal() {
    document.getElementById("description-modal").style.display = "none";
}
