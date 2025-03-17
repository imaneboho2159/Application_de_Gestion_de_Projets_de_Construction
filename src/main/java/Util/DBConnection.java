package Util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
        private static final String URL = "jdbc:mysql://127.0.0.1:3306/SPORTFLOW?useSSL=false";
        private static final String USER = "root";
        private static final String PASSWORD = "root";

        public static Connection getConnection() throws SQLException {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("Connection success");
                return conn;
            } catch (ClassNotFoundException e) {
                throw new SQLException("JDBC Driver not found", e);
            }
        }
}
