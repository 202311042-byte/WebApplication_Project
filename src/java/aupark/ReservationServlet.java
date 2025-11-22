package aupark;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "ReservationServlet", urlPatterns = {"/reservation"})
public class ReservationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect("reservation.jsp");
            return;
        }

        ReservationInfo info = (ReservationInfo) session.getAttribute("reservation");
        User user = (User) session.getAttribute("user");

        if ("reserve".equals(action)) {
            String spotId = request.getParameter("spotId");
            String startTime = request.getParameter("startTime");
            String duration = request.getParameter("duration");
            if (spotId != null && !spotId.isEmpty()) {
                ReservationInfo newInfo = new ReservationInfo(spotId, empty(startTime), empty(duration));
                session.setAttribute("reservation", newInfo);
                String json = "{\"fields\":{"
                        + "\"user\":{\"stringValue\":\"" + user.getEmail() + "\"},"
                        + "\"spotId\":{\"stringValue\":\"" + spotId + "\"},"
                        + "\"startTime\":{\"stringValue\":\"" + empty(startTime) + "\"},"
                        + "\"duration\":{\"stringValue\":\"" + empty(duration) + "\"}}}";
                FirebaseService.saveDocument("reservations", json);
            }
        } else if ("leave".equals(action)) {
            session.removeAttribute("reservation");
        } else if ("update".equals(action) && info != null) {
            String startTime = request.getParameter("startTime");
            String duration = request.getParameter("duration");
            info.setStartTime(empty(startTime));
            info.setDuration(empty(duration));
            String json = "{\"fields\":{"
                    + "\"user\":{\"stringValue\":\"" + user.getEmail() + "\"},"
                    + "\"spotId\":{\"stringValue\":\"" + info.getSpotId() + "\"},"
                    + "\"startTime\":{\"stringValue\":\"" + info.getStartTime() + "\"},"
                    + "\"duration\":{\"stringValue\":\"" + info.getDuration() + "\"}}}";
            FirebaseService.saveDocument("reservationUpdates", json);
            session.setAttribute("reservation", info);
        }

        response.sendRedirect("reservation.jsp");
    }

    private String empty(String value) {
        return value == null ? "" : value;
    }
}
