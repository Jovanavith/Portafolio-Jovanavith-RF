using System;

namespace Matriz
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int[,] matriz = {
                { 10, 25, 2 },
                { 102, 39, 20 },
                { 2010, 14, 89 }
            };

            int resultado = Metodo(matriz);

            Console.WriteLine("\nEl valor mínimo es: " + resultado);
        }

        static int Metodo(int[,] matriz)
        {
            int aux = matriz[0, 0];
            Console.WriteLine($"Valor inicial de aux: {aux}");

            for (int i = 0; i < matriz.GetLength(0); i++)
            {
                for (int j = 0; j < matriz.GetLength(1); j++)
                {
                    Console.WriteLine($"Comparando aux={aux} con matriz[{i},{j}]={matriz[i, j]}");

                    if (aux > matriz[i, j])
                    {
                        aux = matriz[i, j];
                        Console.WriteLine($"Nuevo valor de aux: {aux}");
                    }
                }
            }

            return aux;
        }
    }
}
