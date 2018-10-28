using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Model
{
    using System;
    using System.IO;
    class StmOpenRFile : IStatement
    {
        string var;
        string filename;
        public StmOpenRFile(string x, string y)
        {
            var = x;
            filename = y;
        }
        public override string ToString()
        {
            return "OPEN(" + var + ", " + filename + ")";
        }
        public PState execute(PState state)
        {
            IMap <int,FileTuple> files = state.getFiles();
            IMap <string,int> table = state.getTable();
            int counter = state.getFilesCounter();
            StreamReader filedesc = null;
            
            try {
                filedesc = new StreamReader("E:\\fac\\ToyCSharp\\ToyCSharp\\bin\\Debug\\"+filename);
            }
		    catch (FileNotFoundException e) {
                System.Console.WriteLine(e.Message);

                throw new MyException("FILE_ERR: can't open file");	
		    }

            FileTuple f = new FileTuple(filename, filedesc);
            if (files.hasValue(f)){
			    throw new MyException("FILE_ERR: file already opened");
		    }
		
		    files.add(counter,f);
		    if (table.hasKey(var)) {
			    table.update(var, counter);
		    }
		    else {
			    table.add(var, counter);
		    }		
		    return null;
	    }
    }
}
