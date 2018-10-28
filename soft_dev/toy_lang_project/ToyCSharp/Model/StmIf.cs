using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Model
{
    class StmIf : IStatement
    {
        IExpression exp;
        IStatement s1, s2;

        public StmIf(IExpression x, IStatement y1, IStatement y2)
        {
            exp = x;
            s1 = y1;
            s2 = y2;
        }
        public override string ToString()
        {
            return "IF(" + exp.ToString() + ") THEN(" + s1.ToString() + ") ELSE(" + s2.ToString() + ")";
        }
        public PState execute(PState state)
        {
            IStack<IStatement> stack = state.getStack();
            IMap<string,int> table = state.getTable();
            int val = exp.eval(table);
		    if (val != 0) {
			    stack.push(s1);
		    }
		    else {
			    stack.push(s2);
		    }
		    return state;
	    }
    }
}
