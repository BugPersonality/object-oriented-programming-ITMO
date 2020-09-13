using System.IO;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;


namespace OOPLab_1
{
    public class INIParser
    {
        
        private readonly FileStream file;
        
        internal INIParser(string path)
        {
            try
            {
                if (!path.Contains(".ini"))
                {
                    throw new Exception("\n ======== \n File format error \n ========");
                }
                
                this.file = new FileStream(path, FileMode.Open, FileAccess.ReadWrite);

            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
                throw;
            }
        }

        internal List<string> ParseFile()
        {
            var reader = new StreamReader(this.file);

            string data = "", tmp;

            int index;

            while (!reader.EndOfStream)
            {
                tmp = reader.ReadLine();

                index = tmp.IndexOf(";", StringComparison.Ordinal);

                if (index != -1)
                {
                    tmp = tmp.Remove(index, tmp.Length - index);
                }

                if (!string.IsNullOrEmpty(tmp))
                {
                    data += tmp + "\n";
                }
            }

            return data.Split('\n').ToList();
        }

    }
}