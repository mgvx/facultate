#include <iostream>
#include <thread>
#include <vector>
#include <random>
#include <mutex>
using namespace std;

mutex m[1000000];
vector <int> a,b;
vector <thread> t;
vector <int> c;
int N=2,M=4;

void mul(){ // simple multiplication
    c.resize(a.size()+b.size()-1);
    auto t1 = std::chrono::high_resolution_clock::now();
    for(int i=0;i<a.size();i++)
        for(int j=0;j<b.size();j++)
            c[i+j]+=a[i]*b[j];
    auto now = std::chrono::high_resolution_clock::now();
    cout<<"mul: "<<std::chrono::duration_cast<std::chrono::milliseconds>(now-t1).count()<<" milliseconds\n";
}

void thread_work(int p,int u){
   for(int i=p;i<u;i++) {
        for(int j=0;j<b.size();j++){
            m[i+j].lock();
            c[i+j]+=a[i]*b[j];
            m[i+j].unlock();
        }
  }
}

void mul_threads(int nr_threads){ // threaded multiplication
    c.resize(a.size()+b.size()-1);
    t.resize(nr_threads);
    auto t1 = std::chrono::high_resolution_clock::now();
    for(int i=0;i<nr_threads;i++)
            t[i]=thread(thread_work,i*a.size()/nr_threads,(i+1)*a.size()/nr_threads);
    for(int i=0;i<nr_threads;i++)
            t[i].join();
    auto now = std::chrono::high_resolution_clock::now();
    cout<<"Threaded multiplication "<<std::chrono::duration_cast<std::chrono::milliseconds>(now-t1).count()<<" milliseconds\n";
    t.clear();
}


void karatsuba(vector<int> & a, vector<int>&b ,vector<int> &c){
    // simple cases
    if(a.size()==1){
        for(int i=0;i<b.size();i++)
            c.push_back(a[0]*b[i]);
        return;
    }
    if(b.size()==1){
        for(int i=0;i<a.size();i++)
            c.push_back(b[0]*a[i]);
        return;
    }
    if(b.size()==2){
        for(int i=0;i<a.size();i++)
            c.push_back(b[0]*a[i]);
        for(int i=0;i<a.size()-1;i++)
            c[i+1]+=(b[1]*a[i]);
        c.push_back(b[1]*a[a.size()-1]);
        return;
    }
    if(a.size()==2){
        for(int i=0;i<b.size();i++)
            c.push_back(a[0]*b[i]);
        for(int i=0;i<b.size()-1;i++)
            c[i+1]+=(a[1]*b[i]);
        c.push_back(a[1]*b[b.size()-1]);
        return;
    }


    int A=a.size(),B=b.size();
    vector<int> a1,a2,a3,b1,b2,b3,z1,z2,z3;

    for(int i=0;i<A/2;i++){
        a1.push_back(a[i]);
        a2.push_back(a[i+A/2]);
        a3.push_back(a[i]+a[i+A/2]);
    }
    if (A%2){
        a1.push_back(0);
        a2.push_back(a[A-1]);
        a3.push_back(a[A-1]);
    }

    for(int i=0;i<B/2;i++){
        b1.push_back(b[i]);
        b2.push_back(b[i+B/2]);
        b3.push_back(b[i]+b[i+B/2]);
    }
    if (B%2){
        b1.push_back(0);
        b2.push_back(b[B-1]);
        b3.push_back(b[B-1]);
    }
    karatsuba(a1,b1,z1);
    karatsuba(a2,b2,z2);
    karatsuba(a3,b3,z3);

    for(int i=0;i<z3.size();i++)
        z3[i]-=(z1[i]+z2[i]);

    c.resize(A+B-1);
    int C=z1.size();
    int D=C/2;
    for(int i=0;i<C;i++)
    {
        c[i]+=z1[i];
        c[i+C-D]+=z3[i];
        c[A+B-1-C+i]+=z2[i];
    }

}


