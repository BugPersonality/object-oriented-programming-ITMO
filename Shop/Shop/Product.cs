using System;
using static System.Guid;

namespace Shop
{
    public class Product
    {
        private  string _name;
        private  string _uuid;
        public Product(string name)
        {
            this._name = name;
            this._uuid = Guid.NewGuid().ToString();
        }
        public string Name => _name;
        public string Uuid => _uuid;
    }
}