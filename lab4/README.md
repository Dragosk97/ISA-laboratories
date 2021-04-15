# Integrated systems architecture

#### 2020/21

## Lab 4: multiplier verification with UVM

Students:
-	Antona Gaspare		275336
-	Barrera Alessandro	275337
-	Liu Huicai		273375

The directories are organized as:
- **./adder**: it contains the testing of a simple adder

- **./adder_64bit**: modification of the wordlength

- **./adder_constraints**: constraints applied to the inputs
   
- **./adder_mismatch**: the refmod is changed in order to see the mismatches
   
- **./MBE_dadda**
   
- **./FPU_mult**: 
   - _DUT_generic.sv_ and _refmod_generic.sv_ are referring to the first version of testbench
   - _DUT.sv_ and _refmod.sv_ are for the second version
All the folders are internally organized as: 
- **./sim**: it contains the result of the simulation on QuestaSim, which is the transcript file
- **./src**: it contains the DUT
- **./tb**: it contains the UVM framework
   
   
   
   
   
   
   
   
   
   
