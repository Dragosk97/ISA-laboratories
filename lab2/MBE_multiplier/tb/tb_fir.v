//`timescale 1ns

module tb_fir ();

   wire CLK_i;
   wire RST_n_i;
   wire [23:0] a_i;
   wire [23:0] b_i;
   wire [47:0] p_i;
   wire END_SIM_i;

   clk_gen CG(.END_SIM(END_SIM_i),
  	      .CLK(CLK_i),
	      .RST_n(RST_n_i));

   data_maker SM(.CLK(CLK_i),
	         	.RST_n(RST_n_i),
				.a(a_i),
				.b(b_i),
		 	 	.END_SIM(END_SIM_i));

   MBE_mult UUT(.a(a_i)
				.b(b_i)
				.p(p_i)); 		

   data_sink DS(.CLK(CLK_i),
		.RST_n(RST_n_i),
		.p(p_i));   

endmodule

		   