void mul_karatsuba(){
    auto t1 = std::chrono::high_resolution_clock::now();
    karatsuba(a,b,c);
    auto now = std::chrono::high_resolution_clock::now();
    cout<<"Karatsuba multiplication "<<std::chrono::duration_cast<std::chrono::milliseconds>(now-t1).count()<<" milliseconds\n";

}

void karatsuba_t(vector<int> &a, vector<int>&b ,vector<int> &c){
    if(a.size()==1){
        for(int i=0;i<b.size();i++)
            c.push_back(a[0]*b[i]);
        return;
    }
    if(b.size()==1){
        for(int i=0;i<a.size();i++)
            c.push_back(b[0]*a[i]);
        return;
    }
    if(b.size()==2){
        for(int i=0;i<a.size();i++)
            c.push_back(b[0]*a[i]);
        for(int i=0;i<a.size()-1;i++)
            c[i+1]+=(b[1]*a[i]);
        c.push_back(b[1]*a[a.size()-1]);
        return;
    }
    if(a.size()==2){
        for(int i=0;i<b.size();i++)
            c.push_back(a[0]*b[i]);
        for(int i=0;i<b.size()-1;i++)
            c[i+1]+=(a[1]*b[i]);
        c.push_back(a[1]*b[b.size()-1]);
        return;
    }


    t.resize(3);
    int A=a.size(),B=b.size();
    vector<int> a1,a2,a3,b1,b2,b3,z1,z2,z3;

    for(int i=0;i<A/2;i++){
        a1.push_back(a[i]);
        a2.push_back(a[i+A/2]);
        a3.push_back(a[i]+a[i+A/2]);
    }
    if (A%2){
        a1.push_back(0);
        a2.push_back(a[A-1]);
        a3.push_back(a[A-1]);
    }

    for(int i=0;i<B/2;i++){
        b1.push_back(b[i]);
        b2.push_back(b[i+B/2]);
        b3.push_back(b[i]+b[i+B/2]);
    }
    if (B%2){
        b1.push_back(0);
        b2.push_back(b[B-1]);
        b3.push_back(b[B-1]);
    }

    t[0]=thread(karatsuba,ref(a1),ref(b1),ref(z1));
    t[1]=thread(karatsuba,ref(a2),ref(b2),ref(z2));
    t[2]=thread(karatsuba,ref(a3),ref(b3),ref(z3));

    for(int i=0;i<3;i++)
            t[i].join();

    for(int i=0;i<z3.size();i++)
        z3[i] -= (z1[i] + z2[i]);

    c.resize(A+B-1);
    t.clear();
    int C = z1.size();
    int D = C/2;
    for(int i=0;i<C;i++) {
        c[i]+=z1[i];
        c[i+C-D]+=z3[i];
        c[A+B-1-C+i]+=z2[i];
    }
}

void mul_karatsuba_threads(){
    auto t1 = std::chrono::high_resolution_clock::now();
    karatsuba_t(a,b,c);
    auto now = std::chrono::high_resolution_clock::now();
    cout<<"Karatsuba multiplication threads "<<std::chrono::duration_cast<std::chrono::milliseconds>(now-t1).count()<<" milliseconds\n";
}

void clear_result(){
  for(int i=0;i<c.size();i++)
      cout<<c[i]<<" ";
  cout<<"\n";
  c.clear();
}

int main()
{
    srand(time(0));
    cout<<"sizes: "<<N<<" "<<M<<"\n";
    a.resize(N);
    b.resize(M);
    for(int i=0;i<N;i++)
        a[i] = rand()%6;
    for(int i=0; i<M; i++)
        b[i] = rand()%6;

   for(int i=0;i<a.size();i++)
       cout<<a[i]<<" ";
   cout<<"\n";
   for(int i=0;i<b.size();i++)
       cout<<b[i]<<" ";
   cout<<"\n";

    mul();
    clear_result();

    mul_threads(10);
    clear_result();

    mul_karatsuba();
    clear_result();

    mul_karatsuba_threads();
    clear_result();

    return 0;
}
