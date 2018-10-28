using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ToyCSharp.Model
{
    interface IMap <K,V>
    {
        string ToString();
        V lookup(K id);
        bool hasKey(K id);
        void update(K id, V val);
        bool hasValue(V val);
        void add(K id, V val);
        void remove(K id);
    }

    public class MyMap<K, V> : IMap <K,V> {
        Dictionary <K,V> mp;
        public MyMap()
        {
            mp = new Dictionary<K,V>();
        }
        public V lookup(K id)
        {
		    if (!hasKey(id))
			    throw new MyException("MAP_ERR: key not defined");
		    return mp[id];
	    }
        public bool hasKey(K id)
        {
            return mp.ContainsKey(id);
        }
        public void update(K id, V val)
        {
            mp[id] = val;
        }
        public bool hasValue(V val)
        {
            foreach (KeyValuePair<K, V> x in mp)
            {
                if (x.Equals(val))
                {
                    return true;
                }
            }
            return false;

        }
        public void add(K id, V val)
        {
		    if (mp.ContainsKey(id))
			    throw new MyException("MAP_ERR: key already defined");
            mp.Add(id, val);
	    }
        public void remove(K id)
        {
		    if (!hasKey(id))
			    throw new MyException("MAP_ERR: key not defined");
            mp.Remove(id);
	    }
        public override string ToString()
        {
            string str = "";
            if (mp != null)
            {
                foreach (KeyValuePair<K, V> x in mp)
                {
                    str = x.Key.ToString() + "->" + x.Value.ToString() + ", " + str;
                }
            }
            if (str.Length > 2)
            {
                str = str.Substring(0, str.Length - 2);
            }
            return "SYM TABLE:    " + str;
        }
    }

}
