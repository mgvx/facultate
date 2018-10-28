using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Model
{
    interface IExpression
    {
        int eval(IMap<string,int> table);
        string ToString();

    }
}
