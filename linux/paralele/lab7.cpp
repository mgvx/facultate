#include <iostream>
#include <thread>
#include <vector>
#include <random>
#include <mutex>
using namespace std;

const int N = 10000;
int sum[N], fsum[N];
int v[N];
mutex lg;
vector<thread> th;

void partialize_sums(int first,int last){
    sum[first] = v[first];
    for (int i = first+1; i<last; i++){
        sum[i] = sum[i-1] + v[i];
    }
}

void finalize_sums(int first, int log_n, int n){
    int s=0, i;
    fsum[first] = sum[first];
    for(i=1; i*n/log_n <= first; i++);
    i--;
    if(i>0)
        if(fsum[i*n/log_n-1] == 0) {
            finalize_sums(i*n/log_n-1, log_n, n);
            fsum[first] = fsum[i*n/log_n-1] + sum[first];
        }
        else{
            fsum[first]=fsum[i*n/log_n-1]+sum[first];
        }
}

int flog (int o) {
  int x=0;
  while(o>0) {
      x++;
      o/=2;
  }
  return x;
}

int main(){
    int n;
    clock_t t;
    t = clock();
    srand(time(0));

    cout<<"n: ";
    cin >> n;
    for(int i = 0; i < n; ++ i) {
        v[i]=rand()%9+1;
        cout<<v[i]<<" ";
    }
    cout<<"\n";
    int log_n = flog(n);

    for(int i=0;i<log_n;i++)
        th.push_back(thread(partialize_sums, i*n/log_n, (i+1)*n/log_n));
    for(int i=0;i<log_n;i++)
        th[i].join();

    for(int i=0;i<n;i++) {
        finalize_sums(i,log_n,n);
        cout<<fsum[i]<<" ";
    }
    cout<<"\n";
    return 0;
}
