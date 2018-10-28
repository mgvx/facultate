using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Model
{
    class PState
    {
        IStack<IStatement> exe_stack;
        IMap<string,int> sym_table;
        IList<int> out_stream;
        IMap<int,FileTuple> files_table;
        int counter;
        public PState(IStack<IStatement> s, IMap<string,int> d, IList<int> o, IMap<int, FileTuple> f)
        {
            this.exe_stack = s;
            this.sym_table = d;
            this.out_stream = o;
            this.files_table = f;
            counter = 0;
        }

        public override string ToString()
        {
            return exe_stack.ToString() + '\n' + sym_table.ToString() + '\n' + out_stream.ToString() + '\n' + files_table.ToString() + '\n';
        }

        public IStack<IStatement> getStack()
        {
            return exe_stack;
        }
        public IMap<string, int> getTable()
        {
            return sym_table;
        }
        public IMap<int, FileTuple> getFiles()
        {
            return files_table;
        }
        public IList<int> getOut()
        {
            return out_stream;
        }
        public int getFilesCounter()
        {
            return counter;
        }

        public void setStack(IStack<IStatement> x)
        {
            exe_stack = x;
        }
        public void setTable(IMap<string, int> x)
        {
            sym_table = x;
        }
        public void setFiles(IMap<int, FileTuple> x)
        {
            files_table = x;
        }
        public void setOut(IList<int> x)
        {
            out_stream = x;
        }

    }
}
