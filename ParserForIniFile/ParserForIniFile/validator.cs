using System;
using System.Collections.Generic;

namespace OOPLab_1
{
    public class Validator
    {
        private readonly INIdata data;

        public Validator(string path)
        {
            var parser = new INIParser2_0();
            try
            {
                data = parser.Parse_file(path);
            }
            catch (FileException e)
            {
                Console.WriteLine(e.Message + $"Path : {e.Path}");
                throw;
            }
            
        }
        
        public void CheckTryGetType()
        {
            Console.WriteLine($"{data.TryGetInt("COMMON", "LogNCMD")} == 1\n");
            Console.WriteLine($"{data.TryGetDouble("ADC_DEV", "ADC_DEV")} == 0.65\n");
            Console.WriteLine($"{data.TryGetString("ADC_DEV", "Driver")} == libusb\n");
        }

        public void CheckExceptions()
        {
            
            try
            {
                Console.WriteLine($"{data.TryGetInt("NCMD", "SampleRate")}\n");
            }
            catch (TypeException e)
            {
                Console.WriteLine(e.Message + $"\n wrong type : {e.Type()} \n");
            }

            try
            {
                Console.WriteLine($"{data.TryGetInt("COMMON", "DiskCachePath")}\n");
            }
            catch (TypeException e)
            {
                Console.WriteLine(e.Message + $"\n wrong type : {e.Type()} \n");
            }
            
            try
            {
                Console.WriteLine($"{data.TryGetDouble("LEGACY_XML", "ListenTcpPort")}\n");
            }
            catch (TypeException e)
            {
                Console.WriteLine(e.Message + $"\n wrong type : {e.Type()} \n");
            }
            
            try
            {
                Console.WriteLine($"{data.TryGetDouble("COMMON", "DiskCachePath")}\n");
            }
            catch (TypeException e)
            {
                Console.WriteLine(e.Message + $"\n wrong type : {e.Type()} \n");
            }
            
            try
            {
                Console.WriteLine($"{data.TryGetString("DEBUG", "PlentySockMaxQSize")}\n");
            }
            catch (TypeException e)
            {
                Console.WriteLine(e.Message + $"\n wrong type : {e.Type()} \n");
            }
            
            try
            {
                Console.WriteLine($"{data.TryGetString("ADC_DEV", "ADC_DEV")}\n");
            }
            catch (TypeException e)
            {
                Console.WriteLine(e.Message + $"\n wrong type : {e.Type()} \n");
            }
            
            try
            {
                Console.WriteLine($"{data.TryGetInt("asd", "SampleRate")}\n");
            }
            catch (SectionNameException e)
            {
                Console.WriteLine(e.Message + $"\n Wrong section : '{e.Section}' or name : '{e.Name}'\n");
            }
            
            try
            {
                Console.WriteLine($"{data.TryGetDouble("LEGACY_XML", "asd")}\n");
            }
            catch (SectionNameException e)
            {
                Console.WriteLine(e.Message + $"\n Wrong section : '{e.Section}' or name : '{e.Name}'\n");
            }
            
            try
            {
                Console.WriteLine($"{data.TryGetString("asd", "ADC_DEV")}\n");
            }
            catch (SectionNameException e)
            {
                Console.WriteLine(e.Message + $"\n Wrong section : '{e.Section}' or name : '{e.Name}'\n");
            }
        }

        public void Show_map()
        {
            foreach (KeyValuePair<string, Dictionary<string, string>> keyValue in data.Map)
            {
                foreach (KeyValuePair<string, string> keyValuePair in keyValue.Value)
                {
                    Console.WriteLine(keyValue.Key + " " + keyValuePair.Key + " " + keyValuePair.Value);
                }
            }
        }
        
    }
}