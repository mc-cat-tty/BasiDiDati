import java.sql.*;


public class Main {
  private static final String URL = "jdbc:postgresql://localhost:5432/Studenti";
  private static final String USERNAME = "postgres";
  private static final String PASSWORD = "pass";
  
  public static void main(String[] args) {
    try {
      Class.forName("org.postgresql.Driver");
      var connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
      var statement = connection.createStatement();
      
      statement.executeUpdate("CREATE TABLE Studenti (matr INT, cognome CHAR(255), nome CHAR(255), primary key (matr));");
      statement.executeUpdate("INSERT INTO Studenti VALUES (1, 'rossi', 'mario');");
      statement.executeUpdate("INSERT INTO Studenti VALUES (2, 'bianchi', 'sergio');");

      var res1 = statement.executeQuery("SELECT * FROM Studenti;");
      while (res1.next()) {
        System.out.println(
          "Id:" + res1.getString(1) +
          "Name: " + res1.getString(2) +
          "Surname: " + res1.getString(3)
         );
      }

      var preparedQuery = connection.prepareStatement("SELECT * FROM STUDENTI WHERE nome = ? and matr > ?;");
      preparedQuery.setString(1, "sergio");
      preparedQuery.setInt(2, 0);
      var res2 = preparedQuery.executeQuery();
      while (res2.next()) {
        System.out.println(
          "Id:" + res2.getString(1) +
          "Name: " + res2.getString(2) +
          "Surname: " + res2.getString(3)
         );
      }
      
      connection.close();
    }
    catch (ClassNotFoundException | SQLException e) {
      e.printStackTrace();
    }
  }
}