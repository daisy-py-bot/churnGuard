


let data

// Fetch data from the server
async function fetchFeedbackData() {
    try {
        const response = await fetch("../db/customer_complaints.php");
        if (!response.ok) {
            throw new Error("Failed to fetch feedback data");
        }
        data = await response.json();
        renderFeedbackTable(data); // Render the fetched data into the table
    } catch (error) {
        console.error("Error fetching feedback data:", error);
        alert("Unable to load feedback data. Please try again later.");
    }
}

// Function to render feedback table
function renderFeedbackTable(data) {
    const tableBody = document.getElementById("feedback-table-body");
    tableBody.innerHTML = ""; // Clear table

    data.forEach((feedback) => {
        const row = document.createElement("tr");
        row.setAttribute("data-id", feedback.id); // Add a data-id for easy targeting
       
        row.innerHTML = `
            <td>${feedback.id}</td>
            <td>${feedback.name}</td>
            <td>${feedback.ComplaintDate}</td>
            <td>${feedback.description}</td>
            <td>
                <span class="priority">${feedback.priority}</span> 
            </td>

            <td>
                <span class="resolved">${feedback.resolved ? "Resolved" : "Not Resolved"}</span> 
            </td>
            <td>${feedback.ResolvedDate ? feedback.ResolvedDate : "Unresolved"}</td
            <td>
                <button class="btn btn-success" onclick="markResolved(${feedback.id})">Mark Resolved</button>
                <select class="form-control" onchange="changePriority(${feedback.id}, this.value)">
                    <option value="Low" ${feedback.priority === "Low" ? "selected" : ""}>Low</option>
                    <option value="Medium" ${feedback.priority === "Medium" ? "selected" : ""}>Medium</option>
                    <option value="High" ${feedback.priority === "High" ? "selected" : ""}>High</option>
                </select>
                <button class="btn btn-danger" onclick="removeFeedback(${feedback.id})">Remove</button>
            </td>



        `;

        tableBody.appendChild(row);
    });
}

// Actions


async function markResolved(id) {
    // alert("resolve: ", id)
    console.log(id, "resolve")
    if (confirm('Do you really want to mark this issue as resolved?')) {
        // Find the row with the corresponding data-id
        const row = document.querySelector(`tr[data-id="${id}"]`);
        const resolvedCell = row.querySelector('.resolved');
        console.log(resolvedCell)
        console.log(row)
        try {
            const response = await fetch("../actions/mark_issue_resolved.php", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded",
                },
                body: `complaintID=${id}`,
            });

            const result = await response.json();

            if (result.success) {
                // Update the UI
                resolvedCell.textContent = 'Resolved'; 
                const feedback = data.find((f) => f.id === id);
                if (feedback) {
                    feedback.resolved = true;
                    feedback.dateResolved = new Date().toISOString().split("T")[0]; // Current date
                    
                    
                }

                alert(result.message);
            } 
            else {
                alert(result.message);
            }
        } catch (error) {
            console.error("Error marking issue as resolved:", error);
            alert("An error occurred while updating the issue. Please try again.");
        }
    }
}


function changePriority(id, newPriority) {
    console.log('Changing priority for ID:', id);

    // Find the row with the corresponding data-id
    const row = document.querySelector(`tr[data-id="${id}"]`);
    if (row) {
        // Find the cell with the priority (span element)
        const priorityCell = row.querySelector('.priority');
        if (priorityCell) {



            // send the updated priority to the server
            fetch('../actions/update_complaint_priority.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json', // Set the Content-Type to application/json
                },
                body: JSON.stringify({ // Convert the data to JSON
                    complaintID: id,
                    newPriority: newPriority
                })
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    priorityCell.textContent = newPriority; // Change the priority displayed
                                // Update the priority in the data array as well
                    const feedback = data.find((f) => f.id === id);
                    if (feedback) {
                        feedback.priority = newPriority; // Update the frontend data
                    }
                    alert(data.message)
                    console.log("Priority updated successfully!");
                } else {
                    console.error("Failed to update priority");
                }
            })
            .catch(error => {
                console.error("Error updating priority:", error);
            });
        }
    }
}

async function removeFeedback(id) {
    // Confirm if the user really wants to remove the feedback
    if (confirm('Are you sure you want to remove this complaint?')) {
        try {
            // Send the delete request to the backend
            const response = await fetch(`../actions/delete_complaint.php?complaintID=${id}`, {
                method: 'DELETE', 
            });

            const result = await response.json();

            if (result.success) {
                // Find the row with the corresponding data-id
                const row = document.querySelector(`tr[data-id="${id}"]`);
                if (row) {
                    // Remove the row from the table if found
                    row.remove(); // This removes the row from the table
                }
                alert(result.message); // Show success message
            } else {
                alert(result.message); // Show error message if deletion failed
            }
        } catch (error) {
            console.error('Error removing complaint:', error);
            alert('An error occurred while removing the complaint. Please try again.');
        }
    }
}





// Apply Filters and Sorting
async function applyFeedbackFilters() {
    const resolutionFilter = document.getElementById("resolution-filter").value;
    const dateSort = document.getElementById("date-sort").value;
    const prioritySort = document.getElementById("priority-sort").value;

    // Prepare the filter data to send to the backend
    const filters = {
        resolution: resolutionFilter,
        dateSort: dateSort,
        priority: prioritySort
    };

    try {
        // Send the filters to the backend to fetch the filtered data
        console.log(filters)
        const response = await fetch('../actions/filter_complaints.php', {
            method: 'POST', 
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(filters), // Send the filter data as JSON
        });

        const result = await response.json();

        if (result.success) {
            // If the response is successful, render the table with the filtered data
            renderFeedbackTable(result.data); // Assuming the backend returns the filtered complaints in 'data'
        } else {
            alert(result.message); // Handle any errors returned by the backend
        }
    } catch (error) {
        console.error("Error fetching filtered complaints:", error);
        alert("An error occurred while applying filters. Please try again.");
    }
}








// render the feedback page
fetchFeedbackData();







// Apply Filters and Sorting
// function applyFeedbackFilters() {
//     const resolutionFilter = document.getElementById("resolution-filter").value;
//     const dateSort = document.getElementById("date-sort").value;
//     const prioritySort = document.getElementById("priority-sort").value;

//     let filteredData = data;

//     // Filter by Resolution
//     if (resolutionFilter) {
//         filteredData = filteredData.filter((f) =>
//             resolutionFilter === "resolved" ? f.resolved : !f.resolved
//         );
//     }

//     // Sort by Date
//     if (dateSort) {
//         filteredData.sort((a, b) => 
//             dateSort === "recent" ? new Date(b.date) - new Date(a.date) : new Date(a.date) - new Date(b.date)
//         );
//     }

//     // Sort by Priority
//     if (prioritySort) {
//         const priorityOrder = { High: 1, Medium: 2, Low: 3 };
//         filteredData.sort((a, b) =>
//             prioritySort === "high"
//                 ? priorityOrder[a.priority] - priorityOrder[b.priority]
//                 : priorityOrder[b.priority] - priorityOrder[a.priority]
//         );
//     }

//     renderFeedbackTable(filteredData);
// }
