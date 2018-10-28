using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Model
{
    class StmCloseRFile : IStatement
    {
        IExpression fid;
        public StmCloseRFile(IExpression x)
        {
            fid = x;
        }
        public override string ToString()
        {
            return "CLOSE(" + fid.ToString() + ")";
        }
        public PState execute(PState state)
        {
            IMap <int,FileTuple> files = state.getFiles();
            IMap <string, int> table = state.getTable();
            int res = fid.eval(table);
		
		    if(!files.hasKey(res)){
                throw new MyException("FILE_ERR: file not opened");
            }

            FileTuple f = files.lookup(res);
            f.filedesc.Close();

            files.remove(res);
		    return null;
        }
    }
}
