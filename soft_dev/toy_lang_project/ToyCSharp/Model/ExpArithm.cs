using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Model
{
    class ExpArithm : IExpression
    {
        IExpression e1, e2;
        char op;

        public ExpArithm(char x, IExpression y1, IExpression y2)
        {
            op = x;
            e1 = y1;
            e2 = y2;
        }
        public override string ToString()
        {
            return e1.ToString() + op + e2.ToString();
        }
        public int eval(IMap <string,int> table)
        {
            int res = 0;
		    if (op=='+') {
			    res = e1.eval(table) + e2.eval(table);
		    }
		    else if (op=='-') {
			    res = e1.eval(table) - e2.eval(table);
		    }
		    else if (op=='*') {
			    res = e1.eval(table) * e2.eval(table);
		    }
		    else if (op=='/') {
			    int e3 = e2.eval(table);
			    if (e3 == 0)
				    throw new MyException("ERR Division By Zero");
    res = e1.eval(table) / e3;
		    }
		    return res;
	    }

    }
}
