#pragma once
#include "observer.h"
#include "object.h"
#include <fstream>
#include <vector>
using namespace std;

class Repository: public Observable
{
private:
	vector <Object> data;

public:
	Repository()
	{
		load();
	}

	~Repository()
	{
		save();
	}

	int find(Object x)
	{
		for (int i = 0; i < data.size(); ++i)
			if (data[i] == x)
				return i;
		return -1;
	}

	void add(Object x)
	{
		data.push_back(x);
		notify();
	}

	void rem(Object x)
	{
		vector <Object> u;
		for (int i = 0; i < data.size(); ++i)
			if (data[i] != x)
				u.push_back(data[i]);
		data = u;
		notify();
	}

	std::vector<Object> getAll()
	{ 
		return data;
	}

	void sortData()
	{
		sort(data.begin(), data.end(), [](Object &a, Object &b) {
			return a.getName() < b.getName(); });
	}

	void load()
	{
		ifstream F;
		F.open("data.txt");
		string s;
		string name;
		int num;
		while (getline(F, s)) {
			int a, b;
			a = 0;
			b = s.find(',');
			name = s.substr(a, b);

			a = b + 1;
			b = s.find(',', a);
			num = atoi((s.substr(a, b - a)).c_str());

			data.push_back(Object(name, num));
		}
		F.close();
	}

	void save()
	{
		ofstream F;
		F.open("data.txt");
		for (int i = 0; i < data.size(); ++i)
			F << data[i].toString();
		F.close();
	}
};
