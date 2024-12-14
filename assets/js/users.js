const usersTableBody = document.getElementById('usersTableBody');
let users = []


// Fetch data from the database
async function fetchUsers() {
    try {
        const response = await fetch('../../db/view_employees.php', {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
            },
        });

        const result = await response.json();

        if (result.success) {
            console.log(result.data)
            users = result.data
            renderUsers(users)
        } else {
            alert("Failed to fetch users: " + result.message);
            return [];
        }
    } catch (error) {
        alert("Error fetching users: " + error.message);
        return [];
    }
}

// populate the table
fetchUsers()


// Render users in the table
function renderUsers(users) {
    console.log("rendering users")
    usersTableBody.innerHTML = '';
    users.forEach(user => {
        const row = document.createElement('tr');
        // Set the employeeId as an attribute of the row
        row.setAttribute('employeeId', user.EmployeeID);

        row.innerHTML = `
            <td>${user.EmployeeID}</td>
            <td><span class='username'>${user.name}</span></td>
            <td>${user.email}</td>
            <td><span class='role'>${user.role}</span></td>
            <td>${user.createdAt}</td>
            <td>${user.lastLogin}</td>
            <td>
                <button class="view" onclick="viewUser(${user.EmployeeID})">View</button>
                <button class="edit" onclick="editUser(${user.EmployeeID})">Edit</button>
                <button class="delete" onclick="deleteUser(${user.EmployeeID})">Delete</button>
                <button class="change-role" onclick="changeUserRole(${user.EmployeeID})">Role</button>
            </td>
        `;
        usersTableBody.appendChild(row);

    })

}

// View User Details
function viewUser(id) {
    const user = users.find(u => (u.EmployeeID) === String(id));
    if (user) {
        alert(`Viewing User:\nName: ${user.name}\nEmail: ${user.email}\nRole: ${user.role}`);
    }
}


// Edit User Details
async function editUser(id) {
    const row = document.querySelector(`tr[employeeId='${id}']`);
    const usernameSpan = row.querySelector('.username');
    const user = users.find(u => u.EmployeeID === String(id));
    if (user) {
        const nameParts = user.name.split(' ');  
        const firstName = nameParts[0];
        const lastName = nameParts[nameParts.length - 1];

        const newFirstname = prompt("Edit Firstname:", firstName);
        const newLastname = prompt("Edit Lastname:", lastName);

        if (newFirstname || newLastname) {
            const requestData = {
                id: id,
                firstname: newFirstname,
                lastname: newLastname
            };

        if (confirm("Are you sure you want to change user name to " + newFirstname + " " + newLastname + "?")) {
            console.log(requestData)

            try {
                const response = await fetch('../../actions/update_user.php', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(requestData),
                });
                const result = await response.json();

                if (result.success) {
                    alert(result.message);
                    usernameSpan.textContent = newFirstname + " " + newLastname;
                    renderUsers();
                } else {
                    alert("Failed to update user: " + result.message);
                }
            } catch (error) {
                alert("Error updating user: " + error.message);
            }

        }

        }
    }
}

// Delete User
async function deleteUser(id) {
    const confirmDelete = confirm("Are you sure you want to delete this user?");
    if (confirmDelete) {
        const requestData = { id };

        try {
            const response = await fetch('../../actions/delete_user.php', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(requestData),
            });
            const result = await response.json();

            if (result.success) {
                alert(result.message);

                // Find and remove the row by matching the EmployeeID (id) of the user
                const rowToDelete = document.querySelector(`[employeeid="${id}"]`);
                if (rowToDelete) {
                    rowToDelete.remove(); // Remove the row from the DOM
                }

            } else {
                alert("Failed to delete user: " + result.message);
            }
        } catch (error) {
            alert("Error deleting user: " + error.message);
        }
    }
}




async function changeUserRole(EmployeeID) {
    Swal.fire({
        title: 'Change Role',
        input: 'select',
        inputOptions: {
            'Admin': 'Admin',
            'Employee': 'Employee',
        },
        inputPlaceholder: 'Select Role',
        showCancelButton: true,
    }).then((result) => {
        if (result.isConfirmed) {
            const newRole = result.value;
            
            const requestData = {
                id: EmployeeID,
                role: newRole,
            };
            
            console.log("Updating role:", requestData);
            // Send request to update the role 
            updateRole(requestData)

    }});
}

async function updateRole(requestData){
    const row = document.querySelector(`tr[employeeId='${requestData.id}']`)
    const roleSpan = row.querySelector('.role');

    try {
        const response = await fetch('../../actions/update_role.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(requestData),
        });
        const result = await response.json();

        if (result.success) {
            alert(result.message);
            roleSpan.textContent = requestData.role;
       } else {
            alert("Failed to change role: " + result.message);
        }
    } catch (error) {
        alert("Error changing role: " + error.message);
    }
}


