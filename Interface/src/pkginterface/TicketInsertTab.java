package pkginterface;


import java.sql.*;
import javax.swing.*;
import java.sql.DriverManager;

public class TicketInsertTab extends javax.swing.JFrame {
    Connection con = null;
    public TicketInsertTab() {
        initComponents();
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jButton2 = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        jSeparator1 = new javax.swing.JSeparator();
        jButton1 = new javax.swing.JButton();
        customertabfield = new javax.swing.JTextField();
        movieidfield = new javax.swing.JTextField();
        jLabel2 = new javax.swing.JLabel();
        jLabel3 = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        jLabel5 = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        starttimefield = new javax.swing.JTextField();
        seatnumberfield = new javax.swing.JTextField();
        datefield = new javax.swing.JTextField();

        jButton2.setText("jButton2");

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setTitle("Staff Interface - Ticket Purchase");

        jLabel1.setText("Ticket Purchase Control Panel");

        jButton1.setText("Register Ticket");
        jButton1.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                jButton1MouseClicked(evt);
            }
        });
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });
        jButton1.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                jButton1KeyPressed(evt);
            }
        });

        jLabel2.setText("CustomerTabID:");

        jLabel3.setText("MovieID:");

        jLabel4.setText("Seat Number:");

        jLabel5.setText("Start Time:");

        jLabel6.setText("Date:");

        seatnumberfield.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                seatnumberfieldActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jLabel2)
                    .addComponent(jLabel5)
                    .addComponent(jLabel4))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(starttimefield)
                    .addComponent(customertabfield)
                    .addComponent(seatnumberfield))
                .addGap(73, 73, 73)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(jButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 167, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(jLabel6)
                            .addComponent(jLabel3))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                            .addComponent(movieidfield, javax.swing.GroupLayout.DEFAULT_SIZE, 73, Short.MAX_VALUE)
                            .addComponent(datefield))))
                .addGap(31, 31, 31))
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addGap(0, 0, Short.MAX_VALUE)
                .addComponent(jSeparator1, javax.swing.GroupLayout.PREFERRED_SIZE, 478, javax.swing.GroupLayout.PREFERRED_SIZE))
            .addGroup(layout.createSequentialGroup()
                .addGap(125, 125, 125)
                .addComponent(jLabel1)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addComponent(jLabel1)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jSeparator1, javax.swing.GroupLayout.PREFERRED_SIZE, 15, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel2)
                    .addComponent(customertabfield, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel3)
                    .addComponent(movieidfield, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel5)
                    .addComponent(jLabel6)
                    .addComponent(starttimefield, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(datefield, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(11, 11, 11)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel4)
                    .addComponent(seatnumberfield, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jButton1))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_jButton1ActionPerformed

    private void jButton1MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_jButton1MouseClicked
 
        try{
        Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cinema", "root", "myPassword");
        Statement stmt = conn.createStatement();
        String Query = "INSERT INTO Tickets "
                + "(`ticket_customer_tabID`,`ticket_movie_ID`, `ticket_seat_number`, `ticket_starttime` ,`ticket_date` ) "
                + "VALUES ('"+customertabfield.getText()+"' , '"+movieidfield.getText()+"' , '"+seatnumberfield.getText()+"' , '"+starttimefield.getText()+"' , '"+datefield.getText()+"')";
        
        stmt.execute(Query);
        
        // String Query = "insert into Movie_Awards VALUES ('"+customertabfield.getText()+"' , '"+movieidfield.getText()+"')";
        
        JOptionPane.showMessageDialog(null, "Ticket successfully purchased!");
        
        customertabfield.setText(null);
        movieidfield.setText(null);
        seatnumberfield.setText(null);
        starttimefield.setText(null);
        datefield.setText(null);
        
        }
        catch(SQLException exc){
            JOptionPane.showMessageDialog(null, exc.toString());
        
        }
        
    }//GEN-LAST:event_jButton1MouseClicked

    private void jButton1KeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_jButton1KeyPressed
 
        try{    
        Connection conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/cinema", "root", "myPassword");
        Statement stmt = conn.createStatement();
        String Query = "INSERT INTO Tickets "
                + "(`ticket_customer_tabID`,`ticket_movie_ID`, `ticket_seat_number`, `ticket_starttime` ,`ticket_date` ) "
                + "VALUES ('"+customertabfield.getText()+"' , '"+movieidfield.getText()+"' , '"+seatnumberfield.getText()+"' , '"+starttimefield.getText()+"' , '"+datefield.getText()+"')";
        
        stmt.execute(Query);
       
        // String Query = "insert into Movie_Awards VALUES ('"+customertabfield.getText()+"' , '"+movieidfield.getText()+"')";
        JOptionPane.showMessageDialog(null, "Ticket successfully purchased!");
        /*
        customertabfield.setText(null);
        movieidfield.setText(null);
        seatnumberfield.setText(null);
        starttimefield.setText(null);
        datefield.setText(null);
        */
        }
        catch(SQLException exc){
            JOptionPane.showMessageDialog(null, exc.toString());
        
        }
 
    }//GEN-LAST:event_jButton1KeyPressed

    private void seatnumberfieldActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_seatnumberfieldActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_seatnumberfieldActionPerformed

    public static void main(String args[]) {
        TicketInsertTab frame = new TicketInsertTab();
        frame.setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
        
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(TicketInsertTab.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(TicketInsertTab.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(TicketInsertTab.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(TicketInsertTab.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }

        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new TicketInsertTab().setVisible(true);
            }
        });       
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JTextField customertabfield;
    private javax.swing.JTextField datefield;
    private javax.swing.JButton jButton1;
    private javax.swing.JButton jButton2;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JSeparator jSeparator1;
    private javax.swing.JTextField movieidfield;
    private javax.swing.JTextField seatnumberfield;
    private javax.swing.JTextField starttimefield;
    // End of variables declaration//GEN-END:variables
}
