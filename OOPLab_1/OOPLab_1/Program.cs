using System.IO;
using System;
using System.Collections.Generic;
using System.Linq;
using static OOPLab_1.INIParser2_0;

namespace OOPLab_1
{
    internal class Program
    {
        public static void Main(string[] args)
        {
            string path = "C:/Rider_Projects/OOPLab_1/OOPLab_1/test.ini";
            
            /*INIParser2_0 parser = new INIParser2_0();

            INIdata data = parser.Parse_file(path);

            foreach (KeyValuePair<string, Dictionary<string, string>> keyValue in data.map )
            {
                foreach (KeyValuePair<string, string> keyValuePair in keyValue.Value)
                {
                    Console.WriteLine(keyValue.Key + " " + keyValuePair.Key + " " + keyValuePair.Value);
                }
            }*/
            
            Validator validator = new Validator(path);
            validator.CheckTryGetType();
            validator.CheckExceptions();
        }
    }
}