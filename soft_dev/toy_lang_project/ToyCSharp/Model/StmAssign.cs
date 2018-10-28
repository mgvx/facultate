using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Model
{
    class StmAssign : IStatement
    {
        string id;
        IExpression exp;
        
        public StmAssign(string x, IExpression y)
        {
            id = x;
            exp = y;
        }
        public override string ToString()
        {
            return id + "=" + exp.ToString();
        }
        public PState execute(PState state)
        {

            IStack<IStatement> stack = state.getStack();
            IMap<string,int> table = state.getTable();
            int val = exp.eval(table);
		    if (table.hasKey(id)) {
			    table.update(id, val);
		    }
		    else {
			    table.add(id, val);
		    }
		    return state;
	    }
    }
}
