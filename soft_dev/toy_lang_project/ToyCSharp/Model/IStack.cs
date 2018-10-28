using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Model
{
    interface IStack <T>
    {
        void push(T e);
        T pop();
        bool isEmpty();
        string ToString();
    }

    public class MyStack<T> : IStack <T> {
        Stack <T> stk;
        public MyStack()
        {
            stk = new Stack<T>();
        }
        public void push(T e)
        {
            stk.Push(e);
        }
        public T pop()
        {
		    if (!stk.Any())
			    throw new MyException("STACK_ERR: empty stack");
		    return stk.Pop();
	    }
        public bool isEmpty()
        {
            return !stk.Any();
        }
        public override string ToString()
        {
            string str = "";
            if (stk != null)
            {
                foreach (var x in stk)
                {
                    str = x.ToString() + " | " + str;
                }
            }
            if (str.Length > 2)
            {
                str = str.Substring(0, str.Length - 2);
            }
            return "EXE STACK:    " + str;
        }
    }

}
