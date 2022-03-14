#include <stdio.h>
#include "gputimer.h"
//#include <limits>

#define NUM_THREADS 1000000
#define ARRAY_SIZE  100

#define BLOCK_WIDTH 1000

void print_array(int *array, int size)
{
    printf("{ ");
    for (int i = 0; i < size; i++)  { printf("%d ", array[i]); }
    printf("}\n");
}

__global__ void increment_naive(int *g)
{
	// which thread is this?
	int i = blockIdx.x * blockDim.x + threadIdx.x; 

	// each thread to increment consecutive elements, wrapping at ARRAY_SIZE
	i = i % ARRAY_SIZE;  
	g[i] = g[i] + 1;
}

__global__ void increment_atomic(int *g)
{
	// which thread is this?
	int i = blockIdx.x * blockDim.x + threadIdx.x; 

	// each thread to increment consecutive elements, wrapping at ARRAY_SIZE
	i = i % ARRAY_SIZE;  
	atomicAdd(& g[i], 1);
}

int main(int argc,char **argv)
{   
    // Some stuff I used to try and figure out why it wasn't running for
    // an array of 1,000,000 elements before I realized it was caused by
    // the default stack size max of 1MB on Windows.
    printf("Starting program!\n");
    printf("Checking CUDA memory availability:");
    size_t free, total;
    printf("\n");
    cudaMemGetInfo(&free,&total);   
    printf("%zd B free of total %zd B\n",free,total);


    GpuTimer timer;
    printf("%d total threads in %d blocks writing into %d array elements\n",
           NUM_THREADS, NUM_THREADS / BLOCK_WIDTH, ARRAY_SIZE);

    // declare and allocate host memory
    int* h_array = new int[ARRAY_SIZE];
    const int ARRAY_BYTES = ARRAY_SIZE * sizeof(int);
 
    // declare, allocate, and zero out GPU memory
    int * d_array;
    cudaMalloc((void **) &d_array, ARRAY_BYTES);
    cudaMemset((void *) d_array, 0, ARRAY_BYTES); 

    // launch the kernel - comment out one of these
    timer.Start();
    // increment_naive<<<NUM_THREADS/BLOCK_WIDTH, BLOCK_WIDTH>>>(d_array);
    increment_atomic<<<NUM_THREADS/BLOCK_WIDTH, BLOCK_WIDTH>>>(d_array);
    timer.Stop();
    
    // copy back the array of sums from GPU and print
    cudaMemcpy(h_array, d_array, ARRAY_BYTES, cudaMemcpyDeviceToHost);
    print_array(h_array, ARRAY_SIZE);
    printf("Time elapsed = %g ms\n", timer.Elapsed());
 
    // free GPU memory allocation and exit
    cudaFree(d_array);
    delete[] h_array;

    return 0;
}