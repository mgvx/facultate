using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Model
{
    using System;
    using System.IO;
    class StmReadRFile : IStatement
    {
        IExpression fid;
        string var;

        public StmReadRFile(IExpression x, string y)
        {
            fid = x;
            var = y;
        }
        public override string ToString()
        {
            return "READ(" + fid.ToString() + ", " + var + ")";
        }
        public PState execute(PState state)
        {
            IMap <int,FileTuple> files = state.getFiles();
            IMap <string,int> table = state.getTable();
            int res = fid.eval(table);
            int value;
            
            if (!files.hasKey(res)){
                throw new MyException("FILE_ERR: file doesn't exist");
            }

            FileTuple f = files.lookup(res);
            StreamReader buffer = f.filedesc;

            string line = buffer.ReadLine();
            if (line==null)
                value = 0;
            else
                value = Int32.Parse(line);

            if (table.hasKey(var)) {
                table.update(var, value);
            }
		    else {
                table.add(var, value);
            }		
		    return null;
        }
    }
}
