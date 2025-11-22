<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="aupark.User" %>
<%@ page import="aupark.ReservationInfo" %>
<%
    User user = (User) session.getAttribute("user");
    ReservationInfo reservation = (ReservationInfo) session.getAttribute("reservation");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AU SmartPark</title>
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
            <% if (user == null) { %>
                <a href="login.jsp">Login</a>
                <a class="action-link" href="login.jsp">Create Account</a>
            <% } else { %>
                <span class="badge">Welcome, <%= user.getFullName() %></span>
                <a class="action-link" href="logout">Logout</a>
            <% } %>
        </nav>
    </div>
</header>

<main>
    <section class="hero">
        <img class="hero-visual" src="images/campus-au.jpg" alt="Ajman University Campus Parking">
        <div class="hero-content">
            <div>
                <span class="badge">A modern parking experience for AU</span>
                <h1>Find the perfect spot before you arrive on campus.</h1>
                <p>Reserve and manage parking effortlessly with real-time visibility, smart notifications, and a design made for busy AU students and staff.</p>
                <div class="hero-actions">
                    <a class="action-link" href="reservation.jsp">Reserve a Spot</a>
                    <a class="action-link secondary" href="#discover">Explore Features</a>
                </div>
            </div>
        </div>
    </section>

    <section id="discover" class="section">
        <h2>Why students and staff love SmartPark</h2>
        <p class="section-lead">Parking chaos should never be part of your morning routine. SmartPark keeps you informed, on time, and relaxed.</p>
        <div class="card-grid">
            <article class="card">
                <div class="pill">01 • Live Availability</div>
                <h3>Live spot insights</h3>
                <p>Check which zones still have spaces and secure one instantly. No more circling the campus or guessing what is open.</p>
            </article>
            <article class="card">
                <div class="pill">02 • Digital Pass</div>
                <h3>Frictionless entry</h3>
                <p>Your reservation doubles as a digital parking pass, so security can verify you in seconds from their tablet.</p>
            </article>
            <article class="card">
                <div class="pill">03 • Timely Alerts</div>
                <h3>Stay informed</h3>
                <p>Receive reminders before your reservation expires and extend the slot with one tap to avoid fines or towing.</p>
            </article>
        </div>
    </section>

    <section class="section">
        <div class="two-column">
            <div>
                <img src="images/parking.jpeg" alt="Smart parking guidance at Ajman University" style="border-radius: var(--border-radius); box-shadow: var(--shadow-soft);">
            </div>
            <div>
                <h2>Designed for every commuter</h2>
                <p class="section-lead">Whether you are a student racing between lectures or a faculty member on duty, SmartPark fits into your day with ease.</p>
                <div class="card" style="box-shadow:none; background:transparent; border:none; padding:0;">
                    <ul style="list-style:none; padding:0; margin:0; color:var(--text-muted); line-height:1.6;">
                        <li>• Manage multiple vehicles and save preferences.</li>
                        <li>• Get walking directions to your building after parking.</li>
                        <li>• Share reservation details with guests securely.</li>
                    </ul>
                </div>
                <div class="callout">
                    <strong>Bonus:</strong> Already have a reservation? Jump back in below and update it without losing your spot.
                    <% if (reservation != null) { %>
                        <div class="info-message" style="margin-top:18px;">
                            Current Reservation • Spot <strong><%= reservation.getSpotId() %></strong>
                            <div class="small-print">Start: <%= reservation.getStartTime() %> • Duration: <%= reservation.getDuration() %> hours</div>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </section>

    <section class="section">
        <h2>Built by AU, for AU</h2>
        <p class="section-lead">Our student-led team partnered with campus services to deliver a polished and trustworthy parking assistant.</p>
        <div class="card-grid">
            <article class="card">
                <h3>Peace of mind</h3>
                <p>Each reservation is logged with campus security, ensuring the spot you book is the spot waiting for you.</p>
            </article>
            <article class="card">
                <h3>Always accessible</h3>
                <p>The interface adapts beautifully across mobile and desktop, making parking management easy on the go.</p>
            </article>
            <article class="card">
                <h3>Community driven</h3>
                <p>Feedback goes straight to our team. Check the reports center to submit ideas, issues, or success stories.</p>
            </article>
        </div>
    </section>
</main>

<footer class="footer">
    <div>Need help? Reach us at <a href="mailto:smartpark@ajman.ac.ae">smartpark@ajman.ac.ae</a></div>
    <small>© <%= java.time.Year.now() %> Ajman University SmartPark. Crafted with care by AU innovators.</small>
</footer>
</body>
</html>
