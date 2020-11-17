#include<stdio.h>
#include<stdlib.h>

#define NT 9 /// number of coeffs. Notice, the filter order is NT-1
#define NB 7 /// number of internal representation bits

// Input 8-bit coefficients
const int b8[NT]={-1, -1, 3, 17, 25, 17, 3, -1, -1};

/// Perform fixed point filtering assuming direct form I
///\param x is the 8-bit new input sample
///\return the new output sample
int myfilter(int x)
{
  /*
    This function models the behaviour of the FIR filter of order 8,
    with 8-bit interface, internally reduced to a 7-bit representation.
  */

  static int sx[NT]; /// x shift register
  static int first_run = 0; /// for cleaning shift registers and sample coefficients
  int i; /// index
  int y; /// output sample
  static int b[NT-1]; // coefficient registers


  /// clean the buffers and sample the coefficients
  if (first_run == 0)
  {
    first_run = 1;
    for (i=0; i<NT; i++){
      sx[i] = 0;
      b[i] = b8[i] >> 1;
    }
  }

  /// shift and insert new sample in x shift register
  for (i=NT-1; i>0; i--)
    sx[i] = sx[i-1];
  sx[0] = x >> 1;

  /// make the convolution
  y = 0;
  for (i=0; i<NT; i++)
    y += (sx[i]*b[i]) >> (NB-1) ;

  return y<<1;
}

int main (int argc, char **argv)
{
  FILE *fp_in;
  FILE *fp_out;

  int x;
  int y;

  /// check the command line
  if (argc != 3)
  {
    printf("Use: %s <input_file> <output_file>\n", argv[0]);
    exit(1);
  }

  /// open files
  fp_in = fopen(argv[1], "r");
  if (fp_in == NULL)
  {
    printf("Error: cannot open %s\n");
    exit(2);
  }
  fp_out = fopen(argv[2], "w");

  /// get samples and apply filter
  fscanf(fp_in, "%d", &x);
  do{
    y = myfilter(x);
    fprintf(fp_out,"%d\n", y);
    fscanf(fp_in, "%d", &x);
  } while (!feof(fp_in));

  fclose(fp_in);
  fclose(fp_out);

  return 0;

}
