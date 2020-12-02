from jinja2 import Environment, FileSystemLoader

def FA_gen(netlist_str, num_FA, num_carry, stage, col):
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

    netlist_str += f"-- Numero non processati: {num_unproc}\n"

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
