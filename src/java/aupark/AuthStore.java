package aupark;

import java.util.HashMap;
import java.util.Map;

public class AuthStore {
    private static final Map<String, User> users = new HashMap<>();

    static {
        String adminHash = PasswordHelper.hashPassword("admin123");
        users.put("admin@ausmartpark.ae", new User("Admin", "admin@ausmartpark.ae", "", "", adminHash, true));
    }

    public static boolean emailExists(String email) {
        return users.containsKey(email);
    }

    public static void saveUser(User user) {
        users.put(user.getEmail(), user);
    }

    public static User getUser(String email) {
        return users.get(email);
    }
}
