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
 
- All the folders are internally organized as: 
    - **./sim**: it contains the result of the simulation on QuestaSim, which is the transcript file
    - **./src**: it contains the DUT
    - **./tb**: it contains the UVM framework   

- **./FPU_mult**: 
    here two versions of the following files are provided, where _\<file\>_generic.\<ext\>_
    is relative to the generic DUT pipeline length, while the _\<file\>.\<ext\>_ is the version
    relative to the specific DUT, analyzing two data at the same time.
   - **./sim**: 
        - _run_sim_generic.do_
        - _run_sim.do_
        - _transcript_generic_
        - _transcript_
    - **./src**: 
        - _DUT_generic.sv_
        - _DUT.sv_
    - **./tb**:
        - _refmod_generic.sv_ 
        - _refmod.sv_
        - _top_generic.sv_
        - _top.sv_