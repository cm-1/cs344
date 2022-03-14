#include <stdio.h>
#include <limits>

#define NUM_THREADS 1000000
#define ARRAY_SIZE  200000
#define ARRAY_SIZE_TEST 1000000

#define BLOCK_WIDTH 1000

int main(int argc,char **argv)
{   
    printf("Starting program!\n");
    size_t free, total;
    // printf("\n");
    // cudaMemGetInfo(&free,&total);   
    // printf("%zd B free of total %zd B\n",free,total);

    const int ARRAY_BYTES_TEST = ARRAY_SIZE_TEST * sizeof(int);
    int* h_array_test = new int[ARRAY_SIZE_TEST];
    for (int i = 0; i < ARRAY_SIZE_TEST; i++) {
        h_array_test[i] = i;
    }

    printf("Test. Array size: %d.\n", ARRAY_BYTES_TEST);

    for (int i = ARRAY_SIZE_TEST - 10; i < ARRAY_SIZE_TEST; i++) {
        printf("Test. Element mod: %d.\n", (h_array_test[i] % ARRAY_SIZE_TEST));
    }

    delete[] h_array_test;



    return 0;

}