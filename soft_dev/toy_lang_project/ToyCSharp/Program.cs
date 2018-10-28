using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace ToyCSharp
{
    using Controller;
    using Repository;
    using Model;
    class Program
    {
        static void Main(string[] args)
        {
            System.Console.WriteLine("Hello");

            IRepository repo = new MyRepository();
            IController con = new MyController(repo);

            try
            {
                con.runTests();
            }
            catch (MyException myEx)
            {
                System.Console.WriteLine(myEx.Message);
            }
            System.Console.WriteLine("Bye");


            Console.ReadLine();
        }
    }
}
