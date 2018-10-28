using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Controller
{
    using Repository;
    using Model;
    interface IController
    {
        PState runStep(PState state);
        void runTests();
        void allStep();
    }
}
