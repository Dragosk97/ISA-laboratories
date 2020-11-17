# Integrated systems architecture

#### 2020/21

## Lab 1: Digital Filter

Students:
-	Antona Gaspare		275336
-	Barrera Alessandro	275337
-	Liu Huicai		273375

Two architectures are presented as required in the assignment.
The directory **./first_fir** contains the first design, while the directory
**./optimized_design** contains the advanced architecture. Each of these
directories contains the following:

- **./src**
	contains the VHDL source code of the design
- **./tb**
	contains the test-bench code
- **./sim**
	simulation directory: contains the scripts for both the back-annotations,
	the results of the simulations, the reference output file of the C model
	and the Python script *output_check.py*.
- **./syn**
	synthesis directory: contains the following files:
	- *script.scr*:		Synopsys' script which runs the synthesis

	- *elaborate.txt*:		elaborate report of the last synthesis

	- *report_timing_p0.txt*:	timing report of the synthesis with clock period
				constraint to 0 ns
	- *report_timing_f1.txt*:	timing report of the first attempt to find the
				maximum frequency
	- *report_timing_fmax.txt*:	timing report of the synthesis with the maximum
				frequency obtained.
	- *report_area_fmax.txt*:	area report of the synthesis with the maximum
				frequency obtained.
	- *report_power_f_4.txt*:	back-annotated power report
- **./nelist**
	contains the post synthesis netlist file *FIR8_nbit7_TOT.v*, *FIR8_nbit7_TOT.sdf*
	and *FIR8_nbit7_TOT.sdc*
- **./matlab**
	contains the test input file *samples.txt*
- **./innovus**
	place and route directory: contains some of the Innovus' working files.
	In particular, the file *report_power_post_route.txt* is the post place and
	route back-annotated power report.