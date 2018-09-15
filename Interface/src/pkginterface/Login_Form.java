package pkginterface;

import java.awt.*;
import java.awt.event.WindowEvent;
import java.sql.*;
import javax.swing.*;

public class Login_Form extends javax.swing.JFrame {

    Connection conn=null;
    PreparedStatement pst=null;
    ResultSet rs=null;
    
    public Login_Form() {
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
        user_field = new javax.swing.JTextField();
        pass_field = new javax.swing.JPasswordField();
        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        jButton1 = new javax.swing.JButton();
        jLabel5 = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        jLabel7 = new javax.swing.JLabel();
        jLabel8 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setTitle("Staff Interface - Log In");
        setBackground(new java.awt.Color(204, 204, 204));
        setCursor(new java.awt.Cursor(java.awt.Cursor.DEFAULT_CURSOR));
        setMaximizedBounds(new java.awt.Rectangle(0, 0, 0, 0));
        setMinimumSize(new java.awt.Dimension(357, 216));
        setResizable(false);
        setSize(new java.awt.Dimension(347, 216));
        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowOpened(java.awt.event.WindowEvent evt) {
                formWindowOpened(evt);
            }
        });
        getContentPane().setLayout(null);
        getContentPane().add(jSeparator1);
        jSeparator1.setBounds(0, 50, 360, 10);
        getContentPane().add(user_field);
        user_field.setBounds(183, 59, 110, 30);
        getContentPane().add(pass_field);
        pass_field.setBounds(183, 89, 110, 30);

        jLabel1.setText("Welcome to Cinema Database Log In GUI");
        getContentPane().add(jLabel1);
        jLabel1.setBounds(40, 10, 287, 15);

        jLabel2.setFont(new java.awt.Font("Dialog", 2, 12)); // NOI18N
        jLabel2.setText("Please  enter  your  login  credentials  bellow");
        getContentPane().add(jLabel2);
        jLabel2.setBounds(30, 30, 281, 20);

        jLabel3.setText("Username:");
        getContentPane().add(jLabel3);
        jLabel3.setBounds(100, 70, 77, 15);

        jLabel4.setText("Password:");
        getContentPane().add(jLabel4);
        jLabel4.setBounds(100, 100, 75, 15);

        jButton1.setText("Sign In");
        jButton1.setCursor(new java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
        jButton1.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jButton1MouseClicked(evt);
            }
        });
        jButton1.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                jButton1KeyPressed(evt);
            }
        });
        getContentPane().add(jButton1);
        jButton1.setBounds(150, 140, 82, 25);

        jLabel5.setIcon(new javax.swing.ImageIcon(getClass().getResource("/pkginterface/upatras_logo.png"))); // NOI18N
        jLabel5.setToolTipText("");
        getContentPane().add(jLabel5);
        jLabel5.setBounds(0, 50, 340, 110);

        jLabel6.setFont(new java.awt.Font("Dialog", 2, 11)); // NOI18N
        jLabel6.setText("Only Staff Members Are Allowed to Login through this Tab.");
        getContentPane().add(jLabel6);
        jLabel6.setBounds(0, 170, 340, 20);

        jLabel7.setFont(new java.awt.Font("Dialog", 2, 10)); // NOI18N
        jLabel7.setText(" your I.D.");
        getContentPane().add(jLabel7);
        jLabel7.setBounds(290, 100, 220, 13);

        jLabel8.setFont(new java.awt.Font("Dialog", 2, 10)); // NOI18N
        jLabel8.setText(" your Phone");
        getContentPane().add(jLabel8);
        jLabel8.setBounds(290, 70, 220, 13);

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void formWindowOpened(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowOpened
        conn=Interface.ConnectDb();
    }//GEN-LAST:event_formWindowOpened

    private void jButton1MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jButton1MouseClicked
        String sql="select * from Staff INNER JOIN TicketSeller on ticketseller_staff_ID=staff_ID"
                + " where staff_phone=? and staff_ID=? AND ticketseller_staff_ID = staff_ID";
       
        try{
            
            pst=conn.prepareStatement(sql);
            pst.setString(1,user_field.getText());
            pst.setString(2,pass_field.getText());
            rs=pst.executeQuery();
            
            if(rs.next()){
                JOptionPane.showMessageDialog(null,"Your credentials are correct."+System.lineSeparator()+"Welcome to Cinema Database!"+System.lineSeparator()+"Created By Manos Sarris-AM:5191");
                close();
                
                
                TicketSellerMainTab s=new TicketSellerMainTab();
                s.setVisible(true);
                
            }
            else{
                JOptionPane.showMessageDialog(null, "Invalid combination of credentials. Please try again.");
            }
        }
            catch(Exception e){
                  JOptionPane.showMessageDialog(null, e); 
            }             
    }//GEN-LAST:event_jButton1MouseClicked

    private void jButton1KeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_jButton1KeyPressed
           String sql="select * from Staff where staff_phone=? and staff_ID=?";
       
        try{
            
            pst=conn.prepareStatement(sql);
            pst.setString(1,user_field.getText());
            pst.setString(2,pass_field.getText());
            rs=pst.executeQuery();
            
            if(rs.next()){
                JOptionPane.showMessageDialog(null,"Your credentials are correct."+System.lineSeparator()+"Welcome to Cinema Database!"+System.lineSeparator()+"Created By Manos Sarris-AM:5191");
                close();
                
                
                TicketSellerMainTab s=new TicketSellerMainTab();
                s.setVisible(true);
                
            }
            else{
                JOptionPane.showMessageDialog(null, "Invalid combination of credentials. Please try again.");
            }
        }
            catch(Exception e){
                  JOptionPane.showMessageDialog(null, e); 
            } 
    }//GEN-LAST:event_jButton1KeyPressed

    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(Login_Form.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(Login_Form.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(Login_Form.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(Login_Form.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>

        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new Login_Form().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton jButton1;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JSeparator jSeparator1;
    private javax.swing.JPasswordField pass_field;
    private javax.swing.JTextField user_field;
    // End of variables declaration//GEN-END:variables
}
