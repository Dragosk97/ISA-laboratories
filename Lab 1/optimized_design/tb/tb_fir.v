//`timescale 1ns

module tb_fir ();

   wire CLK_i;
   wire RST_n_i;
   wire [7:0] DIN1_i; 
   wire [7:0] DIN2_i;
   wire [7:0] DIN3_i;
   wire VIN_i;
   wire [7:0] H0_i;
   wire [7:0] H1_i;
   wire [7:0] H2_i;
   wire [7:0] H3_i;
   wire [7:0] H4_i;
   wire [7:0] H5_i;
   wire [7:0] H6_i;
   wire [7:0] H7_i;
   wire [7:0] H8_i;
   wire [7:0] DOUT1_i;
   wire [7:0] DOUT2_i;
   wire [7:0] DOUT3_i;
   wire VOUT_i;
   wire END_SIM_i;

   clk_gen CG(.END_SIM(END_SIM_i),
  	      .CLK(CLK_i),
	      .RST_n(RST_n_i));

   data_maker SM(.CLK(CLK_i),
	         .RST_n(RST_n_i),
		 .VOUT(VIN_i),
		 .DOUT1(DIN1_i),
		 .DOUT2(DIN2_i),
		 .DOUT3(DIN3_i),
		 .H0(H0_i),
		 .H1(H1_i),
		 .H2(H2_i),
		 .H3(H3_i),
		 .H4(H4_i),
		 .H5(H5_i),
		 .H6(H6_i),
		 .H7(H7_i),
		 .H8(H8_i),
		 .END_SIM(END_SIM_i));

   FIR_opt UUT(.clk(CLK_i),
	     .rst_n(RST_n_i),
	     .DIN1(DIN1_i),
	     .DIN2(DIN2_i),
	     .DIN3(DIN3_i),
             .VIN(VIN_i),
	     .b0(H0_i),
	     .b1(H1_i),
	     .b2(H2_i),
	     .b3(H3_i),
	     .b4(H4_i),
	     .b5(H5_i),
	     .b6(H6_i),
	     .b7(H7_i),
	     .b8(H8_i),
             .DOUT1(DOUT1_i),
	     .DOUT2(DOUT2_i),
             .DOUT3(DOUT3_i),
             .VOUT(VOUT_i));

   data_sink DS(.CLK(CLK_i),
		.RST_n(RST_n_i),
		.VIN(VOUT_i),
		.DIN1(DOUT1_i),
		.DIN2(DOUT2_i),
		.DIN3(DOUT3_i));   

endmodule

		   
