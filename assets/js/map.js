// Assume groupedData is already aggregated from your database
const groupedData = [
    { location: 'Zimbabwe', count: 50, averageChurn: 0.85, lat: -19.0154, lng: 29.1549 },
    { location: 'USA', count: 200, averageChurn: 0.3, lat: 37.0902, lng: -95.7129 },
    { location: 'Ghana', count: 120, averageChurn: 0.6, lat: 7.9465, lng: -1.0232 }
];

// Function to determine the color based on average churn
const getMapColor = (averageChurn) => {
    if (averageChurn > 0.7) return 'red'; // High Risk
    if (averageChurn > 0.4) return 'yellow'; // Medium Risk
    return 'green'; // Low Risk
};

// Initialize the map
const map = L.map('map').setView([20, 0], 2);  // Zoom and center the map

// Add OpenStreetMap tile layer to the map
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
}).addTo(map);

// Loop through each location and create a circle marker
groupedData.forEach(data => {
    const color = getMapColor(data.averageChurn);

    L.circleMarker([data.lat, data.lng], {
        radius: 12,
        fillColor: color,
        color: color,
        weight: 2,
        opacity: 1,
        fillOpacity: 0.7
    })
    .bindPopup(`
        <b>Location: ${data.location}</b><br>
        Number of Customers: ${data.count}<br>
        Average Churn Prediction: ${(data.averageChurn * 100).toFixed(2)}%<br>
        Risk Category: ${data.averageChurn > 0.7 ? 'High Risk' : (data.averageChurn > 0.4 ? 'Medium Risk' : 'Low Risk')}
    `)
    .addTo(map);
});
