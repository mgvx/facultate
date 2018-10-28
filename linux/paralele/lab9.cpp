#include <iostream>
#include <thread>
#include <deque>
#include <random>
#include <mutex>
#include <algorithm>
#include <vector>
using namespace std;

const int N = 30, max_depth = 6, max_friends=rand()%(N/2)+N/2;
deque<int> v[N];
mutex mtx;
int ok = 0;

void find_cycle(int d, vector<int> path){
    int k;
    int first_elem = path[0];
    int last_elem = path[path.size()-1];
    vector<thread> th;

    if(path.size()==N && !ok)
      for(int i=0;i<=v[last_elem].size();i++)
        if(v[last_elem][i] == first_elem  && !ok){
              mtx.lock();
              cout<<"\nCYCLE: ";
              for(int i=0;i<N;i++)
                  cout<<path[i]<<" ";
              cout<<"\n";
              ok = 1;
              mtx.unlock();
        }
    if(!ok){
      for(int i =0;i<v[last_elem].size();i++){
          k = 0;
          for(int j=0;j<path.size();j++)
              if(path[j]==v[last_elem][i])
                k = 1;
          if(!k){
              path.push_back(v[last_elem][i]);
              if(d<max_depth && !ok)
                th.push_back(thread(find_cycle,d+1,path));
              else
                find_cycle(d,path);
              path.pop_back();
          }
      }
      for(int i=0;i<th.size();i++)
          th[i].join();
    }
}

int main(){
    int n,last_elem=0,tr;
    srand(time(0));

    for(int j=0;j<N;j++){
        for(int i = 0; i < max_friends; ++ i) {
            last_elem=rand()%N;
            if(find(v[j].begin(),v[j].end(),last_elem)==v[j].end()){
                v[j].push_back(last_elem);
                cout<<v[j][v[j].size()-1]<<" ";
            }
        }
        cout<<"\n";
    }
    if(!ok)
      cout<<"\nNo Cycle Found\n";
    vector<int> a;
    a.push_back(0);
    find_cycle(0,a);
    return 0;
}
