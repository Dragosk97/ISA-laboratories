
ref_file = open("./output_c_7.txt", 'r')
dut_file = open("./results.txt", 'r')

error_flag = 0
line = 1

for dut_line in dut_file:
    dut_line = dut_line.strip()
    input_line = ref_file.readline().strip()
    
    dut_res = int(dut_line)
    exp_res = int(input_line)

    if exp_res != dut_res:
        error_flag = 1
        print(f"Error at line: {line}")
        print(f"dut result: {dut_res}")
        print(f"exp result: {exp_res}")
        print()
    line += 1

if error_flag == 1:
    print("File check failed!")
else:
    print("File check successful!")