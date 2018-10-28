#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <time.h>

main(int argc, char* argv[]) {
    int i, n, x;
    for (i = 1; i < argc; i ++) {
        if (fork() == 0) {
			printf("son pid=%d\n parent pid=%d\n", getpid(), getppid());
            n = atoi(argv[i]);
			if(n%2)
				exit(1);
            else
				exit(0);
        }
    }
	printf("parent pid=%d\n", getpid());
	int odds=0, evens=0;
    for (i = 1; i < argc-1; i += 2) {
        wait(&x);
        switch (WEXITSTATUS(x)) {
			if (x)
				odds++;
			else
				evens++;
        }
    }
}
