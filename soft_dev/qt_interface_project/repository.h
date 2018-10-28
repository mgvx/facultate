#pragma once
#include "cat.h"
#include <vector>
#include <Windows.h>
using namespace std;

class Repository
{
private:
    vector <Cat> cats;
    int index(string name)
    {
        for (int i = 0; i < cats.size(); ++i)
            if (cats[i].getName() == name)
            {
                return i;
            }
        return -1;
    }

public:
    Repository()
    {
        load();
    }

    void add(Cat x)
    {
        if (index(x.getName()) == -1)
        {
            cats.push_back(x);
        }
        else
            throw CatException("Cat already exists!\n");
        save();
    }

    void rem(string name)
    {
        if (index(name) != -1)
        {
            int i = index(name);
            cats.erase(cats.begin() + i);
        }
        else
            throw CatException("Cat doesn't exist!\n");
        save();
    }

    void adopt(string name, int a)
    {
        int i = index(name);
        if (i != -1)
        {
            cats[i].setAdopt(a);
        }
        else
            throw CatException("Cat doesn't exist!\n");
        save();
    }

    void upd(string name, string new_name,string new_breed, int new_age, string new_photo)
    {
        if (index(name) != -1)
        {
            int i = index(name);
            cats[i].setName(new_name);
            cats[i].setAge(new_age);
            cats[i].setBreed(new_breed);
            cats[i].setPhoto(new_photo);
        }
        else
            throw CatException("Cat doesn't exist!\n");
        save();
    }

    void load()
    {
        ifstream F;
        Cat k;
        F.open("data.txt");
        while (F >> k)
            add(k);
        F.close();
    }

    void save()
    {
        ofstream F;
        F.open("data.txt");
        string s;
        for (int i = 0; i < cats.size(); ++i)
            F << cats[i];
        F.close();
    }

    void export_data_html()
    {
        ofstream F;
        F.open("export.html");
        string s;
        F << "<!DOCTYPE html>\n<html>\n\t<head>\n\t\t<title>CATZ!!!</title>\n\t</head>\n";
        F << "<body>\n<table border='1'>\n";
        F << "<tr>\n<td>Name:</td>\n<td>Breed:</td>\n<td>Age:</td>\n<td>Image:</td>\n<td>Adopt:</td>\n</tr>\n";
		for (int i = 0; i < cats.size(); ++i)
		{
			if (cats[i].getAdopt() != 0)
			{
				s = "<tr>\n";
				s += "<td>" + cats[i].getName() + "</td>";
				s += "<td>" + cats[i].getBreed() + "</td>";
				s += "<td>" + to_string(cats[i].getAge()) + "</td>";
				s += "<td> <img src = \"" + cats[i].getPhoto() + "\" style = \"width:200px;height:126px;\"> </td>";
				s += "<td>" + to_string(cats[i].getAdopt()) + "</td>";
				s += "\n</tr>\n";
				F << s;
			}
        }
        F << "</table>\n</body>\n</html>\n";
        F.close();
    }

	void export_data_csv()
	{
		ofstream F;
		F.open("export.csv");
		string s;
		for (int i = 0; i < cats.size(); ++i)
			if (cats[i].getAdopt() != 0)
				F << cats[i];
		F.close();
	}

    void show_export_html()
    {
		LPCWSTR prog = L"chrome.exe";
		LPCWSTR link = L"export.html";
        ShellExecute(NULL, NULL, prog, link, NULL, SW_SHOWNORMAL);
    }

	void show_export_csv()
	{
		LPCWSTR prog = L"notepad.exe";
		LPCWSTR link = L"export.csv";
		ShellExecute(NULL, NULL, prog, link, NULL, SW_SHOWNORMAL);
	}

    std::vector<Cat> getCats() const { return cats; }

};
