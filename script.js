const API_URL = "https://myapp-backend-cgn4.onrender.com"; // Replace with your backend URL

// Signup
async function signupUser() {
    const username = document.getElementById("username").value;
    const email = document.getElementById("email").value;
    const phone = document.getElementById("phone").value;
    const password = document.getElementById("password").value;

    const res = await fetch(`${API_URL}/signup`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username, email, phone, password })
    });
    const data = await res.json();
    alert(data.message);
}

// Login
async function loginUser() {
    const identifier = document.getElementById("loginIdentifier").value;
    const password = document.getElementById("loginPassword").value;

    const res = await fetch(`${API_URL}/login`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ identifier, password })
    });
    const data = await res.json();
    alert(data.message);
}

// Logout
async function logoutUser() {
    const res = await fetch(`${API_URL}/logout`, { method: "POST" });
    const data = await res.json();
    alert(data.message);
}
