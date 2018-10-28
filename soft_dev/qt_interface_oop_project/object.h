#pragma once
#include <string>
using namespace std;

class Object
{
private:
	string name;
	int num;

public:
	Object(string _name = "", int _num = 0)
	{
		name = _name;
		num = _num;
	}
	~Object() {};

	bool operator == (Object &other) {
		return name == other.name && num == other.num;
	}

	bool operator != (Object &other) {
		return !(name == other.name && num == other.num);
	}

	string toString() {
		return name + "," + to_string(num) + "\n";
	}

	string getName() { return name; }
	int getNum() { return num; }

	void setName(string x) { name = x; }
	void setNum(int x) { num = x; }


};