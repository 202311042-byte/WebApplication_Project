package aupark;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "AdminLoginServlet", urlPatterns = {"/admin-login"})
public class AdminLoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = AuthStore.getUser(email);
        if (user != null && user.isAdmin() && PasswordHelper.checkPassword(password, user.getPasswordHash())) {
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("message", "Admin login failed.");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
        }
    }
}