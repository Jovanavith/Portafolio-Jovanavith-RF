namespace Formulario_de_Registro
{
    partial class Form1
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            label1 = new Label();
            label2 = new Label();
            label3 = new Label();
            label4 = new Label();
            label5 = new Label();
            txtNombre = new TextBox();
            txtApellido = new TextBox();
            txtEdad = new TextBox();
            txtTelefono = new TextBox();
            btnEnviar = new Button();
            lstDatos = new ListBox();
            rbMasc = new RadioButton();
            rbFem = new RadioButton();
            gbGenero = new GroupBox();
            SuspendLayout();
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 0);
            label1.Location = new Point(25, 24);
            label1.Name = "label1";
            label1.Size = new Size(97, 28);
            label1.TabIndex = 0;
            label1.Text = "Nombres:";
            label1.Click += label1_Click;
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 0);
            label2.Location = new Point(25, 68);
            label2.Name = "label2";
            label2.Size = new Size(98, 28);
            label2.TabIndex = 1;
            label2.Text = "Apellidos:";
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 0);
            label3.Location = new Point(25, 116);
            label3.Name = "label3";
            label3.Size = new Size(60, 28);
            label3.TabIndex = 2;
            label3.Text = "Edad:";
            label3.Click += label3_Click;
            // 
            // label4
            // 
            label4.AutoSize = true;
            label4.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 0);
            label4.Location = new Point(25, 164);
            label4.Name = "label4";
            label4.Size = new Size(80, 28);
            label4.TabIndex = 3;
            label4.Text = "Género:";
            // 
            // label5
            // 
            label5.AutoSize = true;
            label5.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 0);
            label5.Location = new Point(25, 220);
            label5.Name = "label5";
            label5.Size = new Size(90, 28);
            label5.TabIndex = 4;
            label5.Text = "Teléfono:";
            label5.Click += label5_Click;
            // 
            // txtNombre
            // 
            txtNombre.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 0);
            txtNombre.Location = new Point(175, 12);
            txtNombre.Name = "txtNombre";
            txtNombre.Size = new Size(362, 34);
            txtNombre.TabIndex = 5;
            txtNombre.TextChanged += txtNombre_TextChanged;
            // 
            // txtApellido
            // 
            txtApellido.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 0);
            txtApellido.Location = new Point(175, 65);
            txtApellido.Name = "txtApellido";
            txtApellido.Size = new Size(362, 34);
            txtApellido.TabIndex = 6;
            // 
            // txtEdad
            // 
            txtEdad.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 0);
            txtEdad.Location = new Point(175, 110);
            txtEdad.Name = "txtEdad";
            txtEdad.Size = new Size(362, 34);
            txtEdad.TabIndex = 7;
            // 
            // txtTelefono
            // 
            txtTelefono.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 0);
            txtTelefono.Location = new Point(175, 213);
            txtTelefono.Name = "txtTelefono";
            txtTelefono.Size = new Size(362, 34);
            txtTelefono.TabIndex = 9;
            txtTelefono.TextChanged += textBox5_TextChanged;
            // 
            // btnEnviar
            // 
            btnEnviar.Location = new Point(617, 119);
            btnEnviar.Name = "btnEnviar";
            btnEnviar.Size = new Size(94, 29);
            btnEnviar.TabIndex = 10;
            btnEnviar.Text = ">>>>>";
            btnEnviar.UseVisualStyleBackColor = true;
            btnEnviar.Click += btnEnviar_Click;
            // 
            // lstDatos
            // 
            lstDatos.FormattingEnabled = true;
            lstDatos.Location = new Point(717, 34);
            lstDatos.Name = "lstDatos";
            lstDatos.Size = new Size(599, 244);
            lstDatos.TabIndex = 11;
            lstDatos.SelectedIndexChanged += lstDatos_SelectedIndexChanged;
            // 
            // rbMasc
            // 
            rbMasc.AutoSize = true;
            rbMasc.Location = new Point(175, 168);
            rbMasc.Name = "rbMasc";
            rbMasc.Size = new Size(97, 24);
            rbMasc.TabIndex = 12;
            rbMasc.TabStop = true;
            rbMasc.Text = "Masculino";
            rbMasc.UseVisualStyleBackColor = true;
            rbMasc.CheckedChanged += rbMasc_CheckedChanged;
            // 
            // rbFem
            // 
            rbFem.AutoSize = true;
            rbFem.Location = new Point(310, 168);
            rbFem.Name = "rbFem";
            rbFem.Size = new Size(95, 24);
            rbFem.TabIndex = 13;
            rbFem.TabStop = true;
            rbFem.Text = "Femenino";
            rbFem.UseVisualStyleBackColor = true;
            // 
            // gbGenero
            // 
            gbGenero.Location = new Point(175, 150);
            gbGenero.Name = "gbGenero";
            gbGenero.Size = new Size(362, 57);
            gbGenero.TabIndex = 15;
            gbGenero.TabStop = false;
            gbGenero.Text = "Género";
            gbGenero.Enter += groupBox1_Enter;
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            BackgroundImage = Properties.Resources.Gatonto;
            ClientSize = new Size(1320, 487);
            Controls.Add(rbFem);
            Controls.Add(rbMasc);
            Controls.Add(lstDatos);
            Controls.Add(btnEnviar);
            Controls.Add(txtTelefono);
            Controls.Add(txtEdad);
            Controls.Add(txtApellido);
            Controls.Add(txtNombre);
            Controls.Add(label5);
            Controls.Add(label4);
            Controls.Add(label3);
            Controls.Add(label2);
            Controls.Add(label1);
            Controls.Add(gbGenero);
            Name = "Form1";
            Text = "Registro";
            Load += Form1_Load;
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Label label1;
        private Label label2;
        private Label label3;
        private Label label4;
        private Label label5;
        private TextBox txtNombre;
        private TextBox txtApellido;
        private TextBox txtEdad;
        private TextBox txtTelefono;
        private Button btnEnviar;
        private ListBox lstDatos;
        private RadioButton rbMasc;
        private RadioButton rbFem;
        private GroupBox gbGenero;
    }
}
