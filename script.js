const API_URL = "https://myapp-backend-cgn4.onrender.com";

async function signupUser() {
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;
    const res = await fetch(`${API_URL}/signup`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username, password })
    });
    const data = await res.json();
    alert(data.message);
}

async function loginUser() {
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;
    const res = await fetch(`${API_URL}/login`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username, password })
    });
    const data = await res.json();
    alert(data.message);
}

async function logoutUser() {
    const res = await fetch(`${API_URL}/logout`, { method: "POST" });
    const data = await res.json();
    alert(data.message);
}
