module DUT(dut_if.port_in in_inter, dut_if.port_out out_inter, output enum logic [2:0] {INITIAL,WAIT_PIPEFILL,EXECUTE,WAIT,SEND} state);
    
    FPmul fpmul_under_test(.FP_A(in_inter.A),.FP_B(in_inter.B),.clk(in_inter.clk),.FP_Z(out_inter.data)); //module
	
	integer cnt;

    always_ff @(posedge in_inter.clk)
    begin
        if(in_inter.rst) begin
            in_inter.ready <= 0;
            out_inter.data <= 'x;
            out_inter.valid <= 0;
			cnt = 0;
            state <= INITIAL;
        end
        else case(state)
                INITIAL: begin
                    in_inter.ready <= 1;
					cnt = 0;
                    state <= WAIT_PIPEFILL;
                end

                WAIT_PIPEFILL: begin
					$display("FPU_mult: WAIT_PIPEFILL");
					if(in_inter.valid) begin
                        in_inter.ready <= 0;
                    	out_inter.valid <= 0;
                    	//if (cnt==1) begin
                    	    state <= WAIT;
                    	//end
                    	//else begin
                        	//state <= WAIT_PIPEFILL;
                        	//cnt++;
                    	//end
					end
                end
				
				EXECUTE: begin
					$display("FPU_mult: EXECUTE");
					in_inter.ready <= 0;
		            out_inter.valid <= 0;
					state <= WAIT;
				end
	
                WAIT: begin
						$display("FPU_mult: WAIT");
                        $display("dadda_mult: input A = %g, input B = %g, output OUT = %g",$bitstoshortreal(in_inter.A),$bitstoshortreal(in_inter.B),$bitstoshortreal(out_inter.data));
                        $display("dadda_mult: input A = %b, input B = %b, output OUT = %b",in_inter.A,in_inter.B,out_inter.data);
                        out_inter.valid <= 1;
                        state <= SEND;
                    end

                SEND: begin
					$display("FPU_mult: SEND");
                    if(out_inter.ready) begin
                        out_inter.valid <= 0;
                        in_inter.ready <= 1;				
                        cnt=0;
                        state <= WAIT_PIPEFILL; 
                    end
                end
        endcase
    end
endmodule: DUT
