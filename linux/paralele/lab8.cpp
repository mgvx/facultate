#include <iostream>
#include <thread>
#include <deque>
#include <random>
#include <mutex>
using namespace std;

const int N=3, t=0;
deque<int> d[N];
deque<int> r;
vector<thread> th;

void add(int a,int b,int &c){
    if(a==b){
        if(d[a].size()>0){
            c = d[a][0];
            d[a].pop_front();
        }
        else
            c = 0;
        return;
    }
    int c1,c2;
    thread t1 = thread(add, a, (a+b)/2, ref(c1));
    thread t2 = thread(add, (a+b)/2+1, b, ref(c2));
    t1.join();
    t2.join();
    c= c1 + c2;
    t1.joinable();
    t2.joinable();
    return;
}

int main() {
    int len = 5;
    int n, max_n=0;

    for(int j=0; j<N; j++){
        n = rand()%len+1;
        max_n = max(max_n, n);
        for(int i=0; i<len-n; ++i)
            cout<<" ";
        for(int i=0; i<n; ++i) {
            d[j].push_front(rand()%9+1);
            cout<<d[j][0];
        }
        cout<<"\n";
    }

    clock_t tm;
    tm = clock();
    srand(time(0));
    int tr=0;

    for(int i=0; i<max_n || tr!=0; i++){
        if(i<max_n){
            th.push_back( thread(add,0,N-1,ref(n)));
            th[i].join();
        }
        else
            n=0;
        n+=tr;
        tr=n/10;
        r.push_front(n%10);
    }

    for(int i=0; i<r.size(); ++i) {
        cout<<r[i];
    }

    cout<<"\n";
    return 0;
}
