#include "cat.h"

ostream& operator<<(ostream& stream, Cat &k)
{
    char d = ',';
    string s = k.getName() + d + k.getBreed() + d + to_string(k.getAge()) + d + k.getPhoto() + d + to_string(k.getAdopt()) + d + '\n';
    stream << s;
    return stream;
}

istream& operator>>(istream& stream, Cat &k)
{
    string s, name, breed, age, link, adopt;
    stream >> s;
    int a, b;
    a = 0;
    b = s.find(',');
    name = s.substr(a, b);
    k.setName(name);

    a = b + 1;
    b = s.find(',', a);
    breed = s.substr(a, b - a);
    k.setBreed(breed);

    a = b + 1;
    b = s.find(',', a);
    age = s.substr(a, b - a);
    k.setAge(atoi(age.c_str()));

    a = b + 1;
    b = s.find(',', a);
    link = s.substr(a, b - a);
    k.setPhoto(link);

    a = b + 1;
    b = s.find(',');
    adopt = s.substr(a, b - a);
    a = b + 1;
    k.setAdopt(atoi(adopt.c_str()));
    return stream;
}


