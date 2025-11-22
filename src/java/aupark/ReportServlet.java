package aupark;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.util.Base64;

@WebServlet(name = "ReportServlet", urlPatterns = {"/report"})
@MultipartConfig
public class ReportServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String issueType = request.getParameter("issueType");
        String subject = request.getParameter("subject");
        String description = request.getParameter("description");
        Part image = request.getPart("image");

        if (subject == null || subject.isEmpty() || description == null || description.isEmpty()) {
            request.setAttribute("message", "Please fill subject and description.");
            request.getRequestDispatcher("report.jsp").forward(request, response);
            return;
        }

        String encodedImage = "";
        if (image != null && image.getSize() > 0) {
            byte[] bytes = image.getInputStream().readAllBytes();
            encodedImage = Base64.getEncoder().encodeToString(bytes);
        }

        String json = "{\"fields\":{"
                + "\"type\":{\"stringValue\":\"" + value(issueType) + "\"},"
                + "\"subject\":{\"stringValue\":\"" + value(subject) + "\"},"
                + "\"description\":{\"stringValue\":\"" + value(description) + "\"},"
                + "\"image\":{\"stringValue\":\"" + encodedImage + "\"}}}";
        FirebaseService.saveDocument("reports", json);
        request.setAttribute("message", "Report submitted. Thank you.");
        request.getRequestDispatcher("report.jsp").forward(request, response);
    }

    private String value(String text) {
        return text == null ? "" : text.replace("\"", "'");
    }
}
