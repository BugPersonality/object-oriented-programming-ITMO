namespace Shop
{
    public class CCN // Cost Count Name
    {
        public CCN(double cost, int count, string name)
        {
            this.Cost = cost;
            this.Count = count;
            this.Name = name;
        }
        public double Cost { get; set; }
        public int Count { get; set; }
        public string Name { get; set; }
    }
}