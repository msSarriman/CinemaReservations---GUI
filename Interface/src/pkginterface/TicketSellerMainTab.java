package pkginterface;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.*;
import java.util.*;
import javax.swing.*;
import java.time.*;
import java.sql.Date;
import java.text.*;

public class TicketSellerMainTab extends javax.swing.JFrame{

    Connection conn=null;
    PreparedStatement pst=null;
    ResultSet rs=null;
        
    String url = "jdbc:mysql://localhost:3306/cinema";
    String userid = "root";
    String password = "myPassword";
    String sql;
       
    public TicketSellerMainTab() {
        initComponents();        
    }

    
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jButton2 = new javax.swing.JButton();
        jPanel1 = new javax.swing.JPanel();
        customerbutton = new javax.swing.JButton();
        jButton1 = new javax.swing.JButton();
        jLabel1 = new javax.swing.JLabel();
        todaysmoviebutton = new javax.swing.JButton();
        jSeparator1 = new javax.swing.JSeparator();
        jSeparator2 = new javax.swing.JSeparator();
        freeseats = new javax.swing.JButton();
        freeticketbutton = new javax.swing.JButton();
        ticketbookbutton = new javax.swing.JButton();

        jButton2.setText("jButton2");
        jButton2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton2ActionPerformed(evt);
            }
        });

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("Staff Interface - Customer Info");

        customerbutton.setText("All Customers Tab");
        customerbutton.setPreferredSize(new java.awt.Dimension(164, 25));
        customerbutton.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                customerbuttonMouseClicked(evt);
            }
        });
        customerbutton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                customerbuttonActionPerformed(evt);
            }
        });
        customerbutton.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                customerbuttonKeyPressed(evt);
            }
        });

        jButton1.setText("Specific Customer");
        jButton1.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                SpecidicCustomerM(evt);
            }
        });
        jButton1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jButton1ActionPerformed(evt);
            }
        });
        jButton1.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                SpecificCustomerK(evt);
            }
        });

        javax.swing.GroupLayout jPanel1Layout = new javax.swing.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(customerbutton, javax.swing.GroupLayout.PREFERRED_SIZE, 164, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addComponent(jButton1, javax.swing.GroupLayout.PREFERRED_SIZE, 166, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(jPanel1Layout.createSequentialGroup()
                .addGroup(jPanel1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(customerbutton, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jButton1))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        jLabel1.setText("    Please choose one of the following actions:");

        todaysmoviebutton.setText("Todays Movies");
        todaysmoviebutton.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                todaysmoviebuttonMouseClicked(evt);
            }
        });
        todaysmoviebutton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                todaysmoviebuttonActionPerformed(evt);
            }
        });
        todaysmoviebutton.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                todaysmoviebuttonKeyPressed(evt);
            }
        });

        freeseats.setText("Free Seats");
        freeseats.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                freeseatsMouseClicked(evt);
            }
        });
        freeseats.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                freeseatsActionPerformed(evt);
            }
        });
        freeseats.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                freeseatsKeyPressed(evt);
            }
        });

        freeticketbutton.setText("Free Ticket Check");
        freeticketbutton.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseReleased(java.awt.event.MouseEvent evt) {
                freeticketbuttonMouseReleased(evt);
            }
        });
        freeticketbutton.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                freeticketbuttonKeyPressed(evt);
            }
        });

        ticketbookbutton.setText("Ticket Purchase");
        ticketbookbutton.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                ticketbookbuttonMouseClicked(evt);
            }
        });
        ticketbookbutton.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                ticketbookbuttonKeyPressed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addComponent(jPanel1, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jSeparator2)
                    .addComponent(jSeparator1)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(jLabel1)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(todaysmoviebutton, javax.swing.GroupLayout.PREFERRED_SIZE, 164, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(18, 18, 18)
                                .addComponent(freeseats, javax.swing.GroupLayout.PREFERRED_SIZE, 164, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(freeticketbutton, javax.swing.GroupLayout.PREFERRED_SIZE, 164, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(18, 18, 18)
                                .addComponent(ticketbookbutton, javax.swing.GroupLayout.PREFERRED_SIZE, 166, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addGap(0, 0, Short.MAX_VALUE)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addComponent(jLabel1)
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(todaysmoviebutton)
                    .addComponent(freeseats))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jSeparator1, javax.swing.GroupLayout.PREFERRED_SIZE, 10, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(ticketbookbutton)
                    .addComponent(freeticketbutton))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jSeparator2, javax.swing.GroupLayout.PREFERRED_SIZE, 10, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jPanel1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void jButton2ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton2ActionPerformed
 //LEAVE BLANK
    }//GEN-LAST:event_jButton2ActionPerformed

    private void todaysmoviebuttonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_todaysmoviebuttonActionPerformed
 //LEAVE BLANK
    }//GEN-LAST:event_todaysmoviebuttonActionPerformed

    private void todaysmoviebuttonMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_todaysmoviebuttonMouseClicked
        Movies_Info s=new Movies_Info();
        s.setVisible(true);
    }//GEN-LAST:event_todaysmoviebuttonMouseClicked

    private void customerbuttonMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_customerbuttonMouseClicked
        CustomerInfo s1=new CustomerInfo();
        s1.setVisible(true);
    }//GEN-LAST:event_customerbuttonMouseClicked

    private void customerbuttonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_customerbuttonActionPerformed
 //LEAVE BLANK
    }//GEN-LAST:event_customerbuttonActionPerformed

    private void jButton1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton1ActionPerformed
       
    }//GEN-LAST:event_jButton1ActionPerformed

    private void ticketbookbuttonMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_ticketbookbuttonMouseClicked
        TicketInsertTab s = new TicketInsertTab();
        s.setVisible(true);
    }//GEN-LAST:event_ticketbookbuttonMouseClicked

    private void ticketbookbuttonKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_ticketbookbuttonKeyPressed
        TicketInsertTab s = new TicketInsertTab();
        s.setVisible(true);       
    }//GEN-LAST:event_ticketbookbuttonKeyPressed

    private void todaysmoviebuttonKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_todaysmoviebuttonKeyPressed

        Movies_Info s=new Movies_Info();
        s.setVisible(true);
    }//GEN-LAST:event_todaysmoviebuttonKeyPressed

    private void customerbuttonKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_customerbuttonKeyPressed
        CustomerInfo s1=new CustomerInfo();
        s1.setVisible(true);
    }//GEN-LAST:event_customerbuttonKeyPressed

    private void SpecidicCustomerM(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_SpecidicCustomerM
        customersearch s2=new customersearch();
        s2.setVisible(true);
    }//GEN-LAST:event_SpecidicCustomerM

    private void SpecificCustomerK(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_SpecificCustomerK
        customersearch s2=new customersearch();
        s2.setVisible(true);
    }//GEN-LAST:event_SpecificCustomerK

    private void freeticketbuttonMouseReleased(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_freeticketbuttonMouseReleased
        freeticketcheck s=new freeticketcheck();
        s.setVisible(true);
    }//GEN-LAST:event_freeticketbuttonMouseReleased

    private void freeseatsMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_freeseatsMouseClicked
        FreeSeats s2=new FreeSeats();
        s2.setVisible(true);
    }//GEN-LAST:event_freeseatsMouseClicked

    private void freeseatsActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_freeseatsActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_freeseatsActionPerformed

    private void freeseatsKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_freeseatsKeyPressed
        FreeSeats s2=new FreeSeats();
        s2.setVisible(true);
    }//GEN-LAST:event_freeseatsKeyPressed

    private void freeticketbuttonKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_freeticketbuttonKeyPressed
        freeticketcheck s=new freeticketcheck();
        s.setVisible(true);
    }//GEN-LAST:event_freeticketbuttonKeyPressed

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
            java.util.logging.Logger.getLogger(TicketSellerMainTab.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(TicketSellerMainTab.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(TicketSellerMainTab.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(TicketSellerMainTab.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new TicketSellerMainTab().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton customerbutton;
    private javax.swing.JButton freeseats;
    private javax.swing.JButton freeticketbutton;
    private javax.swing.JButton jButton1;
    private javax.swing.JButton jButton2;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JSeparator jSeparator1;
    private javax.swing.JSeparator jSeparator2;
    private javax.swing.JButton ticketbookbutton;
    private javax.swing.JButton todaysmoviebutton;
    // End of variables declaration//GEN-END:variables


}
