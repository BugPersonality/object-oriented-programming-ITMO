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
            
            Market myDrugs = new Market("Наши Наркотики");
            Market marryGane = new Market("Мэрри Джэйн"); 
            Market funnyGardener = new Market("Веселый садовник");
            
            MarketManager marketManager = new MarketManager();
            
            List<Market> markets = new List<Market>()
            {
                myDrugs,
                marryGane,
                funnyGardener
            };

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

            funnyGardener.AddProduct(weed, 2000, 30);
            funnyGardener.AddProduct(hallucinogenicMushrooms, 700, 400);
            funnyGardener.AddProduct(lsd, 500, 10);
            funnyGardener.AddProduct(mdma, 300, 30);
            funnyGardener.AddProduct(coco, 3000, 34);
        
            myDrugs.AddProduct(mdma, 1000, 30);
            myDrugs.AddProduct(heroin, 300, 30);
            myDrugs.AddProduct(salt, 2000, 6);
            myDrugs.AddProduct(morphine, 1000, 20);
            myDrugs.AddProduct(methamphetamine, 1000, 25);
            myDrugs.AddProduct(weed, 1000, 30);
            myDrugs.AddProduct(hallucinogenicMushrooms, 1700, 400);
            myDrugs.AddProduct(lsd, 400, 10);
        
            marryGane.AddProduct(spice, 2, 60);
            marryGane.AddProduct(heroin, 3000, 34);
            marryGane.AddProduct(сrocodile, 560, 0);
            marryGane.AddProduct(coco, 10000, 7);
            marryGane.AddProduct(methamphetamine, 100, 45);
            marryGane.AddProduct(weed, 200, 30);
            marryGane.AddProduct(hallucinogenicMushrooms, 1100, 400);
            marryGane.AddProduct(lsd, 600, 10);
            
            //Проверка на market.CheckByAmount
            myDrugs.CheckByAmount(10000);
            marryGane.CheckByAmount(10000);
            funnyGardener.CheckByAmount(10000);
            
            //Проверка на market.BuyProducts
            try
            {
                double cost = myDrugs.BuyProducts(buy1);

                Console.WriteLine($"В магазине {myDrugs.Name} был куплен список продуктов 1 по цене {cost}");
            }
            catch (NonExistProduct e)
            {
                Console.WriteLine($"В магазине {myDrugs.Name} нет {e.Product().Name}");
            }
            catch (ProductCountException e)
            {
                Console.WriteLine($"В магазине {myDrugs.Name} продука {e.Product().Name} кол-во = {e.Count}");
            }
            
            try
            {
                double cost = marryGane.BuyProducts(buy2);

                Console.WriteLine($"В магазине {marryGane.Name} был куплен список продуктов 2 по цене {cost}");
            }
            catch (NonExistProduct e)
            {
                Console.WriteLine($"В магазине {marryGane.Name} нет {e.Product().Name}");
            }
            catch (ProductCountException e)
            {
                Console.WriteLine($"В магазине {marryGane.Name} продука {e.Product().Name} кол-во = {e.Count}");
            }
            
            try
            {
                double cost = funnyGardener.BuyProducts(buy3);

                Console.WriteLine($"В магазине {funnyGardener.Name} был куплен список продуктов 3 по цене {cost}");
            }
            catch (NonExistProduct e)
            {
                Console.WriteLine($"В магазине {funnyGardener.Name} нет {e.Product().Name}");
            }
            catch (ProductCountException e)
            {
                Console.WriteLine($"В магазине {funnyGardener.Name} продука {e.Product().Name} кол-во = {e.Count}");
            }

            Console.WriteLine();
            
            //Проверка на marketManager.FindCheaperMarketByList
            try
            {
                Market temp = marketManager.FindCheaperMarketByList(buy1, markets);

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
                Market temp = marketManager.FindCheaperMarketByList(buy2, markets);

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
                Market temp = marketManager.FindCheaperMarketByList(buy3, markets);

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
                Market temp = marketManager.FindCheaperMarketByProduct(lsd, markets);
                
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
                Market temp = marketManager.FindCheaperMarketByProduct(hallucinogenicMushrooms, markets);
                
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
                Market temp = marketManager.FindCheaperMarketByProduct(weed, markets);
                
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