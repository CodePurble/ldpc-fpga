#include <stdio.h>
#include <stdlib.h>

void swap_rows(int s_rows, int s_cols, int r1, int r2, int *arr);
void swap_cols(int s_rows, int s_cols, int c1, int c2, int *arr);
void print_mat(int rows, int cols, int *mat);
void read_mat(const char* fname, int r, int c, int *dest);
int* get_cols_with_ones(int rows, int cols, int *mat, int wr);

int main()
{
    const int n = 11;
    const int k = 6;
    const int m = n - k;
    const int wc = 2;
    const int wr = 3;
    int *h_mat = calloc(m*n, sizeof(int));
    read_mat("h2.txt", m, n, h_mat);
    int *cols_with_ones = get_cols_with_ones(m, n, h_mat, wr);
    for(int i = 0; i < m; i++) {
        for(int j = 0; j < wr; j++) {
            if(cols_with_ones[i*wr + j]) {
            }
        }
    }


    free(cols_with_ones);
    free(h_mat);
    return 0;
}

int* get_cols_with_ones(int rows, int cols, int *mat, int wr)
{
    int *cols_with_ones = calloc(rows*wr, sizeof(int));
    int ind;
    for(int i = 0; i < rows; i++) {
        ind = 0;
        for(int j = 0; j < cols; j++) {
            if(mat[i*cols + j] == 1) {
                cols_with_ones[i*wr + ind] = j;
                ind++;
            }
        }
    }
    return cols_with_ones;
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
            printf("%3d", mat[i*cols + j]);
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
