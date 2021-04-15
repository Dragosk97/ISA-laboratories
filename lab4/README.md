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
 
All the folders are internally organized as: 
   - **./sim**: it contains the result of the simulation on QuestaSim, which is the transcript file
   - **./src**: it contains the DUT
   - **./tb**: it contains the UVM framework   

- **./FPU_mult**: 
   - **./sim**: it contains the script to be run and the result of the simulation on QuestaSim, which is the transcript file
   - **./src**: 
         - _DUT_generic.sv_: device under test of the first version
         - _DUT.sv_: device under test of the second version
   - **./tb**:
         - _refmod_generic.sv_: this file is referring to the first version 
         - _refmod.sv_: this refers to the second case     


   
   
   
   
   
   
   
   
   
   
