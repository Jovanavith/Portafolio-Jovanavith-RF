using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Matriz_1
{
    class Program
    {
        static void Main(string[] args)
        {
            int[,] matriz = {
                { 10, 25, 2 },
                { 102, 39, 20 },
                { 2010, 14, 89 }
            };

            //solo cambiamos aqui el nombre del metodo que utilicemos, osea metodo,
            //metodo 2 o metodo 3
            int resultado = Metodo3(matriz);

            Console.WriteLine("\nEl valor mínimo es: " + resultado);
        }


        static int Metodo3(int[,] matriz)
        {
            int aux = 0;
            for (int i = 0; i < matriz.GetLength(0); i++)
            {
                for (int j = 0; j < matriz.GetLength(1); j++)
                {
                    if (i < j)
                        aux = aux + matriz[i, j];
                }

            }
            return aux;
        }
    }
}

