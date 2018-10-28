using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Model
{
    interface IList <T>
    {
        void add(T e);
        bool isEmpty();
        string ToString();
        T getLast();
        void clearAll();
    }

    public class MyList<T> : IList <T> {
        List <T> lst;
        public MyList()
        {
            lst = new List<T>();
        }
        public void add(T e)
        {
            lst.Add(e);
        }
        public bool isEmpty()
        {
            return !lst.Any();
        }
        public override string ToString()
        {
            string str = "";
            if (lst != null)
            {
                foreach (var x in lst)
                {
                    str = x.ToString() + ", " + str;
                }
            }
            if (str.Length > 2)
            {
                str = str.Substring(0, str.Length - 2);
            }
            return "OUT STREAM:   " + str;
        }
        public T getLast()
        {
		    if (!lst.Any())
			    throw new MyException("LIST_ERR: empty list");
		    return lst[lst.Count()-1];
	    }
        public void clearAll()
        {
            lst.Clear();
        }
    }

}
