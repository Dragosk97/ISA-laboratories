from generate_lib import FA_gen, HA_gen, unproc_prop

netlist_str = ""

row_num = [[2,1,3,2,4,3,5,4,6,5,7,6,8,7,9,8,10,9,11,10,12,11,13,12,13,13,13,13,12,11,11,10,10,9,9,6,6,7,7,6,6,5,5,4,4,3,3,2]]

row_target = [13, 9, 6, 4, 3, 2]


for stage in range(5):

    num_carry = 0
    next_stage = []

    for col in range(48):
        
        diff = row_num[stage][col] + num_carry - row_target[stage+1]
        if diff <= 0:
            next_stage.append(row_num[stage][col])
            num_carry = 0
            netlist_str = unproc_prop(netlist_str, row_num[stage][col], 0, 0, num_carry, stage, col)

        else:
            num_FA = diff // 2
            num_HA = diff % 2
            num_unproc = row_num[stage][col] - 3*num_FA - 2*num_HA

            netlist_str = FA_gen(netlist_str, num_FA, num_carry, stage, col)
            netlist_str = HA_gen(netlist_str, num_HA, num_FA, num_carry, stage, col)
            netlist_str = unproc_prop(netlist_str, num_unproc, num_FA, num_HA, num_carry, stage, col)

            next_stage.append(row_num[stage][col] - 2*num_FA - num_HA + num_carry)
            num_carry = num_FA + num_HA
    row_num.append(next_stage)

print(netlist_str)