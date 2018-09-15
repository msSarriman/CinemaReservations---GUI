package mainpackage;

import java.awt.*;
import java.awt.event.WindowEvent;
import java.sql.*;
import javax.swing.*;

public class SVLogin extends javax.swing.JFrame {

    Connection conn=null;
    PreparedStatement pst=null;
    ResultSet rs=null;
    
    public SVLogin() {
        initComponents();
    }
    
    
    public void close(){
        WindowEvent winClosingEvent=new WindowEvent(this,WindowEvent.WINDOW_CLOSING);
        Toolkit.getDefaultToolkit().getSystemEventQueue().postEvent(winClosingEvent);
    }
    
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jSeparator1 = new javax.swing.JSeparator();
        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        connbutton = new javax.swing.JButton();
        user_field = new javax.swing.JTextField();
        pass_field = new javax.swing.JPasswordField();
        signinbutton = new javax.swing.JButton();
        jLabel5 = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        jLabel7 = new javax.swing.JLabel();
        jLabel8 = new javax.swing.JLabel();
        jSeparator2 = new javax.swing.JSeparator();
        jLabel9 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setTitle("SuperVisor Interface - Log In");
        setMinimumSize(new java.awt.Dimension(417, 310));
        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowOpened(java.awt.event.WindowEvent evt) {
                formWindowOpened(evt);
            }
        });
        getContentPane().setLayout(null);
        getContentPane().add(jSeparator1);
        jSeparator1.setBounds(0, 260, 413, 10);

        jLabel1.setText("Welcome to Cinema Database Log In - GUI");
        getContentPane().add(jLabel1);
        jLabel1.setBounds(70, 10, 310, 15);

        jLabel2.setText("Please  enter  your  login  credentials  bellow");
        getContentPane().add(jLabel2);
        jLabel2.setBounds(60, 40, 321, 15);

        jLabel3.setText("Username:");
        getContentPane().add(jLabel3);
        jLabel3.setBounds(30, 100, 77, 15);

        jLabel4.setText("Password:");
        getContentPane().add(jLabel4);
        jLabel4.setBounds(30, 140, 75, 15);

        connbutton.setText("Check Connection");
        connbutton.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                connbuttonMouseClicked(evt);
            }
        });
        connbutton.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                connbuttonKeyPressed(evt);
            }
        });
        getContentPane().add(connbutton);
        connbutton.setBounds(222, 88, 179, 25);

        user_field.setMinimumSize(new java.awt.Dimension(10, 19));
        user_field.setPreferredSize(new java.awt.Dimension(10, 19));
        getContentPane().add(user_field);
        user_field.setBounds(107, 91, 109, 30);
        getContentPane().add(pass_field);
        pass_field.setBounds(107, 131, 109, 30);

        signinbutton.setText("Sign In");
        signinbutton.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                signinbuttonMouseClicked(evt);
            }
        });
        signinbutton.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                signinbuttonKeyPressed(evt);
            }
        });
        getContentPane().add(signinbutton);
        signinbutton.setBounds(222, 128, 179, 25);

        jLabel5.setIcon(new javax.swing.ImageIcon(getClass().getResource("/mainpackage/upatras_logo.png"))); // NOI18N
        getContentPane().add(jLabel5);
        jLabel5.setBounds(0, 160, 360, 100);

        jLabel6.setIcon(new javax.swing.ImageIcon(getClass().getResource("/mainpackage/logo.jpeg"))); // NOI18N
        getContentPane().add(jLabel6);
        jLabel6.setBounds(300, 160, 110, 90);

        jLabel7.setFont(new java.awt.Font("Dialog", 3, 12)); // NOI18N
        jLabel7.setText("Informatics Department");
        getContentPane().add(jLabel7);
        jLabel7.setBounds(130, 150, 190, 130);

        jLabel8.setFont(new java.awt.Font("Dialog", 3, 12)); // NOI18N
        jLabel8.setText("Computer Engineering &");
        getContentPane().add(jLabel8);
        jLabel8.setBounds(120, 130, 190, 130);
        getContentPane().add(jSeparator2);
        jSeparator2.setBounds(0, 60, 413, 10);

        jLabel9.setFont(new java.awt.Font("Dialog", 2, 11)); // NOI18N
        jLabel9.setText("Only SuperVisors Are Allowed to Login through this Tab.");
        getContentPane().add(jLabel9);
        jLabel9.setBounds(90, 250, 410, 50);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void signinbuttonMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_signinbuttonMouseClicked
         String sql="select * from Staff inner join SuperVisor ON supervisor_staff_ID = staff_ID"
                 + " where staff_phone=? and staff_ID=? AND supervisor_staff_ID = staff_ID";
       
        try{
            
            pst=conn.prepareStatement(sql);
            pst.setString(1,user_field.getText());
            pst.setString(2,pass_field.getText());
            rs=pst.executeQuery();
            
            if(rs.next()){
                JOptionPane.showMessageDialog(null,"Your credentials are correct."+System.lineSeparator()+"Welcome to Cinema Database!"+System.lineSeparator()+"Created By Manos Sarris-AM:5191");
                close();
                
                
                supervisormain s=new supervisormain();
                s.setVisible(true);
                
            }
            else{
                JOptionPane.showMessageDialog(null, "Invalid combination of credentials. Please try again.");
            }
        }
            catch(Exception e){
                  JOptionPane.showMessageDialog(null, e); 
            } 
    }//GEN-LAST:event_signinbuttonMouseClicked

    private void signinbuttonKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_signinbuttonKeyPressed
        String sql="select * from Staff where staff_phone=? and staff_ID=?";
       
        try{
            
            pst=conn.prepareStatement(sql);
            pst.setString(1,user_field.getText());
            pst.setString(2,pass_field.getText());
            rs=pst.executeQuery();
            
            if(rs.next()){
                JOptionPane.showMessageDialog(null,"Your credentials are correct."+System.lineSeparator()+"Welcome to Cinema Database!"+System.lineSeparator()+"Created By Manos Sarris-AM:5191");
                close();
                
                
                supervisormain s=new supervisormain();
                s.setVisible(true);
                
            }
            else{
                JOptionPane.showMessageDialog(null, "Invalid combination of credentials. Please try again.");
            }
        }
            catch(Exception e){
                  JOptionPane.showMessageDialog(null, e); 
            } 
    }//GEN-LAST:event_signinbuttonKeyPressed

    private void formWindowOpened(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowOpened
        conn=Interface.ConnectDb();
    }//GEN-LAST:event_formWindowOpened

    private void connbuttonMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_connbuttonMouseClicked
        conn=CheckConnection.ConnectDb();
    }//GEN-LAST:event_connbuttonMouseClicked

    private void connbuttonKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_connbuttonKeyPressed
        conn=CheckConnection.ConnectDb();
    }//GEN-LAST:event_connbuttonKeyPressed


    public static void main(String args[]) {
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(SVLogin.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(SVLogin.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(SVLogin.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(SVLogin.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }

        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new SVLogin().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton connbutton;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JSeparator jSeparator1;
    private javax.swing.JSeparator jSeparator2;
    private javax.swing.JPasswordField pass_field;
    private javax.swing.JButton signinbutton;
    private javax.swing.JTextField user_field;
    // End of variables declaration//GEN-END:variables
}
