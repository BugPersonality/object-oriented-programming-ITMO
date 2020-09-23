using System;
using System.Collections.Generic;

namespace OOPLab_1
{
    public class Validator
    {
        private INIdata data;
        private INIParser2_0 parser;

        public Validator(string path)
        {
            parser = new INIParser2_0();
            data = parser.Parse_file(path);
        }
        
        public void CheckTryGetType()
        {
            Console.WriteLine($"{data.TryGetInt("COMMON", "LogNCMD")} == 1\n");
            Console.WriteLine($"{data.TryGetDouble("ADC_DEV", "ADC_DEV")} == 0.65\n");
            Console.WriteLine($"{data.TryGetString("ADC_DEV", "Driver")} == libusb\n");
        }

        public void CheckExceptions()
        {
            //try get int
            Console.WriteLine($"{data.TryGetInt("NCMD", "SampleRate")}\n");
            Console.WriteLine($"{data.TryGetInt("COMMON", "DiskCachePath")}\n");
            
            //try get double
            Console.WriteLine($"{data.TryGetDouble("LEGACY_XML", "ListenTcpPort")}\n");
            Console.WriteLine($"{data.TryGetDouble("COMMON", "DiskCachePath")}\n");
            
            //try get string
            Console.WriteLine($"{data.TryGetString("DEBUG", "PlentySockMaxQSize")}\n");
            Console.WriteLine($"{data.TryGetString("ADC_DEV", "ADC_DEV")}\n");
            
            //try get non exist section or name
            Console.WriteLine($"{data.TryGetInt("asd", "SampleRate")}\n");
            Console.WriteLine($"{data.TryGetDouble("LEGACY_XML", "asd")}\n");
            Console.WriteLine($"{data.TryGetString("asd", "ADC_DEV")}\n");
        }

        public void show_map()
        {
            foreach (KeyValuePair<string, Dictionary<string, string>> keyValue in data.map )
            {
                foreach (KeyValuePair<string, string> keyValuePair in keyValue.Value)
                {
                    Console.WriteLine(keyValue.Key + " " + keyValuePair.Key + " " + keyValuePair.Value);
                }
            }
        }
        
    }
}