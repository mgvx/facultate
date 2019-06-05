
import numpy as np
import collections
import re

path_to_file = "dataset.txt"
ds = open(path_to_file, 'rb').read().decode(encoding='utf-8')
ds = re.split('(\w+)|(\s)|(-)|(.)', ds)
d = collections.Counter(ds)
del d[None]

print(ds[:20])
print(len(ds))
print(d.most_common(10))
print(len(d))

k = list(d.keys())
k.sort(key = lambda x: len(x) if x else 0)
print(k[:100])
print(k[-20:])
