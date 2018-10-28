#include<iostream>
using namespace std;

int main()
{
    int n;
    float s;
    float x;
    cin >> n;
    s = 0;
    while( n!=0 )
    {
        n = n-1;
        cin >> x;
        s = s+x;
    }
    cout << s ;
    return 0;
}
