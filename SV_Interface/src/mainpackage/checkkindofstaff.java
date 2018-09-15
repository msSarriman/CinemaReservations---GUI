package mainpackage;

public class checkkindofstaff extends javax.swing.JFrame {

    public checkkindofstaff() {
        initComponents();
    }

    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        cleanerbutton = new javax.swing.JToggleButton();
        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        sellerbutton = new javax.swing.JToggleButton();
        jLabel3 = new javax.swing.JLabel();
        sellerbutton1 = new javax.swing.JToggleButton();
        jSeparator1 = new javax.swing.JSeparator();
        jLabel4 = new javax.swing.JLabel();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        setTitle("SuperVisor Interface - Main Tab");

        cleanerbutton.setIcon(new javax.swing.ImageIcon(getClass().getResource("/mainpackage/images.jpg"))); // NOI18N
        cleanerbutton.setSelected(true);
        cleanerbutton.setText("jToggleButton1");
        cleanerbutton.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                cleanerbuttonMouseClicked(evt);
            }
        });
        cleanerbutton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cleanerbuttonActionPerformed(evt);
            }
        });

        jLabel1.setText("Choose the kind of Staff, that you want to see is Currently Working");

        jLabel2.setFont(new java.awt.Font("Dialog", 2, 12)); // NOI18N
        jLabel2.setText("Cleaners");

        sellerbutton.setIcon(new javax.swing.ImageIcon(getClass().getResource("/mainpackage/images (1).jpg"))); // NOI18N
        sellerbutton.setSelected(true);
        sellerbutton.setText("jToggleButton1");
        sellerbutton.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                sellerbuttonMouseClicked(evt);
            }
        });

        jLabel3.setFont(new java.awt.Font("Dialog", 2, 12)); // NOI18N
        jLabel3.setText("Stage Orders");

        sellerbutton1.setIcon(new javax.swing.ImageIcon(getClass().getResource("/mainpackage/images (2).jpg"))); // NOI18N
        sellerbutton1.setSelected(true);
        sellerbutton1.setText("jToggleButton1");
        sellerbutton1.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                sellerbutton1MouseClicked(evt);
            }
        });

        jLabel4.setFont(new java.awt.Font("Dialog", 2, 12)); // NOI18N
        jLabel4.setText("Ticket Sellers");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(cleanerbutton, javax.swing.GroupLayout.PREFERRED_SIZE, 169, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 36, Short.MAX_VALUE)
                .addComponent(sellerbutton, javax.swing.GroupLayout.PREFERRED_SIZE, 169, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(34, 34, 34)
                .addComponent(sellerbutton1, javax.swing.GroupLayout.PREFERRED_SIZE, 169, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
            .addComponent(jSeparator1)
            .addGroup(layout.createSequentialGroup()
                .addGap(57, 57, 57)
                .addComponent(jLabel1)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
            .addGroup(layout.createSequentialGroup()
                .addGap(69, 69, 69)
                .addComponent(jLabel2)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .addComponent(jLabel4)
                .addGap(128, 128, 128)
                .addComponent(jLabel3)
                .addGap(50, 50, 50))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(6, 6, 6)
                .addComponent(jLabel1)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(jSeparator1, javax.swing.GroupLayout.PREFERRED_SIZE, 10, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(cleanerbutton, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE)
                    .addComponent(sellerbutton, javax.swing.GroupLayout.PREFERRED_SIZE, 154, Short.MAX_VALUE)
                    .addComponent(sellerbutton1, javax.swing.GroupLayout.PREFERRED_SIZE, 154, Short.MAX_VALUE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel2)
                    .addComponent(jLabel3)
                    .addComponent(jLabel4))
                .addGap(5, 5, 5))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void cleanerbuttonMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_cleanerbuttonMouseClicked
        checkstaffcleaners s = new checkstaffcleaners();
        s.setVisible(true);
    }//GEN-LAST:event_cleanerbuttonMouseClicked

    private void sellerbuttonMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_sellerbuttonMouseClicked
        ticketsellers s=new ticketsellers();
        s.setVisible(true);
    }//GEN-LAST:event_sellerbuttonMouseClicked

    private void sellerbutton1MouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_sellerbutton1MouseClicked
        stageorders s=new stageorders();
        s.setVisible(true);
    }//GEN-LAST:event_sellerbutton1MouseClicked

    private void cleanerbuttonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cleanerbuttonActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_cleanerbuttonActionPerformed

    public static void main(String args[]) {

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
            java.util.logging.Logger.getLogger(checkkindofstaff.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(checkkindofstaff.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(checkkindofstaff.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(checkkindofstaff.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>


        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new checkkindofstaff().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JToggleButton cleanerbutton;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JSeparator jSeparator1;
    private javax.swing.JToggleButton sellerbutton;
    private javax.swing.JToggleButton sellerbutton1;
    // End of variables declaration//GEN-END:variables
}
