// ex4.cpp
// 
// Travis Liang, Kyle Yu
// Date: 3/1/2022
// do while loop translation

#include <iostream>

int main()
{
	int a = 0;
	int b = 0;
	do {
		b += a;
		a++;
	} while (a < 10);
	return 0;
}