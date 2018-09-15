package mainpackage;

import java.awt.*;
import java.sql.*;
import java.util.*;
import javax.swing.*;
import javax.swing.table.*;
import java.time.*;
import java.sql.Date;
import java.text.*;
import static javax.swing.JFrame.EXIT_ON_CLOSE;

public class firstq extends JFrame
{
    public firstq()
    {
        ArrayList columnNames = new ArrayList();
        ArrayList data = new ArrayList();

        //  Connect to an MySQL Database, run query, get result set
        String url = "jdbc:mysql://localhost:3306/cinema";
        String userid = "root";
        String password = "myPassword";
        String sql = "SELECT \n" +
    "    `movie_title`, `movie_Genres`.`movie_genre`\n" +
    "FROM\n" +
    "    `Movies`\n" +
    "        INNER JOIN\n" +
    "    `cinema`.`movie_Genres`  ON `movie_Genres`.`mg_movie`         = `Movies`.`movie_ID`\n" +
    "        INNER JOIN\n" +
    "    `cinema`.`Rated`         ON `Rated`.`rated_movie_ID`          = `Movies`.`movie_id`\n" +
    "        LEFT JOIN\n" +
    "    `cinema`.`Tickets`       ON `Movies`.`movie_ID`               = `Tickets`.`ticket_movie_ID`\n" +
    "        LEFT JOIN\n" +
    "    `cinema`.`Customer`      ON `Tickets`.`ticket_customer_tabID` = `Customer`.`customer_tabID`\n" +
    "WHERE\n" +
    "    `Rated`.`rated_customerRatio` > 4\n" +
    "        AND `Customer`.`customer_sex` LIKE 'Male'\n" +
    "        AND `Tickets`.`ticket_date` > '2016-02-15'\n" +
    "        AND `Tickets`.`ticket_date` < '2016-02-19'\n" +
    "GROUP BY `movie_Genres`.`movie_genre`\n" +
    "ORDER BY `Movies`.`movie_title` ASC; ";

        
        // Java SE 7 has try-with-resources
        // This will ensure that the sql objects are closed when the program 
        // is finished with them
        try (Connection connection = DriverManager.getConnection( url, userid, password );
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery( sql ))
        {
            ResultSetMetaData md = rs.getMetaData();
            int columns = md.getColumnCount();

            //  Get column names
            for (int i = 1; i <= columns; i++)
            {
                columnNames.add( md.getColumnName(i) );
            }

            //  Get row data
            while (rs.next())
            {
                ArrayList row = new ArrayList(columns);

                for (int i = 1; i <= columns; i++)
                {
                    row.add( rs.getObject(i) );
                }

                data.add( row );
            }
        }
        catch (SQLException e)
        {
            System.out.println( e.getMessage() );
        }


        Vector columnNamesVector = new Vector();
        Vector dataVector = new Vector();

        for (int i = 0; i < data.size(); i++)
        {
            ArrayList subArray = (ArrayList)data.get(i);
            Vector subVector = new Vector();
            for (int j = 0; j < subArray.size(); j++)
            {
                subVector.add(subArray.get(j));
            }
            dataVector.add(subVector);
        }

        for (int i = 0; i < columnNames.size(); i++ )
            columnNamesVector.add(columnNames.get(i));

        //  Create table with database data    
        JTable table = new JTable(dataVector, columnNamesVector)
        {
            public Class getColumnClass(int column)
            {
                setTitle("Staff Interface - First Query");
                for (int row = 0; row < getRowCount(); row++)
                {
                    Object o = getValueAt(row, column);

                    if (o != null)
                    {
                        return o.getClass();
                    }
                }

                return Object.class;
            }
        };

        JScrollPane scrollPane = new JScrollPane( table );
        getContentPane().add( scrollPane );

        JPanel buttonPanel = new JPanel();
        getContentPane().add( buttonPanel, BorderLayout.SOUTH );
        
        TableCellRenderer tableCellRenderer = new DefaultTableCellRenderer() {
          
        // Time shown correction
       SimpleDateFormat f = new SimpleDateFormat("HH:mm:ss");
       public Component getTableCellRendererComponent(JTable table,
               Object value, boolean isSelected, boolean hasFocus,
            int row, int column) {
        if( value instanceof Time) {
            value = f.format(value);
        }
        return super.getTableCellRendererComponent(table, value, isSelected,
                hasFocus, row, column);
        }
      };
      table.setDefaultRenderer(Time.class, tableCellRenderer);
      // Time shown correction finish
        pack();
        
    }

    public static void main(String[] args)
    {
        firstq frame = new firstq();
        frame.setDefaultCloseOperation( EXIT_ON_CLOSE );
        frame.pack();
        frame.setVisible(true);
    }
}