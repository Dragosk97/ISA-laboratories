vcom -reportprogress 30 -work work ../src/fpuvhdl/common/fpnormalize_fpnormalize.vhd
vcom -reportprogress 30 -work work ../src/fpuvhdl/common/packfp_packfp.vhd
vcom -reportprogress 30 -work work ../src/fpuvhdl/common/fpround_fpround.vhd
vcom -reportprogress 30 -work work ../src/fpuvhdl/common/unpackfp_unpackfp.vhd
vcom -reportprogress 30 -work work ../src/fpuvhdl/multiplier/fpmul_stage1_struct.vhd
vcom -reportprogress 30 -work work ../src/fpuvhdl/multiplier/fpmul_stage2_struct_mbe.vhd
vcom -reportprogress 30 -work work ../src/fpuvhdl/multiplier/fpmul_stage3_struct.vhd
vcom -reportprogress 30 -work work ../src/fpuvhdl/multiplier/fpmul_stage4_struct.vhd
vcom -reportprogress 30 -work work ../src/fpuvhdl/multiplier/fpmul_pipeline.vhd
vcom -reportprogress 30 -work work ../src/HA.vhd
vcom -reportprogress 30 -work work ../src/FA.vhd
vcom -reportprogress 30 -work work ../src/MBE.vhd
vcom -reportprogress 30 -work work ../src/MBE_mult.vhd

vlog -sv ../tb/top.sv
vsim top
run 4 us
