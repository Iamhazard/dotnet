using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace WindowsFormsApp1
{
    public partial class studentData : Form
    {
        public studentData()
        {
            InitializeComponent();
        }

        private void studentData_Load(object sender, EventArgs e)
        {
            dgvStudentInfo.DataSource = GetAllRecord("DESKTOP-UV1GG8R", "sandip", "tblstudent");
        }
        private DataTable GetAllRecord(string servername, string databasename, string tblname)
        {
            SqlConnection conn = new SqlConnection("server="+servername + "; database="+databasename+"; integrated security = true;");
            conn.Open();
            SqlCommand cmd = new SqlCommand("select*from "+tblname +"");
            cmd.Connection = conn;
            DataTable dt = new DataTable();
            SqlDataAdapter adp = new SqlDataAdapter(cmd);
            adp.Fill(dt);
            conn.Close();
            return (dt);
             
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
        private void DatabaseInsert()
        {
            SqlConnection conn = new SqlConnection("server=DESKTOP-UV1GG8R; database=sandip; integrated security = true;");
            conn.Open();
            SqlCommand cmd = new SqlCommand("insert into tblstudent" +
                "( Name, Email, Age, DOB, Address, Gender)" +
                "values( @Name, @Email, @Age, @DOB, @Address, @Gender)");
            cmd.Parameters.AddWithValue("@Name", txtName.Text);
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
            cmd.Parameters.AddWithValue("@Age", nuAge.Text);
            cmd.Parameters.AddWithValue("@DOB", dtpdob.Text);
            cmd.Parameters.AddWithValue("@Address", txtAddress.Text);
            cmd.Parameters.AddWithValue("@Gender", cbGender.Text);

            cmd.Connection = conn;

            //execute query
            int ans = cmd.ExecuteNonQuery();
            if (ans > 0)
                MessageBox.Show("data saved!");
            else
                MessageBox.Show("data save Failed!");
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            DatabaseInsert();
            dgvStudentInfo.DataSource = GetAllRecord("DESKTOP-UV1GG8R", "sandip", "tblstudent");

        }
    }
}
