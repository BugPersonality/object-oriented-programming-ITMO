using System.Threading;

namespace Shop
{
    public class ProductCount
    {
        private Product _product;
        private int count;
        public ProductCount(Product product, int count) : base()
        {
            this._product = product;
            this.count = count;
        }
        public int Count
        {
            get => count;
            set => count = value;
        }
        public Product Product
        {
            get => _product;
            set => _product = value;
        }
    }
}