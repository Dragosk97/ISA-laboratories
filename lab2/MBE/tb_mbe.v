//`timescale 1ns

module tb_mbe ();

   wire CLK_i;
   wire RST_n_i;
   wire [23:0] A_i;
   wire [24:0] DOUT_i;
   wire [2:0] B_i;

   clk_gen CG(.CLK(CLK_i),
	      .RST_n(RST_n_i));

   mbe_n #(
      .nbit(24)
      )   
      UUT(
	      .a(A_i),
         .b0(B_i[0]),
         .b1(B_i[1]),
         .b2(B_i[2]),
         .pp(DOUT_i)
   ); 

   Counter_nbit #(
      .n(3)
      )
      cnt_3bit (
         .EN(RST_n_i),
			.RST_n(RST_n_i),
			.CLK(CLK_i),
			.Q(B_i)
	);

endmodule

		   
