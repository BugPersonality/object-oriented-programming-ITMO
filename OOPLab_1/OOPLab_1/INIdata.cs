using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;

namespace OOPLab_1
{
    public class INIdata 
    {
        public readonly Dictionary<string, Dictionary<string, string>> map;

        public INIdata(Dictionary<string, Dictionary<string, string>> map)
        {
            this.map = map;
        }

        public string GetValue(string section, string name)
        {
            try
            {
                return map[section][name];
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
                if (!map.ContainsKey(section) || !map[section].ContainsKey(name))
                {
                    throw new Exception("name or section does not exist");
                }
                if (!Int32.TryParse(map[section][name], out int n))
                {
                    throw new Exception("Type error");
                }
                
                return n;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }

            return Int32.MaxValue;
        }

        public double TryGetDouble(string section, string name)
        {
            try
            {
                if (!map.ContainsKey(section) || !map[section].ContainsKey(name))
                {
                    throw new Exception("name or section does not exist");
                }
                if (!Double.TryParse(map[section][name], out double n))
                {
                    throw new Exception("Type error Db");
                }
                if (Int32.TryParse(map[section][name], out int k))
                {
                    throw new Exception("Type error int");
                }

                return n;
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }

            return Double.MaxValue;
        }

        public string TryGetString(string section, string name)
        {
            try
            {
                if (!map.ContainsKey(section) || !map[section].ContainsKey(name))
                {
                    throw new Exception("name or section does not exist");
                }
                if (Double.TryParse(map[section][name], out double n))
                {
                    throw new Exception("Type error");
                }
                
                return map[section][name];
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }

            return ">_<";
        }
    }
}