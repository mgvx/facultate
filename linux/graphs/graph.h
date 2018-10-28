#pragma once
#include <vector>
#include <deque>
#include <algorithm>
using namespace std;

class Graph
{
public:
    vector < vector <int> > v_in;
    vector < vector <int> > v_out;
    deque <int> dead;
    void add_edge(int x, int y);
    void rem_edge(int x, int y);
    void add_vertex(int &x);
    void rem_vertex(int x);
    int are_friends(int x,int y);
    int num_edges();
    int num_vertices();
    int valid(int x);
    vector<int>::iterator get_in_it(int x){ return v_in[x].begin(); }
    vector<int>::iterator get_out_it(int x){ return v_out[x].begin(); }
    int get_out_deg(int x){ return v_out[x].size(); }
    int get_in_deg(int x){ return v_in[x].size(); }
};

void Graph::add_edge(int x, int y)
{
    //verify add edge
    v_out[x].push_back(y);
    v_in[y].push_back(x);
}

void Graph::rem_edge(int x, int y)
{
    for (int i=0;i<v_out[x].size();++i)
        if(v_out[x][i]==y)
            v_out[x].erase(v_out[x].begin()+i);
    for (int i=0;i<v_in[y].size();++i)
        if(v_in[y][i]==x)
            v_in[y].erase(v_out[y].begin()+i);
}

void Graph::add_vertex(int &x)
{
    if(dead.empty())
    {
        v_in.resize(v_in.size()+1);
        v_out.resize(v_out.size()+1);
        x=v_out.size()-1;
    }
    else
    {
        x=dead.front();
        dead.pop_front();
    }
}

void Graph::rem_vertex(int x)
{
    dead.push_back(x);
    for (int i=0;i<v_out[x].size();++i)
    {
        int v=v_out[x][i];
        for(int j=0;j<v_in[v].size();j++)
            if(v_in[v][j]==x)
            {
                for(int k=j;k<v_in[v].size()-1;k++)
                    v_in[v][k]=v_in[v][k+1];
                v_in[v].pop_back();
            }
    }
    for (int i=0;i<v_in[x].size();++i)
    {
        int v=v_in[x][i];
        for(int j=0;j<v_out[v].size();++j)
            if(v_out[v][j]==x)
            {
                for(int k=j;k<v_out[v].size()-1;k++)
                    v_out[v][k]=v_out[v][k+1];
                v_out[v].pop_back();
            }
    }
    while(!v_out[x].empty())
        v_out[x].pop_back();
    while(!v_in[x].empty())
        v_in[x].pop_back();
}

int Graph::are_friends(int x,int y)
{
    for (int i=0;i<v_out[x].size();++i)
        if(y==v_out[x][i])
            return 1;
    return 0;
}

int Graph::num_edges()
{
    int j=0;
    for (int i=0;i<v_out.size();++i)
        j+=v_out[i].size();
    return j;
}

int Graph::num_vertices()
{
    return v_out.size()-dead.size();
}

int Graph::valid(int x)
{
    if(x<0||x>=v_out.size())
        return 0;
    for(int i=0; i<dead.size();++i)
        if(x==dead[i])
            return 0;
    return 1;
}
