package mainpackage;

import java.sql.*;
import javax.swing.*;

public class Interface {
    Connection conn=null;
    public static Connection ConnectDb() {
        
        try{
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn=DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cinema", "root", "myPassword");
            // JOptionPane.showMessageDialog(null, "Connection to MySQL server Established");
            return conn;
           }
        catch(Exception e){
        JOptionPane.showMessageDialog(null,e);
        return null;
        }
    }
    
}
