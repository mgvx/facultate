#pragma once
#include "repository.h"
#include "exception.h"

class Controller
{

private:
	Repository &repo;

public:
	Controller(Repository &r) : repo(r) {};
	~Controller() {};

	void addObject(Object x)
	{
		repo.add(x);
	}

	void remObject(Object x)
	{
		repo.rem(x);
	}

	std::vector<Object> getAll() 
	{ 
		return repo.getAll(); 
	}
};