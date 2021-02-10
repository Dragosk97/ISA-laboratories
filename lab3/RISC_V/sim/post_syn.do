vcom -93 -work ./work ../tb/clk_gen.vhd
vcom -93 -work ./work ../src/instruction_memory.vhd
vcom -93 -work ./work ../src/data_memory.vhd
vlog -work ./work ../netlist/RISCV.v
vlog -work ./work ../tb/tb_riscv.v
vsim -L /software/dk/nangate45/verilog/msim6.2g work.tb_riscv
add wave *
run 1100 ns
