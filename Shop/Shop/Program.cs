using System;
using System.Collections.Generic;
using System.Threading;
using static Shop.Product;
using static Shop.Market;

namespace Shop
{
    internal class Program
    {
        public static void Main(string[] args)
        {
            Product lsd = new Product("lsd");
            Product weed = new Product("weed");
            Product salt = new Product("salt");
            Product morphine = new Product("morphine");
            Product methamphetamine = new Product("methamphetamine");
            Product mdma = new Product("mdma");
            Product heroin = new Product("heroin");
            Product spice = new Product("spice");
            Product сrocodile = new Product("сrocodile");
            Product hallucinogenicMushrooms = new Product("hallucinogenicMushrooms");
            Product coco = new Product("coco");

            MarketManager marketManager = new MarketManager();

            List<ProductCount> buy1 = new List<ProductCount>() 
            {
                ToProductCount(hallucinogenicMushrooms, 20),
                ToProductCount(weed, 4),
                ToProductCount(lsd, 2),
            };
        
            List<ProductCount> buy2 = new List<ProductCount>()
            {
                ToProductCount(spice, 10),
                ToProductCount(heroin, 5),
                ToProductCount(сrocodile, 3),
                ToProductCount(coco, 1)
            };
        
            List<ProductCount> buy3 = new List<ProductCount>()
            {
                ToProductCount(mdma, 10),
                ToProductCount(salt, 2),
                ToProductCount(morphine, 10),
                ToProductCount(methamphetamine, 30)
            };
            
            marketManager.GetMarket("Веселый садовник").AddProduct(weed, 2000, 30);
            marketManager.GetMarket("Веселый садовник").AddProduct(hallucinogenicMushrooms, 700, 400);
            marketManager.GetMarket("Веселый садовник").AddProduct(lsd, 500, 10);
            marketManager.GetMarket("Веселый садовник").AddProduct(mdma, 300, 30);
            marketManager.GetMarket("Веселый садовник").AddProduct(coco, 3000, 34);

            marketManager.GetMarket("myDrugs").AddProduct(mdma, 1000, 30);
            marketManager.GetMarket("myDrugs").AddProduct(heroin, 300, 30);
            marketManager.GetMarket("myDrugs").AddProduct(salt, 2000, 6);
            marketManager.GetMarket("myDrugs").AddProduct(morphine, 1000, 20);
            marketManager.GetMarket("myDrugs").AddProduct(methamphetamine, 1000, 25);
            marketManager.GetMarket("myDrugs").AddProduct(weed, 1000, 30);
            marketManager.GetMarket("myDrugs").AddProduct(hallucinogenicMushrooms, 1700, 400);
            marketManager.GetMarket("myDrugs").AddProduct(lsd, 400, 10);

            marketManager.GetMarket("Мэрри Джэйн").AddProduct(spice, 2, 60);
            marketManager.GetMarket("Мэрри Джэйн").AddProduct(heroin, 3000, 34);
            marketManager.GetMarket("Мэрри Джэйн").AddProduct(сrocodile, 560, 0);
            marketManager.GetMarket("Мэрри Джэйн").AddProduct(coco, 10000, 7);
            marketManager.GetMarket("Мэрри Джэйн").AddProduct(methamphetamine, 100, 45);
            marketManager.GetMarket("Мэрри Джэйн").AddProduct(weed, 200, 30);
            marketManager.GetMarket("Мэрри Джэйн").AddProduct(hallucinogenicMushrooms, 1100, 400);
            marketManager.GetMarket("Мэрри Джэйн").AddProduct(lsd, 600, 10);
            
            //Проверка на market.CheckByAmount
            marketManager.GetMarket("myDrugs").CheckByAmount(10000);
            marketManager.GetMarket("Мэрри Джэйн").CheckByAmount(10000);
            marketManager.GetMarket("Веселый садовник").CheckByAmount(10000);
            
            //Проверка на market.BuyProducts
            try
            {
                double cost = marketManager.GetMarket("myDrugs").BuyProducts(buy1);

                Console.WriteLine($"В магазине {marketManager.GetMarket("myDrugs").Name} был куплен список продуктов 1 по цене {cost}");
            }
            catch (NonExistProduct e)
            {
                Console.WriteLine($"В магазине {marketManager.GetMarket("myDrugs").Name} нет {e.Product().Name}");
            }
            catch (ProductCountException e)
            {
                Console.WriteLine($"В магазине {marketManager.GetMarket("myDrugs").Name} продука {e.Product().Name} кол-во = {e.Count}");
            }
            
            try
            {
                double cost = marketManager.GetMarket("Мэрри Джэйн").BuyProducts(buy2);

                Console.WriteLine($"В магазине {marketManager.GetMarket("Мэрри Джэйн").Name} был куплен список продуктов 2 по цене {cost}");
            }
            catch (NonExistProduct e)
            {
                Console.WriteLine($"В магазине {marketManager.GetMarket("Мэрри Джэйн").Name} нет {e.Product().Name}");
            }
            catch (ProductCountException e)
            {
                Console.WriteLine($"В магазине {marketManager.GetMarket("Мэрри Джэйн").Name} продука {e.Product().Name} кол-во = {e.Count}");
            }
            
            try
            {
                double cost = marketManager.GetMarket("Веселый садовник").BuyProducts(buy3);

                Console.WriteLine($"В магазине {marketManager.GetMarket("Веселый садовник").Name} был куплен список продуктов 3 по цене {cost}");
            }
            catch (NonExistProduct e)
            {
                Console.WriteLine($"В магазине {marketManager.GetMarket("Веселый садовник").Name} нет {e.Product().Name}");
            }
            catch (ProductCountException e)
            {
                Console.WriteLine($"В магазине {marketManager.GetMarket("Веселый садовник").Name} продука {e.Product().Name} кол-во = {e.Count}");
            }

            Console.WriteLine();
            
            //Проверка на marketManager.FindCheaperMarketByList
            try
            {
                Market temp = marketManager.FindCheaperMarketByList(buy1);

                Console.WriteLine($"Дешевле всего купить список продуктов 1 в магазине {temp.Name}");
            }
            catch (NonExistProduct e)
            {
                Console.WriteLine($"В магазине {e.Market} нет {e.Product().Name}");
            }
            catch (ProductCountException e)
            {
                Console.WriteLine($"В магазине {e.Market} продука {e.Product().Name} кол-во = {e.Count}");
            }
            
            try
            {
                Market temp = marketManager.FindCheaperMarketByList(buy2);

                Console.WriteLine($"Дешевле всего купить список продуктов 2 в магазине {temp.Name}");
            }
            catch (NonExistProduct e)
            {
                Console.WriteLine($"В магазине {e.Market} нет {e.Product().Name}");
            }
            catch (ProductCountException e)
            {
                Console.WriteLine($"В магазине {e.Market} продука {e.Product().Name} кол-во = {e.Count}");
            }
            
            try
            {
                Market temp = marketManager.FindCheaperMarketByList(buy3);

                Console.WriteLine($"Дешевле всего купить список продуктов 3 в магазине {temp.Name}");
            }
            catch (NonExistProduct e)
            {
                Console.WriteLine($"В магазине {e.Market} нет {e.Product().Name}");
            }
            catch (ProductCountException e)
            {
                Console.WriteLine($"В магазине {e.Market} продука {e.Product().Name} кол-во = {e.Count}");
            }

            Console.WriteLine();
            //Проверка на marketManager.FindCheaperMarketByProduct
            try
            {
                Market temp = marketManager.FindCheaperMarketByProduct(lsd);
                
                Console.WriteLine($"Дешевле всего купить продукт {lsd.Name} в магазине {temp.Name} по цене {temp.Map[lsd.Uuid].Cost}");
            }
            catch (NonExistProduct e)
            {
                Console.WriteLine($"В магазине {e.Market} нет {e.Product().Name}");
            }
            catch (ProductCountException e)
            {
                Console.WriteLine($"В магазине {e.Market} продука {e.Product().Name} кол-во = {e.Count}");
            }
            
            try
            {
                Market temp = marketManager.FindCheaperMarketByProduct(hallucinogenicMushrooms);
                
                Console.WriteLine($"Дешевле всего купить продукт {hallucinogenicMushrooms.Name} в магазине {temp.Name} по цене {temp.Map[hallucinogenicMushrooms.Uuid].Cost}");
            }
            catch (NonExistProduct e)
            {
                Console.WriteLine($"В магазине {e.Market} нет {e.Product().Name}");
            }
            catch (ProductCountException e)
            {
                Console.WriteLine($"В магазине {e.Market} продука {e.Product().Name} кол-во = {e.Count}");
            }
            
            try
            {
                Market temp = marketManager.FindCheaperMarketByProduct(weed);
                
                Console.WriteLine($"Дешевле всего купить продукт {weed.Name} в магазине {temp.Name} по цене {temp.Map[weed.Uuid].Cost}");
            }
            catch (NonExistProduct e)
            {
                Console.WriteLine($"В магазине {e.Market} нет {e.Product().Name}");
            }
            catch (ProductCountException e)
            {
                Console.WriteLine($"В магазине {e.Market} продука {e.Product().Name} кол-во = {e.Count}");
            }
        }

        public static ProductCount ToProductCount(Product product, int count)
        {
            return new ProductCount(product, count);
        }
    }
}