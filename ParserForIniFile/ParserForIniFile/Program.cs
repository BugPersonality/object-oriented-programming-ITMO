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
            string path = "C:/Rider_Projects/ParserForIniFile/ParserForIniFile/test.ini";
            
            Validator validator = new Validator(path);
            validator.CheckTryGetType();
            validator.CheckExceptions();
            validator.Show_map();
            
            /*INIParser2_0 parser20 = new INIParser2_0();
            
            INIdata idata = parser20.Parse_file(path);
            
            Console.WriteLine(idata.Get<string>("ADC_DEV", "SampleRate", typeof(string)));*/
            
        }
    }
}