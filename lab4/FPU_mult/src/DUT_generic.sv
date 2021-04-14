module DUT(dut_if.port_in in_inter, dut_if.port_out out_inter, output enum logic [1:0] {INITIAL,WAIT, PIPEFILL,SEND} state);
    
    FPmul fpmul_under_test(.FP_A(in_inter.A),.FP_B(in_inter.B),.clk(in_inter.clk),.FP_Z(out_inter.data)); //module
	
	logic [31:0] A_pipe;
	logic [31:0] B_pipe;
    integer cnt = 0;

    // Edit the number of pipeline stages
    integer num_pipe = 5;


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
                    in_inter.ready <= 1;
                    state <= WAIT;
                end

                WAIT: begin
					if(in_inter.valid) begin
                        in_inter.ready <= 0;
                    	out_inter.valid <= 0;
						A_pipe = in_inter.A;
						B_pipe = in_inter.B;
                    	state <= PIPEFILL;
					end
                end
                
                PIPEFILL: begin
                    if (cnt < num_pipe - 2) begin
                        state <= PIPEFILL;
                        out_inter.valid <= 0;
                        cnt += 1;
                    end else begin
                        out_inter.valid <= 1;
                        state <= SEND;
                        cnt = 0;
                    end
                end

                SEND: begin
					$display("FP_mult: SEND");
					$display("FP_mult: input A = %g, input B = %g, output OUT = %g",$bitstoshortreal(A_pipe),$bitstoshortreal(B_pipe),$bitstoshortreal(out_inter.data));
                    $display("FP_mult: input A = %b, input B = %b, output OUT = %b",A_pipe,B_pipe,out_inter.data);
					
					if(out_inter.ready) begin
                        out_inter.valid <= 0;
                        in_inter.ready <= 1;				
                        state <= WAIT; 
                    end
                end
        endcase
    end
endmodule: DUT
