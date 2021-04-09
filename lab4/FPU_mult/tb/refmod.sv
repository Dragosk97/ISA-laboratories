class refmod extends uvm_component;
    `uvm_component_utils(refmod)
    
    packet_in tr_in;
    packet_out tr_out;
    uvm_get_port #(packet_in) in;
    uvm_put_port #(packet_out) out;
	logic [31:0] var_A;
	logic [31:0] var_B;
    int flag = 0;
    function new(string name = "refmod", uvm_component parent);
        super.new(name, parent);
        in = new("in", this);
        out = new("out", this);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tr_out = packet_out::type_id::create("tr_out", this);
    endfunction: build_phase
    
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        forever begin
			if(flag == 0) begin
				var_A = 0;
				var_B = 0;
				flag = 1;
			end			
			else begin
				var_A = tr_in.A;
				var_B = tr_in.B;
			end			
			in.get(tr_in);
			            
			tr_out.data = $shortrealtobits($bitstoshortreal(var_A) * $bitstoshortreal(var_B)); //multiplier
            $display("REFMOD compute");
            $display("refmod: input A = %g, input B = %g, output OUT = %g",$bitstoshortreal(var_A), $bitstoshortreal(var_B), $bitstoshortreal(tr_out.data));
			$display("refmod: input A = %b, input B = %b, output OUT = %b",var_A, var_B, tr_out.data);
            out.put(tr_out);
        end
    endtask: run_phase
endclass: refmod
