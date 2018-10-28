using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Model
{
    class ExpVar : IExpression
    {
        string id;
        public ExpVar(string x)
        {
            id = x;
        }
        public override string ToString()
        {
            return id;
        }
        public int eval(IMap<string,int> table)
        {
		    return table.lookup(id);
        }
    }
}
