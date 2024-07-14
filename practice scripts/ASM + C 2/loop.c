#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

void loop(char* a, int b)
{
	for(int i = 0; i < b; i++){
		printf("%d. %s\n", i+1, a);
		sleep(1);
	}
}
