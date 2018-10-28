#include <cstdio>
#include "graph.h"
#include "cost.h"
#include "algorithms.h"
using namespace std;

Graph graph;
Cost cost;

//Graph graph_copy = graph;
typedef vector<int>::iterator it_graf;

void read_dir_graph()
{
    int n,m,x,y,z;
    FILE *f;
    f=fopen("data.txt","r");
    fscanf(f,"%d%d",&n,&m);
    graph.v_in.resize(n);
    graph.v_out.resize(n);
    while(m--)
    {
        fscanf(f,"%d%d%d",&x,&y,&z);
        graph.add_edge(x,y);
        cost.upd(x,y,z);
    }
    fclose(f);
}

void read_undir_graph()
{
    int n,m,x,y,z;
    FILE *f;
    f=fopen("data.txt","r");
    fscanf(f,"%d%d",&n,&m);
    graph.v_in.resize(n);
    graph.v_out.resize(n);
    while(m--)
    {
        fscanf(f,"%d%d%d",&x,&y,&z);
        graph.add_edge(x,y);
        graph.add_edge(y,x);
        cost.upd(x,y,z);
        cost.upd(y,x,z);
    }
    fclose(f);
}

int get_vertex(char msg[])
{
    int x;
    printf(msg);
    scanf("%d",&x);
    while(!graph.valid(x))
    {
        printf("Vertex doesn't exist! Try again:\n");
        printf(msg);
        scanf("%d",&x);
    }
    return x;
}

void print_menu()
{
    printf("\nMenu:\n");
    printf("1\tquery graph...\n");
    printf("2\tmodify graph...\n");
    printf("3\talgorithms...\n");
    printf("q\tquit\n");

}

void print_query_menu()
{
    printf("1\tnumber vertices?\n");
    printf("2\tnumber edges?\n");
    printf("3\tedge exists?\n");
    printf("4\tget cost of edge\n");
    printf("5\tget outer degree of vertex\n");
    printf("6\tget inner degree of vertex\n");
    printf("7\tall outbound edges of vertex\n");
    printf("8\tall inbound edges of vertex\n");
}

void print_algo_menu()
{
    printf("1\tBFS - lowest length path\n");
    printf("2\tDFS - connected components\n");
    printf("3\tArticulation Points - biconected components\n");
    printf("4\tTarjan - strongly connected components\n");
    printf("5\tDijkstre - lowest cost walk\n");
    printf("6\tBellmanFord - lowest cost walk\n");
    printf("7\tKruskal - minumal spanning tree\n");
    printf("8\tVertex minimum coloring\n");
}

void print_mod_menu()
{
    printf("\n1\tadd vertex\n");
    printf("2\tremove vertex\n");
    printf("3\tadd edge\n");
    printf("4\tremove edge\n");
    printf("5\tupdate cost\n");
}

void query_menu()
{
    int x,y;
    char c;
    print_query_menu();
    scanf("%s",&c);
    if(c=='1')
        printf("num vertex: %d",graph.num_vertices());
    else if(c=='2')
        printf("num edges: %d",graph.num_edges());
    else if(c=='3')
    {
        x=get_vertex("from vertex: ");
        y=get_vertex("to vertex: ");
        if(graph.are_friends(x,y))
            printf("Edge exists!\n");
        else
            printf("No edge!\n");
    }
    else if(c=='4')
    {
        x=get_vertex("from vertex: ");
        y=get_vertex("to vertex: ");
        if(cost.exist(x,y))
            printf("edge [%d,%d] cost: %d\n",x,y,cost.get(x,y));
        else
            printf("edge [%d,%d] doesn't have a cost!\n",x,y);
    }
    else if(c=='5')
    {
        x=get_vertex("vertex: ");
        printf("outer degree: %d\n",graph.get_out_deg(x));
    }
    else if(c=='6')
    {
        x=get_vertex("vertex: ");
        printf("inner degree: %d\n",graph.get_in_deg(x));
    }
    else if(c=='7')
    {
        x=get_vertex("vertex: ");
        it_graf it=graph.get_out_it(x);
        for(int i=0;i<graph.get_out_deg(x);++it,++i)
            printf("outbound edge [%d,%d]\n",*it,x);
    }
    else if(c=='8')
    {
        x=get_vertex("vertex: ");
        it_graf it=graph.get_in_it(x);
        for(int i=0;i<graph.get_in_deg(x);++it,++i)
            printf("inbound edge [%d,%d]\n",*it,x);
    }
}

void algo_menu()
{
    int x,y;
    char c;
    print_algo_menu();
    scanf("%s",&c);
    if(c=='1')
    {
        x=get_vertex("from vertex: ");
        y=get_vertex("to vertex: ");
        bfs(&graph,x,y);
    }
    else if(c=='2')
    {
        conex(&graph);
    }
    else if(c=='3')
    {
        biconected(&graph);
    }
    else if(c=='4')
    {
        tarjan(&graph);
    }
    else if(c=='5')
    {
        x=get_vertex("from vertex: ");
        y=get_vertex("to vertex: ");
        dijkstra(&graph,&cost,x,y);
    }
    else if(c=='6')
    {
        x=get_vertex("from vertex: ");
        y=get_vertex("to vertex: ");
        bellman_ford(&graph,&cost,x,y);
    }
    else if(c=='7')
    {
        kruskal(&graph,&cost);
    }
    else if(c=='8')
    {
        coloring(&graph);
    }
}

void mod_menu()
{
    int x,y,z;
    char c;
    print_mod_menu();
    scanf("%s",&c);
    if(c=='1')
    {
        graph.add_vertex(x);
        printf("vertex %d added!\n",x);
    }
    else if(c=='2')
    {
        x=get_vertex("vertex: ");
        graph.rem_vertex(x);
        printf("vertex %d removed!\n",x);
    }
    else if(c=='3')
    {
        x=get_vertex("from vertex: ");
        y=get_vertex("to vertex: ");
        graph.add_edge(x,y);
        printf("edge %d-%d added!\n",x,y);
    }
    else if(c=='4')
    {
        x=get_vertex("from vertex: ");
        y=get_vertex("to vertex: ");
        if(graph.are_friends(x,y))
        {
            graph.rem_edge(x,y);
            printf("edge %d-%d removed!\n",x,y);
        }
        else printf("edge doesn't exist!\n");
    }
    else if(c=='5')
    {
        x=get_vertex("from vertex: ");
        y=get_vertex("to vertex: ");
        printf("new cost: ");
        scanf("%d",&z);
        cost.upd(x,y,z);
    }
    else if(c=='6')
    {
        x=get_vertex("from vertex: ");
        y=get_vertex("to vertex: ");
        cost.del(x,y);
    }
    else
        printf("invalid option!\n");
}

int main()
{
    int x,y,finish=0;
    char c;
    printf("Graph mode?\n0 - directed\n1 - undirected\n");
    scanf("%s",&c);
    if(c=='0')
        read_dir_graph();
    else
        read_undir_graph();
    while(!finish)
    {
        print_menu();
        scanf("%s",&c);
        if(c=='1')
            query_menu();
        else if(c=='2')
            mod_menu();
        else if(c=='3')
            algo_menu();
        else if(c=='q')
            finish=1;
        else
            printf("invalid option!\n");
    }
    return 0;
}

