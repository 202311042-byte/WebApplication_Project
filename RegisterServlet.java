package aupark;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String carPlate = request.getParameter("carPlate");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirmPassword");

        if (fullName == null || email == null || phone == null || carPlate == null
                || password == null || confirm == null
                || fullName.isEmpty() || email.isEmpty() || phone.isEmpty()
                || carPlate.isEmpty() || password.isEmpty()) {
            request.setAttribute("message", "Please fill in all the details.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirm)) {
            request.setAttribute("message", "Passwords do not match.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (AuthStore.emailExists(email)) {
            request.setAttribute("message", "This email is already registered.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        String hash = PasswordHelper.hashPassword(password);
        User user = new User(fullName, email, phone, carPlate, hash, false);
        AuthStore.saveUser(user);
        request.setAttribute("message", "Account created. Please login.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
