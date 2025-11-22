package aupark;

public class User {
    private String fullName;
    private String email;
    private String phone;
    private String carPlate;
    private String passwordHash;
    private boolean admin;

    public User(String fullName, String email, String phone, String carPlate, String passwordHash, boolean admin) {
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.carPlate = carPlate;
        this.passwordHash = passwordHash;
        this.admin = admin;
    }

    public String getFullName() {
        return fullName;
    }

    public String getEmail() {
        return email;
    }

    public String getPhone() {
        return phone;
    }

    public String getCarPlate() {
        return carPlate;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public boolean isAdmin() {
        return admin;
    }
}
