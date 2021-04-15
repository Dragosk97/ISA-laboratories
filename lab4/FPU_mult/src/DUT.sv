module DUT(dut_if.port_in in_inter, dut_if.port_out out_inter, output enum logic [1:0] {INITIAL,PIPEFILL,WAIT,SEND} state);
    
    FPmul fpmul_under_test(.FP_A(in_inter.A),.FP_B(in_inter.B),.clk(in_inter.clk),.FP_Z(out_inter.data)); //module
	
	logic [31:0] A_pipe;
	logic [31:0] B_pipe;

    always_ff @(posedge in_inter.clk)
    begin
        if(in_inter.rst) begin
            in_inter.ready <= 0;
            out_inter.data <= 'x;
            out_inter.valid <= 0;
			A_pipe <= 0;
			B_pipe <= 0;
            state <= INITIAL;
        end
        else case(state)
                INITIAL: begin
					A_pipe <= in_inter.A;
					B_pipe <= in_inter.B;
                    in_inter.ready <= 1;
                    state <= WAIT;
                end

                WAIT: begin
					$display("FP_mult: WAIT");
                    $display("-- input A: %b, input B: %b; output Z: %b", in_inter.A, in_inter.B, out_inter.data);
					if(in_inter.valid) begin
                        in_inter.ready <= 0;
                    	out_inter.valid <= 0;
                    	state <= PIPEFILL;
					end
                end
	
                PIPEFILL: begin
						$display("FP_mult: PIPEFILL");
                        $display("-- input A: %b, input B: %b; output Z: %b", in_inter.A, in_inter.B, out_inter.data);
                        out_inter.valid <= 1;
                        state <= SEND;
                    end

                SEND: begin
					$display("FP_mult: SEND");
                    $display("-- input A: %b, input B: %b; output Z: %b", in_inter.A, in_inter.B, out_inter.data);
					$display("FP_mult: input A = %g, input B = %g, output OUT = %g",$bitstoshortreal(A_pipe),$bitstoshortreal(B_pipe),$bitstoshortreal(out_inter.data));
                    $display("FP_mult: input A = %b, input B = %b, output OUT = %b",A_pipe,B_pipe,out_inter.data);
					A_pipe <= in_inter.A;
					B_pipe <= in_inter.B;
                    if(out_inter.ready) begin
                        out_inter.valid <= 0;
                        in_inter.ready <= 1;				
                        state <= WAIT; 
                    end
                end
        endcase
    end
endmodule: DUT
