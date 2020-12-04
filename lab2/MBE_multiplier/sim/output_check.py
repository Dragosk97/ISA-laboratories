
ref_file = open("../matlab/results_matlab.txt", 'r')
dut_file = open("./results_modelsim.txt", 'r')

error_flag = 0
line = 1

for dut_line in dut_file:
    dut_line = dut_line.strip()
    input_line = ref_file.readline().strip()
    
    #dut_res = int(dut_line,'b')
    #exp_res = int(input_line,'b')

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
