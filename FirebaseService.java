package aupark;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;

public class FirebaseService {
    private static final String API_KEY = "AIzaSyAdzIhC35z7t1rY1mfPn3ZaxrBSvssooww";
    private static final String PROJECT_ID = "au-smartpark";

    private static String buildUrl(String collection) {
        return "https://firestore.googleapis.com/v1/projects/" + PROJECT_ID + 
                "/databases/(default)/documents/" + collection + "?key=" + API_KEY;
    }

    public static String saveDocument(String collection, String jsonBody) {
        try {
            URL url = new URL(buildUrl(collection));
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            connection.setDoOutput(true);
            try (OutputStream output = connection.getOutputStream()) {
                output.write(jsonBody.getBytes("UTF-8"));
            }
            int code = connection.getResponseCode();
            if (code >= 200 && code < 300) {
                return readResponse(connection);
            }
            return "{}";
        } catch (Exception e) {
            return "{}";
        }
    }

    private static String readResponse(HttpURLConnection connection) {
        try (BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()))) {
            StringBuilder builder = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                builder.append(line);
            }
            return builder.toString();
        } catch (Exception e) {
            return "{}";
        }
    }
}
