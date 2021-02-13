vcom -93 -work ./work ../tb/clk_gen.vhd
vlog -work ./work ../netlist/RISCV.v
vlog -work ./work ../tb/tb_riscv.v
vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_riscv/UUT=../netlist/RISCV.sdf work.tb_riscv
vcd file ../vcd/RISCV_syn.vcd
vcd add /tb_riscv/UUT/*
