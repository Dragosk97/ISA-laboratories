vcom -reportprogress 30 -work work ../src/HA.vhd
vcom -reportprogress 30 -work work ../src/FA.vhd
vcom -reportprogress 30 -work work ../src/MBE.vhd
vcom -reportprogress 30 -work work ../src/MBE_mult.vhd

vlog -sv ../tb/top.sv
vsim top
run 4 us
