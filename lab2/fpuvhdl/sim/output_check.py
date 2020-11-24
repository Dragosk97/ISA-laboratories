
ref_file = open("./fp_prod.hex", 'r')
dut_file = open("./fp_out.hex", 'r')

error_flag = 0
line = 1

for dut_line in dut_file:
    dut_line = dut_line.strip().lower()
    input_line = ref_file.readline().strip().lower()
    
    if input_line != dut_line:
        error_flag = 1
        print(f"Error at line: {line}")
        print(f"dut result: {dut_line}")
        print(f"exp result: {input_line}")
        print()
    line += 1

if error_flag == 1:
    print("File check failed!")
else:
    print("File check successful!")