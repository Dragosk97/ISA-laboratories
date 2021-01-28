//`timescale 1ns

module tb_riscv ();

   wire CLK_i;
   wire RST_i;
   wire [31:0] start_address_i;
   wire [31:0] data_mem_in_i;
   wire [31:0] data_mem_out_i;
   wire [31:0] address_mem_out_i;
   wire MemRead_i;
   wire MemLoad_i;
   wire [31:0] instruction_in_i;
   wire [31:0] instruction_address_i;

   clk_gen CG(.CLK(CLK_i),
	      .RST_n(RST_n_i)
		  .start_address(start_address_i));

   RISCV UUT(.clk(CLK_i),
	     .rst_n(RST_i),
		 .start_address(start_address_i),
		 .data_mem_in(data_mem_in_i),
		 .data_mem_out(data_mem_out_i),
		 .address_mem_out(address_mem_out_i),
		 .MemRead(MemRead_i),
		 .MemLoad(MemLoad_i),
		 .instruction_in(instruction_in_i),
		 .instruction_address(instruction_address_i));
      
   data_memory DM( .address(.address_mem_out_i),
                   .data(data_mem_out_i),
                   .MemWrite(MemLoad_i),
                   .MemRead(MemRead_i),
                   .clock(CLK_i),
                   .cs('1'),
                   .rst(RST_i),
                   .Qout(data_mem_in_i));


   instruction_memory IM( .address(.instruction_address_i),
                          .data(.instruction_in_i));

endmodule

		   
