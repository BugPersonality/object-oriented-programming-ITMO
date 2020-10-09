using System;
using System.Collections.Generic;

namespace Shop
{
    public class Market
    {
        private Dictionary<string, CCN> _map = new Dictionary<string, CCN>();

        private string _uuid;
        private string _name;

        public Market(string name)
        {
            this._uuid = Guid.NewGuid().ToString();
            this._name = name;
        }
        public Dictionary<string, CCN> Map => _map;
        
        public string Name => _name;
        
        public string Uuid => _uuid;

        public double GetCost(Product product)
        {
            if (this._map.ContainsKey(product.Uuid))
            {
                return this._map[product.Uuid].Cost;
            }
            else
            {
                throw new NonExistProduct("NonExistProduct", product);
            }
        }

        public void ChangeCost(Product product, double newCost)
        {
            if (this._map.ContainsKey(product.Uuid))
            {
                this._map[product.Uuid].Cost = newCost;
            }
            else
            {
                throw new NonExistProduct("NonExistProduct", product);
            }
        }

        public void AddProduct(Product product, double cost, int count)
        {
            string tempName = product.Name;
            string tempUuid = product.Uuid;
            
            if (!_map.ContainsKey(tempUuid))
            {
                _map.Add(tempUuid, new CCN(cost, count, tempName));
            }
            else
            {
                _map[tempUuid].Cost = cost;
                _map[tempUuid].Count += count;
            }
        }

        public void CheckByAmount(double budget)
        {
            foreach (var product in this._map)
            {
                var tempPrise = budget;

                if (product.Value.Count > 0 && budget > product.Value.Cost)
                {
                    var tempCount = 0;
                    
                    while (tempCount < product.Value.Count && tempPrise > product.Value.Cost)
                    {
                        tempPrise -= product.Value.Cost;
                        tempCount++;
                    }

                    Console.WriteLine($"Можно купить {tempCount} {product.Value.Name} в магазине - {this._name}");
                }
                else
                {
                    continue;
                }
            }

            Console.WriteLine();
        }

        public double BuyProducts(List<ProductCount> productsList)
        {
            double prise = 0;

            foreach (var item in productsList)
            {
                if (this._map.ContainsKey(item.Product.Uuid))
                {
                    if(this._map[item.Product.Uuid].Count != 0 && this._map[item.Product.Uuid].Count >= item.Count)
                    {
                        var tempCost = this._map[item.Product.Uuid].Cost * item.Count;

                        prise += tempCost;
                    }
                    else
                    {
                        throw new ProductCountException("ProductCountException", item.Product, this._map[item.Product.Uuid].Count);
                    }
                }
                else
                {
                    throw new NonExistProduct("NonExistProduct", item.Product);
                }
                
                this._map[item.Product.Uuid].Count -= item.Count;
            }

            return prise;
        }
    }

    public class NonExistProduct : Exception
    {
        private Product _product;
        
        private Market _market;
        public Market Market => _market;
        public Product Product() => this._product;
        
        public NonExistProduct(string message) : base(message) { }
        public NonExistProduct(string message, Product product) : base(message) { this._product = product; }
        public NonExistProduct(string message, Product product, Market market) : base(message) { this._product = product;
            this._market = market; }
    }

    public class ProductCountException : Exception
    {
        private readonly int _count;
        
        private Product _product;

        private Market _market;
        public Market Market => _market;
        public int Count => _count;
        public Product Product() => this._product;
        
        public ProductCountException(string message) : base(message) { }
        
        public ProductCountException(string message, int count) : base(message) { _count = count; }
        
        public ProductCountException(string message, Product product) : base(message) { _product = product; }
        public ProductCountException(string message, Product product, int count) : base(message) { _product = product; _count = count; }
        
        public ProductCountException(string message, Product product, int count, Market market) : base(message) { _product = product; _count = count;
            this._market = market; }
    }
}