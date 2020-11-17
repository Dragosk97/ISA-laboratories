vcom -93 -work ./work ../tb/clk_gen.vhd
vcom -93 -work ./work ../tb/data_maker_new.vhd
vcom -93 -work ./work ../tb/data_sink.vhd
vlog -work ./work ../netlist/FIR8_nbit7_TOT.v
vlog -work ./work ../tb/tb_fir.v
vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_fir/UUT=../netlist/FIR8_nbit7_TOT.sdf work.tb_fir
vcd file ../vcd/FIR8_nbit7_TOT_syn.vcd
vcd add /tb_fir/UUT/*
