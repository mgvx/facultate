using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Model
{
    class StmPrint : IStatement
    {
        IExpression exp;

        public StmPrint(IExpression e)
        {
            exp = e;
        }
        public override string ToString()
        {
            return "PRINT(" + exp.ToString() + ")";
        }
        public PState execute(PState state)
        {
            IMap<string,int> table = state.getTable();
            IList<int> list = state.getOut();
            list.add(exp.eval(table));
		    return state;
	    }
    }
}
