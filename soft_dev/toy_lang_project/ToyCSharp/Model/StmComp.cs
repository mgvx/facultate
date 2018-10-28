using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Model
{
    class StmComp : IStatement
    {
        IStatement first, second;

        public StmComp(IStatement x, IStatement y)
        {
            first = x;
            second = y;
        }
        public override string ToString()
        {
            return "(" + first.ToString() + "; " + second.ToString() + ")";
        }
        public PState execute(PState state)
        {
            IStack<IStatement> stack = state.getStack();
            stack.push(second);
            stack.push(first);
            return state;
        }
    }
}
