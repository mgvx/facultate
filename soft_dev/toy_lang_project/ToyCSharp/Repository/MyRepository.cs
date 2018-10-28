using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Repository
{
    using Model;
    class MyRepository : IRepository
    {
        IList<PState> pstates;

        public MyRepository()
        {
            pstates = new MyList<PState>();
        }
        public void clearAll()
        {
            pstates.clearAll();
        }
        public PState getPState()
        {
		    try {
                    return pstates.getLast();
                }
            catch(MyException myEx)
            {
                throw new MyException("PSTATE_ERR: no pstate returned \\ " + myEx.Message);
            }
        }
        public void addPState(PState x)
        {
            pstates.add(x);
        }
    }
}
