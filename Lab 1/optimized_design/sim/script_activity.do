vcom -93 -work ./work ../tb/clk_gen.vhd
vcom -93 -work ./work ../tb/data_maker_new.vhd
vcom -93 -work ./work ../tb/data_sink.vhd
vlog -work ./work ../netlist/FIR_opt.v
vlog -work ./work ../tb/tb_fir.v
vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_fir/UUT=../netlist/FIR_opt.sdf work.tb_fir
vcd file ../vcd/FIR_opt.vcd
vcd add /tb_fir/UUT/*
