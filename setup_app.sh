#!/bin/bash

# -----------------------------------
# Setup Full App (Frontend + Backend)
# -----------------------------------

# 1. Create folders
mkdir -p ~/myapp/backend
mkdir -p ~/myapp/frontend
cd ~/myapp

# 2. Backend files
cat > backend/app.py << EOL
from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

users = {}

@app.route("/signup", methods=["POST"])
def signup():
    data = request.get_json()
    username = data.get("username")
    password = data.get("password")
    if username in users:
        return jsonify({"success": False, "message": "User already exists"}), 400
    users[username] = password
    return jsonify({"success": True, "message": "Signup successful"})

@app.route("/login", methods=["POST"])
def login():
    data = request.get_json()
    username = data.get("username")
    password = data.get("password")
    if users.get(username) == password:
        return jsonify({"success": True, "message": "Login successful"})
    return jsonify({"success": False, "message": "Invalid credentials"}), 401

@app.route("/logout", methods=["POST"])
def logout():
    return jsonify({"success": True, "message": "Logged out successfully"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOL

cat > backend/requirements.txt << EOL
Flask
flask-cors
gunicorn
EOL

# 3. Frontend files
cat > frontend/index.html << EOL
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My App</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
<h1>Signup/Login Demo</h1>
<div>
    <input id="username" placeholder="Username">
    <input id="password" type="password" placeholder="Password">
    <button onclick="signupUser()">Signup</button>
    <button onclick="loginUser()">Login</button>
    <button onclick="logoutUser()">Logout</button>
</div>
<script src="script.js"></script>
</body>
</html>
EOL

cat > frontend/script.js << EOL
const API_URL = "https://your-render-url.onrender.com"; // Replace with Render URL

async function signupUser() {
    const username = document.getElementById("username").value;
    const password = document.getElementById("password").value;
    const res = await fetch(\`\${API_URL}/signup\`, {
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
    const res = await fetch(\`\${API_URL}/login\`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ username, password })
    });
    const data = await res.json();
    alert(data.message);
}

async function logoutUser() {
    const res = await fetch(\`\${API_URL}/logout\`, { method: "POST" });
    const data = await res.json();
    alert(data.message);
}
EOL

cat > frontend/style.css << EOL
body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }
input { margin: 5px; padding: 5px; }
button { margin: 5px; padding: 5px 10px; }
EOL

# 4. Make script executable
chmod +x setup_app.sh

echo "Setup complete! Backend in ~/myapp/backend, Frontend in ~/myapp/frontend"
echo "Edit frontend/script.js to set your Render URL."
echo "Use 'python3 -m http.server 8000' inside frontend folder to test frontend locally."
