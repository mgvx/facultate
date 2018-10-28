#include <cstdio>
#include <deque>
#include <vector>
#include <algorithm>
#include <windows.h>
#include <string>
using namespace std;
typedef vector<int>::iterator it_graf;
#define INF 100000

void print_path(vector <int> &father, int x, int y)
{
    vector <int> path;
    path.push_back(y);
    while(y != x)
    {
        path.push_back(father[y]);
        y=father[y];
        if(y==-1)
        {
            printf("No path!\n");
            return;
        }
    }
    reverse(path.begin(),path.end());
    printf("Path: ");
    for (int i=0;i<path.size();i++)
        printf("%d ",path[i]);
    printf("\n");
}

void bfs(Graph *graph,int x, int y)
{
    vector <int> father(graph->num_vertices(),-1);
    deque <int> q;
    q.push_back(x);
    while(!q.empty())
    {
        it_graf it=graph->get_out_it(q.front());
        for(int i=0;i<graph->get_out_deg(q.front());++it,++i)
            if(father[*it]==-1)
            {
                q.push_back(*it);
                father[*it]=q.front();
                if(*it==y)
                    break;
            }
        q.pop_front();
    }
    print_path(father,x,y);
}

//------------------------------------------------------------------

void dfs(Graph *graph, vector <int> &used, int x)
{
    printf("%d, ",x);
    it_graf it=graph->get_out_it(x);
    for(int i=0;i<graph->get_out_deg(x);++it,++i)
            if(used[*it]==-1)
            {
                used[*it]=used[x];
                dfs(graph,used,*it);
            }
}

// assume undirected graph
void conex(Graph *graph)
{
    vector <int> used(graph->num_vertices(),-1);
    int k=1;
    for (int i=0;i<graph->num_vertices();++i)
    {
        if(used[i]==-1)
        {
            printf("comp %d: ",k);
            used[i]=k;
            dfs(graph,used,i);
            printf("\n");
            k++;
        }
    }
}

//------------------------------------------------------------------

// assume undirected graph
void art_point(Graph *graph, vector <int> &father, vector <int> &depth, vector <int> &low, int x, int d)
{
    printf("%d \n",x);
    depth[x]=d;
    low[x]=d;
    bool ok=false; // is an articulation point
    int children=0;
    it_graf it=graph->get_out_it(x);
    for(int i=0;i<graph->get_out_deg(x);++it,++i)
    {
        if(father[*it]==-1)
        {
            father[*it]=x;
            art_point(graph,father,depth,low,*it,d+1);
            children++;
            if(low[*it]>=depth[x])
                ok=true;
            low[x]=min(low[*it],low[x]);
        }
        else if (*it!=father[x])
            low[x]=min(low[x],depth[*it]);
    }
    if((father[x]!=INF&&ok)||(father[x]==INF&&children>1))
        printf("!!!%d \n",x);
}

void biconected(Graph *graph) // articulation points
{
    vector <int> father(graph->num_vertices(),-1);
    vector <int> depth(graph->num_vertices(),0);
    vector <int> low(graph->num_vertices(),INF);
    father[0]=INF;
    printf("Articulation Points: ");
    art_point(graph,father,depth,low,0,0);
    printf("\n");
}

//------------------------------------------------------------------

void strong_connect(Graph *graph, deque <int> &q, vector <int> &depth, vector <int> &low, int x, int d)
{
    depth[x]=d;
    low[x]=d;
    q.push_back(x);
    it_graf it=graph->get_out_it(x);
    for(int i=0;i<graph->get_out_deg(x);++it,++i)
    {
        if(depth[*it]<0)
        {
            strong_connect(graph,q,depth,low,*it,d+1);
            low[x]=min(low[x],low[*it]);
        }
        else if(depth[*it]!=-1) // if *it was added in queue
        {
            low[x]=min(low[x],depth[*it]);
        }
    }
    if(low[x]==depth[x])
    {
        printf("scc: ");
        while(q.back()!=x)
        {
            printf("%d ",q.back());
            q.pop_back();
        }
        printf("%d\n",q.back());
        q.pop_back();
    }
}

void tarjan(Graph *graph)
{
    deque <int> q;
    vector <int> depth(graph->num_vertices(),-1);
    vector <int> low(graph->num_vertices(),-1);
    printf("Strong Connected Components:\n");
    for (int i=0;i<graph->num_vertices();++i)
    {
        if(depth[i]==-1)
        {
            strong_connect(graph,q,depth,low,i,0);
        }
    }
}

