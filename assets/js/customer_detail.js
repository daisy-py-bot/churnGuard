// Initialize with default tags
let customerTags = ["High Risk", "Follow Up"];

// Function to render tags dynamically
function renderTags() {
    const tagContainer = document.getElementById("tag-container");
    tagContainer.innerHTML = ""; // Clear existing tags

    customerTags.forEach(tag => {
        const button = document.createElement("button");
        button.type = "button";
        button.className = "tag";
        button.innerHTML = `${tag} <span class="remove-tag" onclick="removeTag('${tag}')">&times;</span>`;
        tagContainer.appendChild(button);
    });
}

// Function to add a tag
function addTag() {
    const newTag = document.getElementById("new-tag").value;

    if (newTag && !customerTags.includes(newTag)) {
        customerTags.push(newTag);
        renderTags(); // Re-render tags
    }
}

// Function to remove a tag
function removeTag(tag) {
    customerTags = customerTags.filter(existingTag => existingTag !== tag);
    renderTags(); // Re-render tags
}

// Initial rendering of tags
renderTags();
