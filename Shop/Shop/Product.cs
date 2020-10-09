using System;
using static System.Guid;

namespace Shop
{
    public class Product
    {
        private readonly string _name;
        private readonly string _uuid;

        public Product(string name)
        {
            this._name = name;
            this._uuid = Guid.NewGuid().ToString();
        }
        public string Name => _name;
        public string Uuid => _uuid;
    }
}