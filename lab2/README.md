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
    - the *.vhd* files of the MBE unit
    - the *.vhd* files and a top-level verilog for the test-bench

- **./MBE_multiplier**
    contains:
    - python scripts for the MBE multiplier. Components of the multiplier in *.vhd* 
    - **./matlab**:
        - Matlab script for the generation of the inputs and outputs
        - Matlab script for the graphic
    - **./tb**:
        - files used for the testbench of the MBE multiplier
    - **./sim**:
        - *results_modelsim.txt* from ModelSim simulation and *output_check.py* to check the correctness of the MBE multiplier
 - **./fpuvhdl**
    - **./common**
        - *.vhd* of some components of the floating point multiplier
    - **./multiplier**
        - *.vhd* files of the floating point multiplier
    - **./sim**
        - files containing input samples and outputs. Python script to check the results
    - **./syn**
        - *.scr* scripts for Synopsys
        - *report_area_xxx.txt* files containing the area reports of all the version of the fp multiplier
        - *report_timing_xxx.txt* files containing the timing reports of all the version of the fp multiplier
    - **./tb**
        - files used for the testbench of the floating point multiplier