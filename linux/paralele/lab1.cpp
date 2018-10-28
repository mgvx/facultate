#include<iostream>
#include<vector>
#include<random>
#include<mutex>
#include <unistd.h>
#include<thread>
#include <sstream>
using namespace std;

#define num_products 10
#define num_threads 10
#define sales_per_thread 10
int nosec = 1000;
int min_quan = 1000;

thread t[num_threads], tcheck;
int price[num_products]; // price of items
int initial_quant[num_products]; // initial quantities
int quant[num_products]; // ongoing quantities
int profit=0; // ongoing profit
vector <int> trans[num_products+1]; // each column is a sale with the last cell equal to its bill profit
mutex quant_mutex,trans_mutex,profit_mutex;


void check()
{
    int n = 10;

    while (n--) {
      usleep(nosec);
      for (int i=0; i<10000;i++);
      quant_mutex.lock();
      profit_mutex.lock();
      trans_mutex.lock();

      cout<<"\n\nCheck No: " << n;
      int q[num_products]; // quantity of products for verification
      int p; // ongoing verification profit
      p=profit; // overall profit for undos
      for(int i=0;i<num_products;i++)
          q[i]=quant[i]; // initialize with the present quantity

      // check if the quantities of products and the profit are right
      for(int i=0;i<trans[0].size();i++)
      {
          for(int j=0;j<num_products;j++)
              q[j]+=trans[j][i]; // undo products quantity for transaction i
          p-=trans[num_products][i]; // undo the profit for transaction i
      }
      int ok = 1;
      for(int i=0;i<num_products;i++){ // check if items are back to initial quantities
          if(q[i]!=initial_quant[i]) {
      				cout << "\nCHECK FAILED BAD QUANT\n";
              ok = 0;
      				break;
      		}
      }
      if(p!=0) { // check price
          cout << "\nCHECK FAILER BAD PROFIT\n";
          ok = 0;
  		}
      if (ok)
        cout << "\nCHECK PASSED\n";

      quant_mutex.unlock();
      profit_mutex.unlock();
      trans_mutex.unlock();
    }
}

void op(){
    int sale[num_products+1], p;
    srand(time(0));
    int n = sales_per_thread;
    while(n--){
        p=0; // profit per sale

        // get thread id
        auto myid = this_thread::get_id();
        stringstream ss;
        ss << myid;
        string strid = ss.str();
        strid = strid.substr(strid.length()-2);


        quant_mutex.lock(); // lock product quantities

        cout<<"\n\nThread: " << strid << " Sale: " << n <<"\n"<<"Stock : ";
        for (int i=0;i<num_products;i++){
            sale[i]=0;
            if(quant[i]>0)
                sale[i]=(rand()%quant[i])%10+1; // generate a sale
            cout<<quant[i]<<" ";
        }

        // make the sale
        cout<<"\nSale  : ";
        for (int i=0;i<num_products;i++){
            quant[i]-=sale[i]; // subtract quant
            p+=sale[i]*price[i]; // add profit
            cout<<sale[i]<<" ";
        }

        quant_mutex.unlock(); // unlock product quantities

        // update overall profit
        profit_mutex.lock();
        profit+=p;
        profit_mutex.unlock();

        // log transaction
        trans_mutex.lock();
        for (int i=0;i<num_products;i++)
            trans[i].push_back(sale[i]);
        trans[num_products].push_back(p);
        trans_mutex.unlock();

        usleep(nosec);
    }
}


int main(){
    srand(time(0));
    for(int i=0;i<num_products;i++)
        price[i]=rand()%100+1; // initialize prices
    for(int i=0;i<num_products;i++) {
        initial_quant[i] = rand()%100+min_quan;; // initialize quantities
        quant[i]= initial_quant[i];
    }

		for(int i=0;i<num_threads;i++) // start threads
        t[i]=thread(op);
    tcheck=thread(check); // start checker threads

    for(int i=0;i<num_threads;i++) // join threads
        t[i].join();
    tcheck.join(); // end checker thread
    cout << "\n";
    return 0;
}
