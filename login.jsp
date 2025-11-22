<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="aupark.User" %>
<%
    if (session.getAttribute("user") != null) {
        response.sendRedirect("index.jsp");
        return;
    }
    String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login - AU SmartPark</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/main.css">
    <script>
        function toggleMenu() {
            const nav = document.getElementById('primaryNav');
            nav.classList.toggle('open');
        }
        function showForm(name) {
            const loginForm = document.getElementById('loginForm');
            const registerForm = document.getElementById('registerForm');
            const loginTab = document.getElementById('loginTab');
            const registerTab = document.getElementById('registerTab');

            if (name === 'login') {
                loginForm.style.display = 'block';
                registerForm.style.display = 'none';
                loginTab.classList.add('active');
                registerTab.classList.remove('active');
            } else {
                loginForm.style.display = 'none';
                registerForm.style.display = 'block';
                loginTab.classList.remove('active');
                registerTab.classList.add('active');
            }
        }
        window.addEventListener('DOMContentLoaded', function () {
            showForm('login');
        });
    </script>
</head>
<body>
<header class="site-header">
    <div class="nav-container">
        <a href="index.jsp" class="brand">
            <img src="images/Ajman-University.png" alt="Ajman University">
            <span>AU SmartPark</span>
        </a>
        <button class="menu-toggle" type="button" onclick="toggleMenu()" aria-label="Toggle navigation">☰</button>
        <nav id="primaryNav" class="primary-nav">
            <a href="index.jsp">Home</a>
            <a href="reservation.jsp">Reservation</a>
            <a href="report.jsp">Reports</a>
            <a class="action-link" href="login.jsp">Login / Register</a>
        </nav>
    </div>
</header>

<main>
    <section class="section" style="padding-top:40px;">
        <div class="two-column" style="align-items:stretch;">
            <div class="card" style="background: linear-gradient(180deg, rgba(28,78,216,0.14), rgba(14,165,233,0.12));">
                <div class="pill" style="background: rgba(248,250,252,0.8); color: var(--primary);">Welcome back</div>
                <h2 style="margin-top:8px;">Smart parking, simpler than ever</h2>
                <p style="color:var(--text-muted); line-height:1.6;">Create reservations, manage multiple vehicles, and stay ahead of peak hours with timely reminders. Your dashboard keeps your parking life organised.</p>
                <img src="images/parking example.jpeg" alt="Parking illustration" style="margin-top:24px; border-radius: var(--border-radius);">
            </div>
            <div>
                <div class="form-shell">
                    <h2>Access SmartPark</h2>
                    <div class="tabs">
                        <button id="loginTab" type="button" onclick="showForm('login')">Sign in</button>
                        <button id="registerTab" type="button" onclick="showForm('register')">Create account</button>
                    </div>
                    <% if (message != null) { %>
                    <div class="message"><%= message %></div>
                    <% } %>
                    <form id="loginForm" method="post" action="login" style="display:none;">
                        <label for="loginEmail">University email</label>
                        <input id="loginEmail" class="input-field" type="email" name="email" placeholder="name@ajman.ac.ae" required>
                        <label for="loginPassword">Password</label>
                        <input id="loginPassword" class="input-field" type="password" name="password" placeholder="••••••••" required>
                        <button class="btn-primary" type="submit">Login</button>
                    </form>
                    <form id="registerForm" method="post" action="register" style="display:none;">
                        <label for="fullName">Full name</label>
                        <input id="fullName" class="input-field" type="text" name="fullName" placeholder="Sara Ahmed" required>
                        <label for="registerEmail">University email</label>
                        <input id="registerEmail" class="input-field" type="email" name="email" placeholder="name@ajman.ac.ae" required>
                        <label for="phone">Mobile number</label>
                        <input id="phone" class="input-field" type="text" name="phone" placeholder="050 123 4567" required>
                        <label for="carPlate">Car plate number</label>
                        <input id="carPlate" class="input-field" type="text" name="carPlate" placeholder="ABC 12345" required>
                        <label for="registerPassword">Password</label>
                        <input id="registerPassword" class="input-field" type="password" name="password" placeholder="Create password" required>
                        <label for="confirmPassword">Confirm password</label>
                        <input id="confirmPassword" class="input-field" type="password" name="confirmPassword" placeholder="Repeat password" required>
                        <button class="btn-primary" type="submit">Create account</button>
                    </form>
                    <p class="small-print">Admin? <a class="link-muted" href="admin-login.jsp">Sign in here</a></p>
                </div>
            </div>
        </div>
    </section>
</main>

<footer class="footer">
    <div>Having trouble accessing your account? Email <a href="mailto:smartpark@ajman.ac.ae">smartpark@ajman.ac.ae</a></div>
    <small>© <%= java.time.Year.now() %> Ajman University SmartPark.</small>
</footer>
</body>
</html>
