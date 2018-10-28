using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Model
{
    class ExpConst : IExpression
    {
        int num;
        public ExpConst(int x)
        {
            num = x;
        }
        public override string ToString()
        {
            return num.ToString() + "";
        }
        public int eval(IMap<string,int> table)
        {
            return num;
        }
    }
}
