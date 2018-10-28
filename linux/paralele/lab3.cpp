#include<iostream>
#include<thread>
#include<random>
#include<mutex>
#include<sstream>
#include "thread_pool.h"

#define N 60
using namespace std;

int x[N][N], y[N][N], z[N][N];
thread t[N*N+1];

void run_pool (int n) {
    auto t1 = std::chrono::high_resolution_clock::now();

    std::vector<std::future<void>> results;
    results.reserve(n);
    ThreadPool t_pool(n);

     for(int t = 0; t < n ; t++) {
       results.emplace_back( t_pool.enqueue([&x, &y, &z, t, n] {
            for (int i = t; i < N; i += n) { // skip window
              for (int j = 0; j < N; j++) {
                for (int k = 0; k < N; k++) {
                  z[i][j] += x[i][k] * y[k][j];
                }
              }
            }
          }));
    }

    for (unsigned t = 0; t < n; t++) {
      results[t].get();
    }

    auto t2 = std::chrono::high_resolution_clock::now();
    cout<<"Time for " << n <<" threads: "<<std::chrono::duration_cast<std::chrono::milliseconds>(t2-t1).count()<<" milliseconds\n";
}

void run_async(int n){
    auto t1 = std::chrono::high_resolution_clock::now();
    std::vector<std::future<void>> results;
    results.reserve(n);

    for (unsigned t = 0; t < n ; t++) {
      results.emplace_back(
          std::async(std::launch::async, [&x, &y, &z, t, n]() {
            for (int i = t; i < N; i += n) { // skip window
              for (int j = 0; j < N; j++) {
                for (int k = 0; k < N; k++) {
                  z[i][j] += x[i][k] * y[k][j];
                }
              }
            }
          }));
    }

    for (unsigned int t = 0; t < n; t++) {
      results[t].get();
    }

    auto t2 = std::chrono::high_resolution_clock::now();
    cout<<"Time for " << n <<" threads: "<<std::chrono::duration_cast<std::chrono::milliseconds>(t2-t1).count()<<" milliseconds\n";
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

    cout<<"\nThread Pool:\n";
    run_pool(1);
    run_pool(N/20);
    run_pool(N/5);
    run_pool(N);
    run_pool(N*5);
    run_pool(N*20);
    run_pool(N*N/5);
    run_pool(N*N);

    cout<<"\nAsync Future:\n";
    run_async(1);
    run_async(N/20);
    run_async(N/5);
    run_async(N);
    run_async(N*5);
    run_async(N*20);
    run_async(N*N/5);
    run_async(N*N);

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
