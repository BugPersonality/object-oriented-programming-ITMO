using System;
using System.Collections.Generic;
using System.Linq;

namespace Shop
{
    public class MarketManager
    {
        private List<Market> marketsMap;

        public Market GetMarket(string Name)
        {
            foreach (var tempMarket in marketsMap)
            {
                if (tempMarket.Name == Name)
                {
                    return tempMarket;
                }
            }
            
            throw new Exception("NonExistMarket");
        }
        public MarketManager()
        {
            Market myDrugs = new Market("myDrugs");
            Market marryGane = new Market("Мэрри Джэйн"); 
            Market funnyGardener = new Market("Веселый садовник");
            
            List<Market> markets = new List<Market>()
            {
                myDrugs,
                marryGane,
                funnyGardener
            };
            
            this.marketsMap = markets;
        }
        public Market FindCheaperMarketByProduct(Product product)
        {
            double tempCost = Double.PositiveInfinity;
            Market tempMarket = marketsMap.First();
            
            foreach (var market in marketsMap)
            {
                if (market.Map.ContainsKey(product.Uuid))
                {
                    if (market.Map[product.Uuid].Count > 0)
                    {
                        if (market.Map[product.Uuid].Cost <= tempCost)
                        {
                            tempCost = market.Map[product.Uuid].Cost;
                            tempMarket = market;
                        }  
                    }
                    else
                    {
                        /*throw new ProductCountException("ProductCountException", product, market.Map[product.Uuid].Count, market);
                        tempCost = Double.PositiveInfinity;*/
                        continue;
                    }
                }
                else
                {
                    /*throw new NonExistProduct("NonExistProduct", product, market);
                    tempCost = Double.PositiveInfinity;*/
                    continue;
                }
            }

            if (tempCost == Double.PositiveInfinity)
            {
                throw new NonExistProduct("NonExistProduct");
            }

            return tempMarket;
        }

        public Market FindCheaperMarketByList(List<ProductCount> productsList)
        {
            double generalCost = Double.PositiveInfinity;
            Market tempMarket = marketsMap.First();
            
            foreach (var market in marketsMap)
            {
                double tempGeneralCost = 0;
                
                foreach (var item in productsList)
                {
                    if (market.Map.ContainsKey(item.Product.Uuid))
                    {
                        if (market.Map[item.Product.Uuid].Count >= item.Count)
                        {
                            tempGeneralCost += market.Map[item.Product.Uuid].Cost * item.Count;
                        }
                        else
                        {
                            //throw new ProductCountException("ProductCountException", item.Product, market.Map[item.Product.Uuid].Count);
                            continue;
                        }
                    }
                    else
                    {
                        //throw new NonExistProduct("NonExistProduct", item.Product);
                        continue;
                    }
                }

                if (tempGeneralCost == Double.PositiveInfinity)
                {
                    throw new NonExistProduct("NonExistProduct");
                }
                
                if (tempGeneralCost < generalCost && tempGeneralCost != 0)
                {
                    generalCost = tempGeneralCost;
                    tempMarket = market;
                }
            }

            return tempMarket;
        }
        
    }
}