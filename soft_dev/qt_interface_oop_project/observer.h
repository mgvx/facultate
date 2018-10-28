#pragma once
#include <vector>
using namespace std;

class Observer
{
public:
	Observer() {};
	~Observer() {};

	virtual void update() = 0;
};

class Observable
{
public:
	Observable() {};
	~Observable() {};

	void attach(Observer *x) {
		obs.push_back(x);
	}

	void notify() {
		for (auto it : obs)
			it->update();
	}

private:
	vector <Observer *> obs;
};

