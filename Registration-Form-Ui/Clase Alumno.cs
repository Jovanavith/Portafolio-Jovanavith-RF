using System;
using System.Collections.Generic;
using System.Diagnostics.Eventing.Reader;
using System.Linq;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;

namespace Formulario_de_Registro
{
    class Clase_Alumno
    {
        public String Nombre;
        public String Apellido;
        public int Edad;

        public Clase_Alumno(string Nombre, String Apellido, int Edad)
        {
            this.Nombre = Nombre;
            this.Apellido = Apellido;
            this.Edad = Edad;

        }
        public string getNombre()
        {
            return "Nombre " + Nombre;
        }
        public string getApellido() 
        {
            return "Apellido " + Apellido;
        }
        public int getEdad()
        {
            return Edad;
        }
   
        

        public void setTelefono(string Telefono) {
            
        } 

        public string imprimirDatos()
        {
            string Mensaje = "";
            Mensaje += "Nombre " + Nombre + ", Apellido " + Apellido + ", Edad " + Edad;
            return Mensaje;
        }
    }

    

}
