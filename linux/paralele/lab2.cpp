#include<iostream>
#include<thread>
#include<random>
#include<mutex>
#include<sstream>

#define N 200
using namespace std;

int x[N][N], y[N][N], z[N][N];
thread t[N*N+1];

void add(int a,int b,int t) {
    while(a+b <= 2*N-2) {
        // // get thread id
        // auto myid = this_thread::get_id();
        // stringstream ss;
        // ss << myid;
        // string strid = ss.str();
        // strid = strid.substr(strid.length()-2);
        // cout<<"Thread "<< strid <<": sum pos "<<a<<" "<<b<<"\n";

        z[a][b] = x[a][b] + y[a][b];
        a += t;
        while(a >= N) {
            a -= N;
            b++;
        }
    }
}

void mul(int a,int b,int t){
    while(a+b <= 2*N-2){
        // // get thread id
        // auto myid = this_thread::get_id();
        // stringstream ss;
        // ss << myid;
        // string strid = ss.str();
        // strid = strid.substr(strid.length()-2);
        // cout<<"Thread "<< strid <<": mul pos "<<a<<" "<<b<<"\n";

        z[a][b] = 0;
        for(int j=0; j<N; j++)
            z[a][b] += x[a][j] * y[j][b];
        a += t;
        while( a>= N) {
            a -= N;
            b++;
        }
    }
}

void run (int x) {
    auto t1 = std::chrono::high_resolution_clock::now();

    int a=0,b=0; // for the matrix columns and rows
    for(int i=0; i<x; i++) {
        t[i] = thread(mul, a, b, x); // start the threads with given position and stepsize
        a++;
        if(a >= N) { // if passed on the next row
            a -= N;
            b++;
        }
    }
    for(int i=0; i<x; i++)
        t[i].join(); // join the thread

    auto t2 = std::chrono::high_resolution_clock::now();
    cout<<"Time for " << x <<" threads: "<<std::chrono::duration_cast<std::chrono::milliseconds>(t2-t1).count()<<" milliseconds\n";
}

int main() {
    srand(time(0));
    // cout<<"\nMATRIX 1:";
    for(int i=0;i<N;i++) {
        // cout<<"\n";
        for(int j=0;j<N;j++) {
            x[i][j]=rand()%9+1;
            // cout<<x[i][j]<<" ";
        }
    }
    // cout<<"\n";
    // cout<<"\nMATRIX 2:";
    for(int i=0;i<N;i++) {
        // cout<<"\n";
        for(int j=0;j<N;j++) {
            y[i][j]=rand()%9+1;
            // cout<<y[i][j]<<" ";
        }
    }
    cout<<"\n\n";

    run(1);
    run(N/50);
    run(N/20);
    run(N/10);
    run(N/5);
    run(N/2);
    run(N);
    run(N*2);
    run(N*5);
    run(N*10);
    run(N*20);

    // cout<<"\nRESULT:";
    // for(int i=0;i<N;i++)
    // {
    //    cout<<"\n";
    //    for(int j=0;j<N;j++)
    //        cout<<z[i][j]<<" ";
    // }
    cout<<"\n";
    return 0;
}
