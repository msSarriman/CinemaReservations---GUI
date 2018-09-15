package mainpackage;

import java.sql.*;
import javax.swing.*;

public class CheckConnection {
    Connection conn=null;
    public static Connection ConnectDb() {
        
        try{
            Class.forName("com.mysql.jdbc.Driver"); 
            Connection conn=DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cinema", "root", "mypassword");
            JOptionPane.showMessageDialog(null, "Connection to MySQL server/CinemaDB Established Successfully!");
            return conn;
           }
        catch(Exception e){
        JOptionPane.showMessageDialog(null,e);
        return null;
        }
    }
    
}
