using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;
using System.Configuration;

namespace testproj
{
    public partial class Form1 : Form
    {
        SqlConnection con = new SqlConnection("Data Source = DESKTOP-1D792CJ\\SQLEXPRESS; Initial Catalog = Terrorism; Integrated Security = true");
        SqlDataAdapter da = new SqlDataAdapter();
        SqlDataAdapter da2 = new SqlDataAdapter();
        DataSet ds = new DataSet();
        DataSet ds2 = new DataSet();

        List<TextBox> textBoxList1 = new List<TextBox>();
        List<Label> labelList1 = new List<Label>();
        List<TextBox> textBoxList2 = new List<TextBox>();
        List<Label> labelList2 = new List<Label>();
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            //string db_connection = ConfigurationManager.AppSettings["db_connection"];
            //SqlConnection con = new SqlConnection(db_connection);
            ds.Clear();
            string parent = ConfigurationManager.AppSettings["parent"];
            Console.WriteLine(parent);
            da.SelectCommand = new SqlCommand("Select * from " + parent, con);
            da.Fill(ds, "Parent");
            label1.Text = parent; 
            dataGridView1.DataSource = ds.Tables["Parent"];
            dataGridView1.Rows[0].Selected = true;
            setUpParentPanel();
            setUpChildPanel();
            dataGridView1.Rows[0].Selected = true;
            dataGridView1_RowHeaderMouseClick(sender, null);
        }
        
        private void setUpParentPanel()
        {
            int idx = 0;
            int columns = ds.Tables["Parent"].Columns.Count;

            for (int i = 0; i < columns ; i++)
            {
                Label label = new Label();
                label.Text = ds.Tables["Parent"].Columns[i].ColumnName;

                Point textP = new Point(idx * 120, 44);
                Point lableP = new Point(idx * 120, 30);
                label.Location = lableP;
                label.AutoSize = true;

                TextBox textBox = new TextBox();
                textBox.Location = textP;
                textBox.ReadOnly = true;
                textBoxList1.Add(textBox);
                labelList1.Add(label);
                idx++;

                panel1.Controls.Add(label);
                panel1.Controls.Add(textBox);
            }
        }

        private void setUpChildPanel()
        {

            Form2_load();
            int idx = 0;
            int columns = ds2.Tables["Child"].Columns.Count;

            for (int i = 0; i < columns; i++)
            {
                Label label = new Label();
                label.Text = ds2.Tables["Child"].Columns[i].ColumnName;

                Point textP = new Point(idx * 120, 44);
                Point lableP = new Point(idx * 120, 30);
                label.Location = lableP;
                label.AutoSize = true;

                TextBox textBox = new TextBox();
                textBox.Location = textP;
                textBoxList2.Add(textBox);
                labelList2.Add(label);

                if (label.Text == ConfigurationManager.AppSettings["child_pk"] || label.Text == ConfigurationManager.AppSettings["child_fk"])
                    textBox.ReadOnly = true;

                idx++;

                panel2.Controls.Add(label);
                panel2.Controls.Add(textBox);
            }
        }


        private void dataGridView1_RowHeaderMouseClick(object sender, DataGridViewCellMouseEventArgs e)
        {
            int columns = ds.Tables["Parent"].Columns.Count;
            for (int i = 0; i < columns; i++) {
                textBoxList1[i].Text = dataGridView1.CurrentRow.Cells[i].Value.ToString();
            }
            if (textBoxList1[0].Text != "") {
                Form2_load();
                dataGridView2.Rows[0].Selected = true;
                dataGridView2_RowHeaderMouseClick(sender, null);
            }
            else
            {
                ds2.Clear();
                dataGridView2.DataSource = null;
                dataGridView2.Rows.Clear();

                columns = ds2.Tables["Child"].Columns.Count;
                for (int i = 0; i < columns; i++)
                {
                    textBoxList2[i].Text = "";
                }
            }
        }

        private void Form2_load()
        {
            ds2.Clear();
            string child = ConfigurationManager.AppSettings["child"];
            string child_fk = ConfigurationManager.AppSettings["child_fk"];
            da2.SelectCommand = new SqlCommand("Select * from " + child + " where " + child_fk + " = @value0", con);
            da2.SelectCommand.Parameters.AddWithValue("@value0", textBoxList1[0].Text);
            da2.Fill(ds2, "Child");
            label2.Text = child;
            dataGridView2.DataSource = ds2.Tables["Child"];
        }

        private void dataGridView2_RowHeaderMouseClick(object sender, DataGridViewCellMouseEventArgs e)
        {
            int columns = ds2.Tables["Child"].Columns.Count;
            for (int i = 0; i < columns; i++) {
                textBoxList2[i].Text = dataGridView2.CurrentRow.Cells[i].Value.ToString();
            }
        }

        private void buttonInsert_Click(object sender, EventArgs e)
        {
            if (textBoxList2[2].Text != "")
            {
                string child = ConfigurationManager.AppSettings["child"];
                string child_param = ConfigurationManager.AppSettings["child_param"];
                string child_values = ConfigurationManager.AppSettings["child_values"];
                da2.InsertCommand = new SqlCommand("Insert into " + child + "("+ child_param + ") Values(" + child_values + ")", con);

                int columns = ds2.Tables["Child"].Columns.Count;
                for (int i = 1; i < columns; i++)
                {
                    da2.InsertCommand.Parameters.AddWithValue("@value"+i.ToString(), textBoxList2[i].Text);
                }

                con.Open();
                da2.InsertCommand.ExecuteNonQuery();
                con.Close();

                dataGridView2.Rows[0].Selected = true;
                dataGridView2_RowHeaderMouseClick(sender, null);
                Form2_load();
            }
            else
                MessageBox.Show("Void Value!");
        }

        private void buttonDelete_Click(object sender, EventArgs e)
        {
            if (textBoxList2[2].Text != "")
            {
                string child = ConfigurationManager.AppSettings["child"];
                string child_pk = ConfigurationManager.AppSettings["child_pk"];
                da2.DeleteCommand = new SqlCommand("Delete from " + child + " where " + child_pk + " = @value0", con);

                da2.DeleteCommand.Parameters.AddWithValue("@value0", textBoxList2[0].Text);

                con.Open();
                da2.DeleteCommand.ExecuteNonQuery();
                con.Close();

                dataGridView2.Rows[0].Selected = true;
                dataGridView2_RowHeaderMouseClick(sender, null);
                Form2_load();
            }
            else
                MessageBox.Show("Void Value!");
        }

        private void buttonUpdate_Click(object sender, EventArgs e)
        {
            if (textBoxList2[2].Text != "")
            {
                string child = ConfigurationManager.AppSettings["child"];
                string child_pk = ConfigurationManager.AppSettings["child_pk"];
                string child_set_values = ConfigurationManager.AppSettings["child_set_values"];
                da2.UpdateCommand = new SqlCommand("Update " + child + " Set " + child_set_values + " where " + child_pk + " = @value0", con);

                int columns = ds2.Tables["Child"].Columns.Count;
                for (int i = 0; i < columns; i++)
                {
                    da2.UpdateCommand.Parameters.AddWithValue("@value" + i.ToString(), textBoxList2[i].Text);
                }
           
                con.Open();
                da2.UpdateCommand.ExecuteNonQuery();
                con.Close();

                dataGridView2.Rows[0].Selected = true;
                dataGridView2_RowHeaderMouseClick(sender, null);
                Form2_load();
            }
            else
                MessageBox.Show("Void Value!");
        }
        
    }
}
