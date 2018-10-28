#pragma once
#include "controller.h"
#include <Exception.h>
#include <cassert>
class Test
{
public:
	Test()
	{
		Repository repo;
		Controller con{ repo }; 

		assert(1 == 1);

	}
	~Test() {};
};
