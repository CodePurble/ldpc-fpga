#include <stdio.h>
#include <stdlib.h>

void swap_rows(int s_rows, int s_cols, int r1, int r2, int *arr);
void swap_cols(int s_rows, int s_cols, int c1, int c2, int *arr);
void print_mat(int rows, int cols, int *mat);
void read_mat(const char* fname, int r, int c, int *dest);

int main()
{
    const int N = 11;
    const int K = 6;
    int *h_mat = calloc((N-K)*N, sizeof(int));
    read_mat("h2.txt", N-K, N, h_mat);
    return 0;
}

void read_mat(const char* fname, int r, int c, int *dest)
{
    FILE *fp = fopen(fname, "r");
    char ch;
    int i = 0;
    int j = 0;
    while((ch = getc(fp)) != EOF) {
        if(ch != '\n') {
            dest[i*c + j] = ch - '0';
            j++;
        }
        else {
            j = 0;
            i++;
        }
    }
}

void print_mat(int rows, int cols, int *mat)
{
    for(int i = 0; i < rows; i++) {
        for(int j = 0; j < cols; j++) {
            printf("%2d", mat[i*cols + j]);
        }
        printf("\n");
    }
    printf("\n");
}
void swap_rows(int s_rows, int s_cols, int r1, int r2, int *arr)
{
    if(r1 > s_rows || r2 > s_rows) {
        return;
    }
    int temp;
    for(int i = 0; i < s_cols; i++) {
        temp = arr[r1*s_cols + i];
        arr[r1*s_cols + i] = arr[r2*s_cols + i];
        arr[r2*s_cols + i] = temp;
    }
}

void swap_cols(int s_rows, int s_cols, int c1, int c2, int *arr)
{
    if(c1 > s_cols || c2 > s_cols) {
        return;
    }
    int temp;
    for(int i = 0; i < s_rows; i++) {
        temp = arr[i*s_cols + c1];
        arr[i*s_cols + c1] = arr[i*s_cols + c2];
        arr[i*s_cols + c2] = temp;
    }
}
