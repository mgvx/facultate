#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>

// COMPILE WITH -lpthread !!!
pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
int counter;

struct data
{
	int id;
	int x;
	int y;
};

void *fun (void *arr)
{
	struct data *d;
	d = (struct data *) arr;
	
	pthread_mutex_lock (&mutex);
	for (int i=0; i<1000; i++) {
	  counter++;
	}
	printf ("thread: %d counter: %d\n", pthread_self (), counter);
	pthread_mutex_unlock (&mutex);
	
	pthread_exit ((void*)(d->id)); // pthread_exit (NULL);
}

int main (int argc, char *argv[])
{
	pthread_t threads[n];
	struct data a[n]
	int rc, t, x, y;

	srand(time(NULL));
	for (t = 1; t < n+1; t++)
	{
		a[t].thread_id = t;
		a[t].x = rand()%100;
		a[t].y = rand()%100;
		
		int rc = pthread_create (&threads[t], NULL, fun, (void *) &a[t]);
		if (rc) {
			printf ("ERROR: %d\n", rc)
			exit (-1);
		}
	}
	void *th;
	for (t = 1; t < NUM_TH; t++)
    {
		rc = pthread_join (thread[t], &th); // rc = pthread_join (thread[t], NULL);
		if (rc) {
			printf ("ERROR: %d\n", rc);
			exit (-1);
		}
		printf("Main process joined thread %ld\n", th);
    }
	pthread_exit (NULL);
}
