# Integrated systems architecture

#### 2020/21

## Lab 2: Digital Aritmetic

Students:
-	Antona Gaspare		275336
-	Barrera Alessandro	275337
-	Liu Huicai		273375

The directories are organized as:
- **./MBE**
    contains:
    - the *.vhd* file of the MBE unit
    - the *.vhd* files and a top-level verilog for the test-bench

- **./MBE_multiplier**
    contains:
    - the Python scripts for the MBE multiplier.
    - the components of the multiplier in *.vhd* 
    - **./matlab**:
        - Matlab script for the generation of the inputs and outputs
        - Matlab script for the bar graph
    - **./tb**:
        - files used for the testbench of the MBE multiplier
    - **./sim**:
        - *results_modelsim.txt* from ModelSim simulation and *output_check.py* to check the correctness of the MBE multiplier
 - **./fpuvhdl**
    - **./common**
        - *.vhd* of some components of the floating point unit
    - **./multiplier**
        - *.vhd* files of the floating point multiplier. In particular, different versions of the stage2 are provided:
            - *fpmul_stage2_struct.vhd*: original stage2 with input registers
            - *fpmul_stage2_struct_optreg.vhd*: additional pipelining stage for re-timing
            - *fpmul_stage2_struct_mbe.vhd*: using MBE multiplier in place of behavioural
            - *fpmul_stage2_mbe_opt.vhd*: using MBE multiplier and additional pipelining stage
    - **./sim**
        - files containing input samples and outputs. Python script to check the results
    - **./syn**
        - *.scr* scripts for Synopsys
        - *report_area_xxx.txt* files containing the area reports of all the version of the fp multiplier
        - *report_timing_xxx.txt* files containing the timing reports of all the version of the fp multiplier
    - **./tb**
        - files used for the testbench of the floating point multiplier
