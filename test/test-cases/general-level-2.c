#define THREE 92

int count = 0;
while (count % 3 == 2) {
	// this part does the thing
	
	int i;
	for (i=0; i<5; i++) {
		count = foo(count);
	}
}

printf("done");

