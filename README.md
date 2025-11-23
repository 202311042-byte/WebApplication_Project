# AU Parking

AU Parking is a web application that allows university students to select and reserve a parking spot remotely before arriving on campus — helping them avoid being late to class.
Prerequisites
Before you can build or run AU Parking, make sure the following software is installed and configured on your system.
Component	Version	Description
Java JDK	17 or later	Required to compile and run Jakarta EE Servlets
Apache Maven	3.8+	For build and dependency management
Apache Tomcat	10+	Application server for deploying .war file
Firebase Account	—	Required to connect to Firestore
Firebase Admin SDK	Latest	To access Firestore from the backend
NetBeans IDE (Optional)	—	Used for debugging or development

## Build and Run Steps
Build the Project Using Maven

## mvn clean package
After building, Maven will generate a .war file inside the target/ directory:
target/auparking.war
 
## Deploy to Apache Tomcat
Copy the .war file to the Tomcat webapps directory:
cp target/auparking.war /path/to/tomcat/webapps/
 
## Start the Tomcat server:
catalina.sh run
 
## Once Tomcat starts, access the application in your browser:
http://localhost:8080/auparking

Database Setup (Firebase Firestore)
 
AU Parking uses Firebase Firestore as its cloud database to store user, reservation, and admin data.
 
## 1. Create a Firebase Project
Go to Firebase Console
Click Add Project → Give it a name (e.g., “AU Parking”)
Enable Firestore Database
 
## 2. Enable Firestore
Navigate to Build → Firestore Database
Click Create Database
Select Start in Production Mode
Choose a region close to your deployment
 
## 3. Download Admin SDK Key
Go to Project Settings → Service Accounts
Click Generate new private key
Download the JSON file (e.g., serviceAccountKey.json)
Place it inside your project directory:
Src/main/resources/serviceAccountKey.json

## Database Credentials Configuration
## Initialize Firebase in your backend code using the Admin SDK credentials.

### Example (FirebaseConfig.java):
import com.google.auth.oauth2.GoogleCredentials; import com.google.firebase.FirebaseApp; import com.google.firebase.FirebaseOptions;
import java.io.FileInputStream; import java.io.IOException;
public class FirebaseConfig { public static void initialize() throws IOException { FileInputStream serviceAccount = new FileInputStream("src/main/resources/serviceAccountKey.json");
   FirebaseOptions options = new FirebaseOptions.Builder()
        .setCredentials(GoogleCredentials.fromStream(serviceAccount))
        .setDatabaseUrl("https://AU_Parking.firebaseio.com")
        .build();

    FirebaseApp.initializeApp(options);
 
    }
 }
