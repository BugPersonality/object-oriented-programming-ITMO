using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Reflection;
using System.Runtime.Serialization;

namespace OOPLab_1
{
    
    public class INIdata 
    {
        private readonly Dictionary<string, Dictionary<string, string>> map;

        public Dictionary<string, Dictionary<string, string>> Map => map;

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
            if (!map.ContainsKey(section) || !map[section].ContainsKey(name))
            {
                throw new SectionNameException("name or section doesn't exist", section, name);
            }
            if (!Int32.TryParse(map[section][name].Replace(".", ","), out int n))
            {
                throw new TypeException("Type error", typeof(double));
            }
            
            return n;
        }

        public double TryGetDouble(string section, string name)
        {
            
            if (!map.ContainsKey(section) || !map[section].ContainsKey(name))
            {
                throw new SectionNameException("name or section doesn't exist", section, name);
            }
            if (!Double.TryParse(map[section][name].Replace(".", ","), out double n))
            {
                throw new TypeException("Type error", typeof(string));
            }
            if (Int32.TryParse(map[section][name].Replace(".", ","), out int k))
            {
                throw new TypeException("Type error", typeof(int));
            }

            return n;
        }

        public string TryGetString(string section, string name)
        {
            if (!map.ContainsKey(section) || !map[section].ContainsKey(name))
            {
                throw new SectionNameException("name or section doesn't exist", section, name);
            }
            if (Double.TryParse(map[section][name].Replace(".", ","), out double n))
            {
                throw new TypeException("Type error", typeof(double));
            }
                
            return map[section][name];
        }
    }
    
    public class SectionNameException : Exception
    {
        private string _section = null;
        private string _name = null;
        
        public string Section => _section;

        public string Name => _name;
        
        public SectionNameException(string message) : base(message) { }
        public SectionNameException(string message, string section) : base(message) { this._section = section; }
        public SectionNameException(string message, string section, string name) : base(message) { this._name = name; this._section = section; }
    }

    public class TypeException : Exception
    {
        private readonly Type _type;
        public Type Type() => _type;
        
        public TypeException(string message) : base(message) { }
        public TypeException(string message, Type type) : base(message) { this._type = type; }
    }
}