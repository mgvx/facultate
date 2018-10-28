#pragma once
#include <map>
#include <iterator>
#include <utility>
#include <algorithm>
using namespace std;

typedef pair <int, int> Edge;

struct EdgeStruct
{
    int e1,e2,c;
};

bool rule_min(EdgeStruct x, EdgeStruct y) { return x.c<y.c; }
bool rule_max(EdgeStruct x, EdgeStruct y) { return x.c>y.c; }

class Cost
{
public:
    map < Edge,int > m;
    vector < EdgeStruct > v;
    void upd(int x, int y, int k);
    void del(int x, int y);
    int get(int x, int y);
    int exist(int x, int y);
    void sort_min();
    void sort_max();
    int get_sort_c(int i) { return v[i].c; }
    int get_sort_e1(int i) { return v[i].e1; }
    int get_sort_e2(int i) { return v[i].e2; }
};

void Cost::sort_min()
{
    sort(v.begin(),v.end(),rule_min);
}

void Cost::sort_max()
{
    sort(v.begin(),v.end(),rule_max);
}

void Cost::upd(int x, int y, int k)
{
    Edge e(x,y);
    m[e]=k;
    EdgeStruct w;
    w.e1=x;
    w.e2=y;
    w.c=k;
    v.push_back(w);
}

void Cost::del(int x, int y)
{
    Edge e(x,y);
    map <Edge,int>::iterator it=m.find(e);
    m.erase(it);
}

int Cost::get(int x, int y)
{
    pair <int,int> e(x,y);
    return m[e];
}

int Cost::exist(int x, int y)
{
    pair <int,int> e(x,y);
    map <Edge,int>::iterator it=m.find(e);
    if(it==m.end())
        return 0;
    return 1;
}
