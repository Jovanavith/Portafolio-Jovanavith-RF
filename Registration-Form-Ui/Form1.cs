using System.Diagnostics.Eventing.Reader;

namespace Formulario_de_Registro
{
    public partial class Form1 : Form
    {
        Clase_Alumno alumno;
        string genero = "";
        string telefono = "";
        public Form1()
        {
            InitializeComponent();
            lstDatos.Items.Clear();
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void textBox5_TextChanged(object sender, EventArgs e)
        {
            if (txtTelefono.Text.Length >= 10)
            {
                MessageBox.Show("No se pueden superar mas de 10 digitos");
            }
            else
                telefono = txtTelefono.Text;
        }

        private void lstDatos_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void btnEnviar_Click(object sender, EventArgs e)
        {
            alumno = new Clase_Alumno(txtNombre.Text, txtApellido.Text, int.Parse(txtEdad.Text));
            lstDatos.Items.Add(alumno.imprimirDatos() + ", Genero: " + genero + ", Telefono: " + telefono);
            limpiarDatos();
        }

        private void rbMasc_CheckedChanged(object sender, EventArgs e)
        {
            if (rbMasc.Checked == true)
            {
                genero = "Masculino";
            }
            else
                genero = "Femenino";
        }

        private void groupBox1_Enter(object sender, EventArgs e)
        {

        }

        private void txtNombre_TextChanged(object sender, EventArgs e)
        {

        }
        private void limpiarDatos()
        {
            txtNombre.Clear();
            txtApellido.Clear();
            txtEdad.Clear();
            rbMasc.Checked = false;
            rbFem.Checked = false;
            txtTelefono.Clear();
        }
    }
}
