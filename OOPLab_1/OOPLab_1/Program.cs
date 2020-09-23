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
            
            Validator validator = new Validator(path);
            validator.CheckTryGetType();
            validator.CheckExceptions();
            validator.show_map();
            
        }
    }
}