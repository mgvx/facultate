#pragma once
#include <string>
#include <fstream>
using namespace std;

class Cat
{
private:
    string breed;
    string name;
    string photo;
    int age;
    int adopt;

public:
    Cat(string n="", string b="", int a=0, string p="", int x=0)
    {
        name = n;
        breed = b;
        age = a;
        photo = p;
        adopt = x;
    }

    string getName() { return name; }
    string getBreed() { return breed; }
    string getPhoto() { return photo; }
    int getAdopt() { return adopt; }
    int getAge() { return age; }
    void setName(string x) { name = x; }
    void setBreed(string x) { breed = x; }
    void setPhoto(string x) { photo = x; }
    void setAge(int x) { age=x; }
    void setAdopt(int x) { adopt=x; }

    string get_string(char d)
    {
        string s;
        s += getName() + d + getBreed() + d + to_string(getAge()) + d + to_string(getAdopt()) + '\n';
        return s;
    }
};

class CatException : public exception
{
public:
    CatException(string s) :msg(s) {}
    string what()
    {
        return msg;
    }
private:
    string msg;
};

ostream& operator<<(ostream& stream, Cat &k);

istream& operator>>(istream& stream, Cat &k);

