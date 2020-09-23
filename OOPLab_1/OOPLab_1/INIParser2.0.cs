using System.IO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using static  OOPLab_1.INIdata;

namespace OOPLab_1
{
    public class INIParser2_0
    {
        private FileStream _file;

        private bool check_section(string line)
        {
            const string mask1 = "\\[[a-zA-Z_0-9]*\\]";
            const string mask2 = "\\[[a-zA-Z_0-9]*\\] *;.*";

            return Regex.IsMatch(line, mask1) || Regex.IsMatch(line, mask2);
        }

        private bool check_name(string line)
        {
            const string mask1 = "[a-zA-Z_0-9\\-]* *= *[a-zA-Z_0-9\\.\\-]*";
            const string mask2 = "[a-zA-Z_0-9\\-]* *= *[a-zA-Z_0-9\\.\\-]* *;.*";
            
            return Regex.IsMatch(line, mask1) || Regex.IsMatch(line, mask2);
        }

        private bool check_comm(string line)
        {
            const string mask = ".* ;.*";

            return Regex.IsMatch(line, mask);
        }

        private bool check_file_name(string path)
        {
            string mask1 = "(.+/.+)+\\.ini";
            string mask2 = ".+\\.ini";
            
            return Regex.IsMatch(path, mask1) || Regex.IsMatch(path, mask2);
        }

        private void Open_file(string path)
        {
            if (check_file_name(path))
            {
                try
                {
                    this._file = new FileStream(path, FileMode.Open, FileAccess.ReadWrite);
                }
                catch (Exception e)
                {
                    Console.WriteLine(e.Message);
                    throw;
                }
            }
            else
            {
               Console.WriteLine("can't open file");
               Environment.Exit(0);
            }
        }
        
        private Dictionary<string, Dictionary<string, string>> Worker()
        {
            var reader = new StreamReader(this._file);

            Dictionary<string, Dictionary<string, string>> map = new Dictionary<string, Dictionary<string, string>>();

            string tempSection = " ";

            while (!reader.EndOfStream)
            {
                var line = reader.ReadLine();

                if (check_comm(line))
                {
                    if (line != null)
                    {
                        var index = line.IndexOf(";", StringComparison.Ordinal);

                        line = line.Remove(index, line.Length - index);
                    }
                }
                
                if (check_section(line))
                {
                    if (line != null)
                        tempSection = line
                            .Replace("[", "")
                            .Replace("]", "")
                            .Replace(" ", "")
                            .Replace("\n", "");

                    map.Add($"{tempSection}", new Dictionary<string, string>());
                }
                else if (check_name(line))
                {
                    if (line != null)
                    {
                        string[] tmp = line.Split('=');
                    
                        var name = tmp[0]
                            .Replace(" ", "")
                            .Replace("\t", "")
                            .Replace("\n", "");
                        var value = tmp[1]
                            .Replace(" ", "")
                            .Replace("\t", "")
                            .Replace("\n", "")
                            .Replace(".", ",");

                        if (map.ContainsKey(tempSection))
                        {
                            map[tempSection].Add(name, value);
                        }
                        else
                        {
                            Console.WriteLine($"section - [{tempSection}] doesn't exist");
                            continue;
                        }
                    }
                }
            }
            
            return map;
        }

        public INIdata Parse_file(string path)
        {
            Open_file(path);
            
            return new INIdata(Worker());
        }
    }
}