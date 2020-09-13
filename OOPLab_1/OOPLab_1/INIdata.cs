using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;

namespace OOPLab_1
{
    public class INIdata 
    {
        Dictionary<string, Dictionary<string, string>> map = new Dictionary<string, Dictionary<string, string>>();
        public List<string> text = new List<string>();

        public INIdata(string path)
        {
            INIParser ini = new INIParser(path);

            this.text = ini.ParseFile();
            
            DataWorker();
        }

        private void DataWorker()
        {
            string temp = "";
            
            foreach (var i in this.text)
            {
                if (i.Contains("["))
                {
                    temp = i;
                    temp = i.Replace("[", "").Replace("]", "").Replace(" ", "");
                    
                    map.Add($"{temp}", new Dictionary<string, string>());
                }
                else if (!string.IsNullOrEmpty(i))
                {
                    string name, value;
                    string[] tmp = i.Split('=');
                    name = tmp[0]
                        .Replace(" ", "")
                        .Replace("\t", "")
                        .Replace("\n", "");
                    value = tmp[1]
                        .Replace(" ", "")
                        .Replace("\t", "")
                        .Replace("\n", "")
                        .Replace(".", ",");
                    
                    map[$"{temp}"].Add($"{name}", $"{value}");
                }
                else
                {
                    continue;
                }
            }
        }

        public string GetValue(string section, string name)
        {
            try
            {
                return map[$"{section}"][$"{name}"];
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                throw;
            }
        }

        public int TryGetInt(string section, string name)
        {
            try
            {
                if (!map.ContainsKey($"{section}") || !map[$"{section}"].ContainsKey($"{name}"))
                {
                    throw new Exception("name or section does not exist");
                }
                if (!Int32.TryParse(map[$"{section}"][$"{name}"], out int n))
                {
                    throw new Exception("Type error");
                }

                return n;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }

            return 0;
        }

        public double TryGetDouble(string section, string name)
        {
            try
            {
                if (!map.ContainsKey($"{section}") || !map[$"{section}"].ContainsKey($"{name}"))
                {
                    throw new Exception("name or section does not exist");
                }
                if (!Double.TryParse(map[$"{section}"][$"{name}"], out double n))
                {
                    throw new Exception("Type error Db");
                }
                if (Int32.TryParse(map[$"{section}"][$"{name}"], out int k))
                {
                    throw new Exception("Type error int");
                }

                return n;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }

            return 0;
        }

        public string TryGetString(string section, string name)
        {
            try
            {
                if (!map.ContainsKey($"{section}") || !map[$"{section}"].ContainsKey($"{name}"))
                {
                    throw new Exception("name or section does not exist");
                }
                if (Double.TryParse(map[$"{section}"][$"{name}"], out double n))
                {
                    throw new Exception("Type error");
                }
                
                return map[$"{section}"][$"{name}"];
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }

            return "";
        }
    }
}