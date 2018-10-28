using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Model
{
    interface IStatement
    {
        string ToString();
        PState execute(PState state);

    }
}
