# This module produces the VHDL file "MBE_mult.vhd", which describes a multiplier
# based on the Dadda tree. In particular, this module composes the netlist of the
# full adders, the half adders and the unprocessed bits propagation. In order to
# achieve this, the string "netlist_str" is exploited, concatenating the new
# elements through the use of the functions FA_gen(), HA_gen() and unproc_prop()
# defined in the module "generate_lib.py".

# The list of lists "row_num" is used in such a way that the value row_num[x][y]
# represents the number of rows in the matrix of dots with:
#     x: reduction stage
#     y: weight of the bits
# The list "row_target" represents the number of rows expected per stage according 
# to the Dadda algorithm. Through these two data structures it is possible to
# compute the needed number of full adders and half adders. It is worth noticing
# that also the information about the carry of the precedent weight are taken into
# account. 


from generate_lib import FA_gen, HA_gen, unproc_prop, vhdl_composer

# variables initialization

netlist_str = ""

# row_num[0] is initializated according to the starting matrix of the Dadda
# reduction. 
row_num = [[2,1,3,2,4,3,5,4,6,5,7,6,8,7,9,8,10,9,11,10,12,11,13,12,13,13,13,13,12,11,11,10,10,9,9,8,8,7,7,6,6,5,5,4,4,3,3,2]]

row_target = [13, 9, 6, 4, 3, 2]


for stage in range(5):

    # Each time a new stage starts to be elaborated, the "num_carry" variable,
    # which takes into account the carry from the previous weight, has to be set
    # to 0. Also the "next_stage" list is initialized.  
    num_carry = 0
    next_stage = []

    for col in range(48):
        
        # In order to apply the Dadda reduction, it is needed to verify whether
        # in the following stage the number of rows would exceed the expected
        # one, considering the carry-bits from the reduction of the bits of the
        # precedent weight. In this case, the reduction has to be applied.
        diff = row_num[stage][col] + num_carry - row_target[stage+1]
        if diff <= 0:
            # No reduction needed: every bit is propagated
            next_stage.append(row_num[stage][col] + num_carry)
            netlist_str = unproc_prop(netlist_str, row_num[stage][col], 0, 0, num_carry, stage, col)
            num_carry = 0

        else:
            # Reduction needed
            # Each full adder takes 3 bits as input and generates 1 sum bit with
            # the same weight, meaning a total reduction of 2 rows. Similarly,
            # an half adder provides a reduction of 1 row. To remove "diff" bits
            # from the current column, as much as diff//2 full adders needs to
            # be instantiated. The remaing bits are reduced using half adders. 
            num_FA = diff // 2
            num_HA = diff % 2

            # The number of unprocessed bits is stored in "num_unproc"
            num_unproc = row_num[stage][col] - 3*num_FA - 2*num_HA

            # Netlist composition
            netlist_str = FA_gen(netlist_str, num_FA, num_carry, stage, col)
            netlist_str = HA_gen(netlist_str, num_HA, num_FA, num_carry, stage, col)
            netlist_str = unproc_prop(netlist_str, num_unproc, num_FA, num_HA, num_carry, stage, col)

            # The computed column is added to the next stage
            next_stage.append(row_num[stage][col] - 2*num_FA - num_HA + num_carry)

            # num_carry is updated with the new number of carry-bits
            num_carry = num_FA + num_HA

    # The next stage list of number of rows is added
    row_num.append(next_stage)

# The netlist string composed is inserted in the template file 
vhdl_composer(netlist_str, "MBE_mult.vhd")