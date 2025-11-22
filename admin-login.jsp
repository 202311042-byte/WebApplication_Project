<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Login - AU SmartPark</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/main.css">
    <script>
        function toggleMenu() {
            const nav = document.getElementById('primaryNav');
            nav.classList.toggle('open');
        }
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
            <a class="action-link" href="login.jsp">User Access</a>
        </nav>
    </div>
</header>

<main>
    <section class="section" style="padding-top:50px;">
        <div class="two-column" style="align-items:center;">
            <div class="card" style="background:linear-gradient(145deg, rgba(15,23,42,0.85), rgba(28,78,216,0.75)); color:#f8fafc;">
                <div class="pill" style="background: rgba(248,250,252,0.18); color:#fff;">Operations Console</div>
                <h2 style="margin-top:10px;">SmartPark Control Room</h2>
                <p style="line-height:1.6;">Monitor reservations, confirm availability, and action reports directly from your dedicated admin workspace.</p>
                <img src="images/parking example (1).jpeg" alt="Parking management" style="margin-top:24px; border-radius: var(--border-radius);">
            </div>
            <div>
                <div class="form-shell">
                    <h2>Admin Login</h2>
                    <% if (message != null) { %>
                    <div class="message"><%= message %></div>
                    <% } %>
                    <form method="post" action="admin-login">
                        <label for="adminEmail">Admin email</label>
                        <input id="adminEmail" class="input-field" type="email" name="email" placeholder="admin@ajman.ac.ae" required>
                        <label for="adminPassword">Password</label>
                        <input id="adminPassword" class="input-field" type="password" name="password" placeholder="••••••••" required>
                        <button class="btn-primary" type="submit">Login</button>
                    </form>
                    <p class="small-print"><a class="link-muted" href="login.jsp">Back to student login</a></p>
                </div>
            </div>
        </div>
    </section>
</main>

<footer class="footer">
    <div>Need support? Contact the SmartPark operations desk.</div>
    <small>© <%= java.time.Year.now() %> Ajman University SmartPark.</small>
</footer>
</body>
</html>
