#include <stdio.h>

/*
 * I can make if with C language macro but it doesn't look like C statement.
 * It is not extending of C language.
 */
#define MY_IF(condition, ...) \
	if (condition) { __VA_ARGS__ }

int main(void)
{
	MY_IF(3 > 1, printf("of "); printf("course\n");)
		
	return 0;
}

#if 0
// The result of "gcc -E macro_test.c"
int main(void)
{
 if (3 > 1) { printf("of "); printf("course\n"); }

 return 0;
}			
#endif
