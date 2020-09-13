using System;

namespace OOPLab_1
{
    internal class Program
    {
        public static void Main(string[] args)
        {
            string path = "C:/Rider_Projects/OOPLab_1/OOPLab_1/test.ini";
            
            INIdata data = new INIdata(path);

            string command = "";

            while (command != "stop")
            {
                Console.Write("Enter the command: ");
                command = Console.ReadLine();

                if (command == "GetInt")
                {
                    int result = data.TryGetInt(Console.ReadLine(), Console.ReadLine());
                    
                    Console.WriteLine($"Result: {result}");
                }
                else if (command == "GetDb")
                {
                    double result = data.TryGetDouble(Console.ReadLine(), Console.ReadLine());
                    
                    Console.WriteLine($"Result: {result}");
                }
                else if (command == "GetStr")
                {
                    string result = data.TryGetString(Console.ReadLine(), Console.ReadLine());
                    
                    Console.WriteLine($"Result: {result}");
                }
            }
        }
    }
}