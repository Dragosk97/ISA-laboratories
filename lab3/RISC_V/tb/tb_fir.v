//`timescale 1ns

module tb_fir ();

   wire CLK_i;
   wire RST_n_i;
   wire [31:0] start_address_i;
   wire [31:0] DIN_i;
   wire VIN_i;
   wire END_SIM_i;

   clk_gen CG(.END_SIM(END_SIM_i),
  	      .CLK(CLK_i),
	      .RST_n(RST_n_i)
		  .start_address(start_address_i));

/*
   FIR8_nbit7_TOT UUT(.clk(CLK_i),
	     .rst_n(RST_n_i),
	     .DIN(DIN_i),
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
         .DOUT(DOUT_i),
        .VOUT(VOUT_i));
*/

   data_sink DS(.CLK(CLK_i),
		.RST_n(RST_n_i),
		.VIN(VOUT_i),
		.DIN(DOUT_i));   

endmodule

		   
