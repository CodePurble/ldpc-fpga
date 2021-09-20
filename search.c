#include <stdio.h>
#include <stdlib.h>

void swap_rows(int s_rows, int s_cols, int r1, int r2, int **arr);
void swap_cols(int s_rows, int s_cols, int c1, int c2, int **arr);

int main()
{
    const int N = 11;
    const int K = 6;
    int h_mat[N-K][N] = {
        {0,1,0,0,1,0,0,0,0,1,0},
        {0,0,0,1,1,1,0,1,0,0,0},
        {1,1,1,0,0,0,1,0,0,0,0},
        {0,0,1,0,0,1,0,0,0,0,1},
        {1,0,0,1,0,0,0,0,1,0,0},
    };
    for(int i = 0; i < N-K; i++) {
    }
    return 0;
}

int in_arr(int target, int **arr);

void swap_rows(int s_rows, int s_cols, int r1, int r2, int **arr)
{
    if(r1 > s_rows || r2 > s_rows) {
        return;
    }
    int temp;
    for(int i = 0; i < s_cols; i++) {
        temp = arr[r1][i];
        arr[r1][i] = arr[r2][i];
        arr[r2][i] = temp;
    }
}

void swap_cols(int s_rows, int s_cols, int c1, int c2, int **arr)
{
    if(c1 > s_cols || c2 > s_cols) {
        return;
    }
    int temp;
    for(int i = 0; i < s_rows; i++) {
        temp = arr[i][c1];
        arr[i][c1] = arr[i][c2];
        arr[i][c2] = temp;
    }
}
