vcom -93 -work ./work ../tb/clk_gen.vhd
vcom -93 -work ./work ../src/instruction_memory.vhd
vcom -93 -work ./work ../src/data_memory.vhd
vlog -work ./work ../netlist/RISCV_abs.v
vlog -work ./work ../tb/tb_riscv.v
vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_riscv/UUT=../netlist/RISCV_abs.sdf work.tb_riscv
vcd file ../vcd/RISCV_abs_syn.vcd
vcd add /tb_riscv/UUT/*