//------------------------------------------------------------------

// assume no negative cycle
void dijkstra(Graph *graph, Cost *cost, int x, int y)
{

    vector <bool> used(graph->num_vertices(),false);
    vector <int> father(graph->num_vertices(),-1);
    vector <int> d(graph->num_vertices(),INF);
    bool ok=false;
    int min_path,z;
    deque <int> q;
    d[x]=0;
    father[x]=-1;
    while(!ok)
    {
        min_path=INF;
        z=-1;
        for(int i=0;i<d.size();i++)
            if(!used[i]&&min_path>d[i])
            {
                z=i;
                min_path=d[z];
            }
        if(z==y||z==-1)
            break;
        else
        {
            used[z]=true;
            it_graf it=graph->get_out_it(z);
            for(int i=0;i<graph->get_out_deg(z);++it,++i)
                if(d[*it]>d[z]+cost->get(z,*it))
                {
                    d[*it]=d[z]+cost->get(z,*it);
                    father[*it]=z;
                }
        }
    }
    print_path(father,x,y);
}

//------------------------------------------------------------------

void bellman_ford(Graph *graph, Cost *cost, int x, int y)
{
    vector <int> father(graph->num_vertices(),-1);
    vector <int> d(graph->num_vertices(),INF);
    bool ok=true;
    d[x]=0;
    while(ok)
    {
        ok=false;
        for(int j=0;j<graph->num_vertices();j++)
        {
            it_graf it=graph->get_out_it(j);
            for(int i=0;i<graph->get_out_deg(j);++it,++i)
                if(d[*it]>d[j]+cost->get(j,*it))
                {
                    d[*it]=d[j]+cost->get(j,*it);
                    father[*it]=j;
                    ok=true;
                }
        }
        for(int j=0;j<graph->num_vertices();j++)
        {
            it_graf it=graph->get_out_it(j);
            for(int i=0;i<graph->get_out_deg(j);++it,++i)
                if(d[*it]>d[j]+cost->get(j,*it))
                {
                    printf("Negative Cycle!\n");
                    return;
                }
        }
    }
    print_path(father,x,y);
}

//------------------------------------------------------------------

int root(int x, vector <int> r)
{
    int y=x,z;
    while(r[x]!=x)
        x=r[x];
    return x;
}

// assume undirected graph
void kruskal(Graph *graph, Cost *cost)
{
    vector <int> r(graph->num_edges());
    int r1,r2;
    printf("Minimum Spanning Tree:\n");
    cost->sort_min();
    for (int i=0;i<graph->num_edges();++i)
        r[i]=i;
    for (int i=0;i<graph->num_edges();++i)
    {
        r1=root(cost->get_sort_e1(i),r);
        r2=root(cost->get_sort_e2(i),r);
        if(r1!=r2)
        {
            r[r1]=r2;
            printf("edge: %d-%d\n", cost->get_sort_e1(i), cost->get_sort_e2(i));
        }
    }
}

//------------------------------------------------------------------

// assume undirected graph
void coloring(Graph *graph)
{
    vector <int> color(graph->num_vertices(),-1);
    vector <int> deg(graph->num_vertices(),0);
    int min_deg,x,k=0;
    for (int i=0;i<graph->num_vertices();++i)
        deg[i]=graph->get_in_deg(i);
    for (int i=0;i<graph->num_vertices();++i)
    {
        min_deg=INF;
        for (int j=0;j<graph->num_vertices();++j)
            if(color[j]==-1 && min_deg>deg[i])
            {
                min_deg=deg[i];
                x=i;
                break;
            }
        vector <int> avaible(k,0);
        it_graf it=graph->get_out_it(x);
        for(int i=0;i<graph->get_out_deg(x);++it,++i)
            if(color[*it]!=-1)
            {
                avaible[color[*it]]=1;
                deg[*it]--;
            }
        for(int i=0;i<k;++i)
            if(avaible[i]==0)
            {
                color[x]=i;
                break;
            }
        if(color[x]==-1)
        {
            color[x]=k;
            k++;
        }
    }
    printf("Vertex Coloring:\n");
    for (int i=0;i<graph->num_vertices();++i)
        printf("vecrtex %d color: %d\n",i,color[i]);
}


