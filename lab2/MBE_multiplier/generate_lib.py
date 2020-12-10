from jinja2 import Environment, FileSystemLoader

# This module defines the functions FA_gen(), HA_gen() and unproc_prop() which
# are needed in order to instatiate the full adders, half adders and to propagate
# the unprocessed bits respectively. Moreover, the function vhdl_composer() is
# defined in order to use the jinja2 Python library, which exploites the template
# file "MBE_mult_template.vhd" to generate the final VHDL file by inserting the
# string "netlist_str".

# In order to correctly map the input and output bits in the full adder and half
# adder instances and unprocessed bits propagation, the following policy is adopted:
# 1. the elaboration order is full adders, then half adders and lastly unprocessed
#   bits propagation;
# 2. full adders collocates the output carry-bits with the lowest index, from 0 to
#   num_FA-1; sum bits are collocated with lowest index taking into account that
#   the previous column has already instatiated num_carry bits in the current weight
# 3. half adders collocates carry-bits after the first num_FA bits collocated in the
#   previos step; similarly, sum bits are collocated after num_carry + num_FA bits.#

# In order to correctly map the bits between the two consecutive stages, the following
# policy is adopted: the full adders are instantiated mapping the bits with the lowest
# index possible, taking into account only the precedent weigth carry-out bits; then
# the half adders' instances take into account both the carry-out bits and the full
# adders; lastly the unprocessed bits are propagated with the same methodology.

def FA_gen(netlist_str, num_FA, num_carry, stage, col):
    
    # This function returns the input string "netlistr_str" concatenating num_FA
    # full adder instances.

    for i in range(num_FA):
        netlist_str += f"FA_{stage}_{col}_{i} : FA port map (\n"
        
        # Full Adder input
        netlist_str += f"\ta => dadda_i({stage})({3*i})({col}),\n"
        netlist_str += f"\tb => dadda_i({stage})({3*i + 1})({col}),\n"
        netlist_str += f"\tcin => dadda_i({stage})({3*i + 2})({col}),\n"

        # Full Adder sum
        netlist_str += f"\ts => dadda_i({stage+1})({num_carry + i})({col}),\n"
        # Full Adder cout
        netlist_str += f"\tcout => dadda_i({stage+1})({i})({col+1}));\n"

    netlist_str += "\n"
    return netlist_str


def HA_gen(netlist_str, num_HA, num_FA, num_carry, stage, col):

    # This function returns the input string "netlistr_str" concatenating num_HA
    # half adder instances after num_FA full adders.

    for i in range(num_HA):
        netlist_str += f"HA_{stage}_{col}_{i} : HA port map (\n"
        
        # Half Adder input
        netlist_str += f"\ta => dadda_i({stage})({2*i + 3*num_FA})({col}),\n"
        netlist_str += f"\tb => dadda_i({stage})({2*i + 1 + 3*num_FA})({col}),\n"
        
        # Half Adder sum
        netlist_str += f"\ts => dadda_i({stage+1})({num_carry + num_FA + i})({col}),\n"
        # Half Adder cout
        netlist_str += f"\tcout => dadda_i({stage+1})({num_FA + i})({col+1}));\n"

    netlist_str += "\n"
    return netlist_str


def unproc_prop(netlist_str, num_unproc, num_FA, num_HA, num_carry, stage, col):

    # This function returns the input string "netlistr_str" concatenating the
    # assignment of the unprocessed bit signals to the following stage, taking
    # into account the previously instantiated full adders and half adders.

    netlist_str += f"-- Number of unprocessed bits: {num_unproc}\n"

    for i in range(num_unproc):
        # next stage signal
        netlist_str += f"dadda_i({stage+1})({i + num_FA + num_HA + num_carry})({col}) <= "
        
        # last stage signal
        netlist_str += f"dadda_i({stage})({3*num_FA + 2*num_HA + i})({col});\n"
    
    netlist_str += "\n"
    return netlist_str

def vhdl_composer(netlist_str, filename):

    file_loader = FileSystemLoader('./')
    env = Environment(loader=file_loader)
    template = env.get_template('MBE_mult_template.vhd')

    output = template.render(netlist_str=netlist_str)

    vhdl_file = open(filename, 'w')
    vhdl_file.write(output)
