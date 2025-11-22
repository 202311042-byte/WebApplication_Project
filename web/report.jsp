<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="aupark.User" %>
<%
    User user = (User) session.getAttribute("user");
    String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Report an Issue - AU SmartPark</title>
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
            <% if (user != null) { %>
                <span class="badge">Welcome, <%= user.getFullName() %></span>
                <a class="action-link" href="logout">Logout</a>
            <% } else { %>
                <a class="action-link" href="login.jsp">Login</a>
            <% } %>
        </nav>
    </div>
</header>

<main>
    <section class="section report-page">
        <div class="two-column" style="align-items:start; gap:32px;">
            <div>
                <div class="pill">Help us keep SmartPark sharp</div>
                <h1 style="margin:12px 0 18px;">Share issues, ideas, or kudos</h1>
                <p class="section-lead">Reports go straight to our campus operations crew. Describe what happened and optionally attach a photo so we can resolve it swiftly.</p>
                <div class="card" style="margin-top:24px;">
                    <h3>What you can report</h3>
                    <ul style="padding-left:18px; color:var(--text-muted); line-height:1.6;">
                        <li>Blocked or misused parking bays</li>
                        <li>Website bugs or reservation errors</li>
                        <li>Suggestions to improve the experience</li>
                    </ul>
                </div>
                <img src="images/parking example (1).jpeg" alt="Parking feedback" style="margin-top:26px; border-radius: var(--border-radius); box-shadow: var(--shadow-soft);">
            </div>
            <div>
                <div class="form-shell" style="max-width:520px;">
                    <h2>Submit a report</h2>
                    <% if (message != null) { %>
                    <div class="info-message"><%= message %></div>
                    <% } %>
                    <form method="post" action="report" enctype="multipart/form-data">
                        <label for="issueType">Type of issue</label>
                        <select id="issueType" name="issueType" class="input-field">
                            <option value="Parking">Parking</option>
                            <option value="Website">Website</option>
                        </select>
                        <label for="subject">Subject</label>
                        <input id="subject" class="input-field" type="text" name="subject" placeholder="Quick summary" required>
                        <label for="description">Description</label>
                        <textarea id="description" name="description" rows="4" placeholder="Tell us what happened" required></textarea>
                        <label for="image">Attach image (optional)</label>
                        <div class="upload-field">
                            Drag & drop or browse a screenshot or photo (JPG, PNG, GIF)
                            <input id="image" type="file" name="image" accept="image/*">
                        </div>
                        <button class="btn-primary" type="submit">Send report</button>
                    </form>
                </div>
            </div>
        </div>
    </section>
</main>

<footer class="footer">
    <div>We respond within one business day. Thank you for improving SmartPark!</div>
    <small>© <%= java.time.Year.now() %> Ajman University SmartPark.</small>
</footer>
</body>
</html>
