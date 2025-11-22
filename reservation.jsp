<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="aupark.User" %>
<%@ page import="aupark.ReservationInfo" %>
<%@ page import="java.util.HashSet" %>
<%@ page import="java.util.Set" %>
<%
    User user = (User) session.getAttribute("user");
    ReservationInfo reservation = (ReservationInfo) session.getAttribute("reservation");
    String[] reservedSpots = (String[]) request.getAttribute("reservedSpots");
    String[] unavailableSpots = (String[]) request.getAttribute("unavailableSpots");
    Set<String> reservedSet = new HashSet<>();
    Set<String> unavailableSet = new HashSet<>();
    if (reservedSpots != null) {
        for (String spot : reservedSpots) {
            if (spot != null) {
                reservedSet.add(spot);
            }
        }
    }
    if (unavailableSpots != null) {
        for (String spot : unavailableSpots) {
            if (spot != null) {
                unavailableSet.add(spot);
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Reservation - AU SmartPark</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/css/main.css">
    <script>
        function toggleMenu() {
            const nav = document.getElementById('primaryNav');
            nav.classList.toggle('open');
        }

        document.addEventListener('DOMContentLoaded', function () {
            const spots = document.querySelectorAll('[data-spot]');
            const spotInput = document.getElementById('spotId');
            const reserveButton = document.getElementById('reserveButton');
            const selectedSpotLabel = document.getElementById('selectedSpotLabel');

            if (!spotInput || !reserveButton || !selectedSpotLabel) {
                const owned = document.querySelector('.spot.mine');
                if (owned) {
                    owned.classList.add('selected');
                    owned.setAttribute('aria-pressed', 'true');
                }
                return;
            }

            const setSelectedSpot = function (value) {
                spotInput.value = value || '';
                selectedSpotLabel.textContent = value ? ('Bay ' + value) : 'None selected';
                reserveButton.disabled = !value;
                reserveButton.setAttribute('aria-disabled', (!value).toString());
            };

            spots.forEach(function (spot) {
                spot.addEventListener('click', function () {
                    if (spot.dataset.disabled === 'true') {
                        return;
                    }
                    spots.forEach(function (item) {
                        item.classList.remove('selected');
                        item.setAttribute('aria-pressed', 'false');
                    });
                    spot.classList.add('selected');
                    spot.setAttribute('aria-pressed', 'true');
                    setSelectedSpot(spot.dataset.spot);
                });

                spot.addEventListener('keydown', function (event) {
                    if (event.key === 'Enter' || event.key === ' ') {
                        event.preventDefault();
                        spot.click();
                    }
                });
            });

            if (spotInput.value) {
                const preselected = document.querySelector('[data-spot="' + spotInput.value + '"]');
                if (preselected) {
                    preselected.classList.add('selected');
                    preselected.setAttribute('aria-pressed', 'true');
                    setSelectedSpot(spotInput.value);
                }
            } else {
                reserveButton.disabled = true;
                reserveButton.setAttribute('aria-disabled', 'true');
            }
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
    <section class="section">
        <div class="two-column hero-overview">
            <div class="hero-copy">
                <div class="pill lead-pill">Campus-wide coverage</div>
                <h1>Reserve confidently before you arrive</h1>
                <p class="section-lead">Track open spaces in real time, save favourite bays, and glide past the hunt for parking. Tap any available bay to hold it instantly.</p>
                <div class="callout">
                    <strong>Tip:</strong> Arriving early or running late? Adjust your start time or extend your reservation without leaving the page.
                </div>
            </div>
            <div class="hero-media">
                <img src="images/parking example.jpeg" alt="Reserve your parking spot">
            </div>
        </div>
    </section>

    <section class="section reservation-section">
        <div class="reservation-layout">
            <div class="parking-map">
                <div class="flex flex-between map-header">
                    <div>
                        <h2>Parking map</h2>
                        <p>Tap a bay to preview and reserve. Reserved bays show in amber.</p>
                    </div>
                    <div class="badge metric">18 smart bays</div>
                </div>
                <div class="legend">
                    <span class="available">Available</span>
                    <span class="reserved">Reserved</span>
                    <span class="mine">Your reservation</span>
                    <span class="unavailable">Unavailable</span>
                </div>
                <div class="grid">
                    <% for (int i = 1; i <= 18; i++) {
                        String id = "P" + i;
                        boolean isMine = reservation != null && reservation.getSpotId().equals(id);
                        boolean isUnavailable = unavailableSet.contains(id);
                        boolean isReserved = reservedSet.contains(id) && !isMine;
                        StringBuilder classes = new StringBuilder("spot");
                        if (isUnavailable) {
                            classes.append(" unavailable");
                        }
                        if (isReserved) {
                            classes.append(" reserved");
                        }
                        if (isMine) {
                            classes.append(" mine");
                        }
                        boolean disabled = isUnavailable || isReserved;
                    %>
                        <div class="<%= classes.toString() %>" data-spot="<%= id %>" data-disabled="<%= disabled ? "true" : "false" %>" role="button" tabindex="0" aria-pressed="false" aria-disabled="<%= disabled ? "true" : "false" %>" aria-label="Parking bay <%= id %><%= isMine ? " - currently reserved for you" : "" %>">
                            <%= id %>
                        </div>
                    <% } %>
                </div>
                <% if (user == null) { %>
                    <div class="info-message">Please <a class="link-muted" href="login.jsp">log in</a> to reserve a bay.</div>
                <% } %>
            </div>

            <div class="reservation-actions">
                <% if (user != null) { %>
                    <% if (reservation == null) { %>
                        <div id="newBookingCard">
                            <div class="pill lead-pill">New reservation</div>
                            <h3>Book a bay</h3>
                            <p class="help-text">Choose an available bay from the map, then confirm when you plan to arrive and how long you'll stay.</p>
                            <form id="reservationForm" method="post" action="reservation">
                                <input type="hidden" name="action" value="reserve">
                                <input type="hidden" id="spotId" name="spotId" value="">
                                <div class="selection-status">
                                    <span>Selected bay</span>
                                    <strong id="selectedSpotLabel">None selected</strong>
                                </div>
                                <label for="startTime">Start time</label>
                                <input id="startTime" class="input-field" type="time" name="startTime" required>
                                <label for="duration">Duration (hours)</label>
                                <input id="duration" class="input-field" type="number" name="duration" min="1" max="5" step="1" required>
                                <button id="reserveButton" class="btn-primary" type="submit" disabled aria-disabled="true">Confirm reservation</button>
                                <p class="help-text">We'll hold your bay for ten minutes before your arrival window begins.</p>
                            </form>
                        </div>
                    <% } else { %>
                        <div class="reservation-details active" id="currentBookingCard">
                            <div class="pill success">Active reservation</div>
                            <h3>You're parked</h3>
                            <div class="details-grid">
                                <span>Bay<strong><%= reservation.getSpotId() %></strong></span>
                                <span>Starts<strong><%= reservation.getStartTime() != null && !reservation.getStartTime().isEmpty() ? reservation.getStartTime() : "Not set" %></strong></span>
                                <span>Duration<strong><%= reservation.getDuration() != null && !reservation.getDuration().isEmpty() ? reservation.getDuration() + " hour(s)" : "Not set" %></strong></span>
                            </div>
                            <form method="post" action="reservation">
                                <input type="hidden" name="action" value="update">
                                <label for="updateStart">Adjust start time</label>
                                <input id="updateStart" class="input-field" type="time" name="startTime" value="<%= reservation.getStartTime() != null ? reservation.getStartTime() : "" %>">
                                <label for="updateDuration">Extend duration</label>
                                <input id="updateDuration" class="input-field" type="number" name="duration" value="<%= reservation.getDuration() != null ? reservation.getDuration() : "" %>" min="1" max="5">
                                <button class="btn-primary" type="submit">Update reservation</button>
                            </form>
                            <form method="post" action="reservation" class="form-spaced">
                                <input type="hidden" name="action" value="leave">
                                <button class="btn-primary btn-destructive" type="submit">Leave spot</button>
                            </form>
                        </div>
                    <% } %>
                <% } else { %>
                    <div>
                        <h3>Reservation details</h3>
                        <p class="help-text">Log in to choose a bay, set your arrival time, and hold the space for up to five hours.</p>
                        <a class="action-link" href="login.jsp">Log in to reserve</a>
                    </div>
                <% } %>
            </div>
        </div>
    </section>
</main>

<footer class="footer">
    <div>Need assistance? Chat with campus security at the SmartPark desk.</div>
    <small>© <%= java.time.Year.now() %> Ajman University SmartPark.</small>
</footer>
</body>
</html>
