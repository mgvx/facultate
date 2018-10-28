#pragma once
#include "repository.h"

class Controller
{

private:
    Repository &repo;

public:
    Controller(Repository &r) : repo(r){};

    void addCat(string name, string breed, int age, string photo)
    {
        Cat x(name, breed, age, photo, 0);
        repo.add(x);
    }

    void remCat(string name)
    {
        repo.rem(name);
    }

    void updCat(string name, string new_name, string new_breed, int new_age, string new_photo)
    {
        repo.upd(name, new_name, new_breed, new_age, new_photo);
    }

    void adoptCat(string name, int a)
    {
        repo.adopt(name,a);
    }

	void show_html()
	{
		repo.export_data_html();
		repo.show_export_html();
	}

	void show_csv()
	{
		repo.export_data_csv();
		repo.show_export_csv();
	}

    std::vector<Cat> getAllCats() const { return repo.getCats(); }

};
