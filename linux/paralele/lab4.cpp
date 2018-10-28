#include<iostream>
#include<thread>
#include<random>
#include<mutex>
#include<condition_variable>

#define N 200
using namespace std;

int x[N][N],y[N][N],z[N][N],p[N][N],r[N][N];
thread t[N*N],t2[N*N];

int row_check[N]; // 0 if all elements from a row were calculated
mutex log_m,row[N];
condition_variable cond; // for notifications

void mul(int a,int b,int t){
    unique_lock<mutex> row_lock(row[a]);
    int aa;
    while(a+b<=2*N-2){
        p[a][b]=0;
        aa=a;
        for(int j=0;j<N;j++)
            p[a][b] += x[a][j] * y[j][b];

        row_check[a]--; // one element is computed on that row

        if(row_check[a]==0)
            cond.notify_all(); // start next multiplication for this row

        a+=t;
        while(a>N-1){  // for getting to next row
            a-=N;
            b++;
        }
        if(aa!=a) // change lock if you get on next row
            row_lock = unique_lock<mutex>(row[a]);
    }

}


void mul2(int a,int b,int t){
    unique_lock<mutex> row_lock(row[a]);
    int aa;
    while(a+b <= 2*N-2){
        r[a][b]=0;
        aa=a;
        while(row_check[a]>0){
            cond.wait(row_lock); // wait for row
        }
        for(int j=0;j<N;j++)
            r[a][b] += p[a][j] * z[j][b];

        a+=t;
        while(a>N-1){  // for getting to next row
            a-=N;
            b++;
        }
        if(aa!=a) // change lock if you get on next row
            row_lock = unique_lock<mutex>(row[a]);
    }

}

void run(int n) {
    auto t1 = std::chrono::high_resolution_clock::now();
    if(n>N*N) return;

    int a=0;
    int b=0;
    for(int i=0;i<n;i++){
        t[i]=thread(mul,a,b,n);
        a++;
        if(a>N-1){
            a-=N;
            b++;
        }
    }

    a=0;
    b=0;
    for(int i=0;i<n;i++){
        t2[i]=thread(mul2,a,b,n);
        a++;
        if(a>N-1){
            a-=N;
            b++;
        }
    }

    for(int i=0;i<n;i++)
        t[i].join();
    for(int i=0;i<n;i++)
        t2[i].join();

    auto t2 = std::chrono::high_resolution_clock::now();
    cout<<"Time for " << x <<" threads: "<<std::chrono::duration_cast<std::chrono::milliseconds>(t2-t1).count()<<" milliseconds\n";

}



int main(){
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
    // cout<<"\n";
    // cout<<"\nMATRIX 3:";
    for(int i=0;i<N;i++) {
        // cout<<"\n";
        for(int j=0;j<N;j++) {
            z[i][j]=rand()%9+1;
            // cout<<y[i][j]<<" ";
        }
    }
    // cout<<"\n\n";

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

    // cout<<"\nRESULT PARTIAL:";
    // for(int i=0;i<N;i++)
    // {
    //    cout<<"\n";
    //    for(int j=0;j<N;j++)
    //        cout<<p[i][j]<<" ";
    // }

    // cout<<"\nRESULT:";
    // for(int i=0;i<N;i++)
    // {
    //    cout<<"\n";
    //    for(int j=0;j<N;j++)
    //        cout<<p[i][j]<<" ";
    // }
    return 0;
}
