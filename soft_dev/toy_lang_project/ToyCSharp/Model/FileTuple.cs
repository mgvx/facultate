using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Model
{
    using System.IO;
    class FileTuple
    {
	    public string filename; 
	    public StreamReader filedesc;
	  
	    public FileTuple(string x, StreamReader y)
        { 
	        filename = x; 
	        filedesc = y; 
	    }
        public bool equals(Object ob)
        {
	        if (ob == null) return false;
	        if (ob.GetType() != this.GetType()) return false;
	        FileTuple x = (FileTuple)ob;
	        return this.filename == x.filename;
        }
        public override string ToString()
        {
	        return " {" + filename + ", " + filedesc + "}";	  
        }
    } 
}
