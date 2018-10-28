using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Repository
{
    using Model;
    interface IRepository
    {
        PState getPState();
        void addPState(PState x);
        void clearAll();
    }
}
