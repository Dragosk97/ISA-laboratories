LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY execution_stage IS
	PORT (
          clk:IN std_logic;
          --input ID/EX
          data1_idex, data2_idex: IN signed(31 downto 0);
          wb_idex: IN std_logic;
          MemRead_idex: IN std_logic;
          MemLoad_idex: IN std_logic;
          aluop_idex: IN std_logic_vector(1 downto 0);
          funct3_idex: IN std_logic_vector(2 downto 0); 
          rs1_address_idex: IN std_logic_vector(4 downto 0);
          rs2_address_idex: IN std_logic_vector(4 downto 0);
          rd_address_idex: IN std_logic_vector(4 downto 0);
          mux1_pc_sel_idex: IN std_logic;
          mux2_imm_sel_idex: IN std_logic;
          mux_result_sel_idex: IN std_logic_vector(1 downto 0);
          pc_idex: IN std_logic_vector(31 downto 0);
          immediate_idex: IN signed(31 downto 0);
          RegWrite_idex : IN std_logic;
          
          --input MEM/WB
          rd_address_memwb: IN std_logic_vector(4 downto 0);
          result_memwb: IN signed(31 downto 0);
          memwb_fwd_en: IN std_logic;
          
          -- Output EX/MEM
          data2_fwd_exmem: OUT signed (31 downto 0);
          MemRead_exmem: OUT std_logic;
          MemLoad_exmem: OUT std_logic;
          RegWrite_exmem: OUT std_logic;
          rd_address_exmem: OUT std_logic_vector(4 downto 0);
          result_exmem: OUT std_logic_vector(31 downto 0);
          wb_exmem: OUT std_logic
          );
END execution_stage;

ARCHITECTURE structural OF execution_stage IS

component alu is 
port( data_inA : in signed (31 downto 0);
      data_inB : in signed (31 downto 0);
      alu_ctr_input : in std_logic_vector(3 downto 0);
      result : out signed (31 downto 0));
end component;

component alu_control is
    port (
        aluop   : in std_logic_vector(1 downto 0);
        funct3  : in std_logic_vector(2 downto 0);
        alu_ctrl: out std_logic_vector(3 downto 0));
end component;

component mux3to1 IS
    GENERIC (N: integer:=8);
    PORT (a, b, c: IN signed(N-1 downto 0);
            sel : IN std_logic_vector(1 downto 0);
            m_out : OUT signed(N-1 downto 0));
END component;

component mux2to1 is
	GENERIC (n : INTEGER:=47);
	port
	(	a: in signed(n-1 downto 0);
		b: in signed(n-1 downto 0);
		s: in std_logic;
		z: out signed(n-1 downto 0));
end component;

component forwarding_unit is 
port( rs1_address_idex: IN std_logic_vector(4 downto 0);
      rs2_address_idex: IN std_logic_vector(4 downto 0);
      rd_address_exmem: IN std_logic_vector(4 downto 0);
      rd_address_memwb: IN std_logic_vector(4 downto 0);
      exmem_fwd_en: IN std_logic;
      memwb_fwd_en: IN std_logic;
      mux1_fwd, mux2_fwd: OUT std_logic_vector(1 downto 0));
end component;

SIGNAL RegWrite_exmem_buff : std_logic;
SIGNAL result_exmem_buff : std_logic_vector(31 downto 0);
SIGNAL rd_address_exmem_buff : std_logic_vector(4 downto 0);

SIGNAL mux1_fwd_sel, mux2_fwd_sel: std_logic_vector(1 downto 0);
SIGNAL mux1_fwd_out, mux2_fwd_out: signed(31 downto 0);

SIGNAL alu_inA , alu_inB: signed(31 downto 0);
SIGNAL alu_ctrl_input: std_logic_vector(3 downto 0);
SIGNAL alu_result : signed (31 downto 0);

SIGNAL pc_signed: signed(31 downto 0);
SIGNAL pc_next: signed(31 downto 0);

SIGNAL ex_result: signed (31 downto 0);

BEGIN

--mux forwarding
mux1_alu_fwd: mux3to1 GENERIC MAP (32) 
PORT MAP( a => data1_idex,
          b => result_memwb,
          c => result_exmem_buff,
          sel => mux1_fwd_sel,
          m_out => mux1_fwd_out);

mux2_alu_fwd: mux3to1 GENERIC MAP (32) 
PORT MAP( a => data2_idex,
          b => result_memwb,
          c => result_exmem_buff,
          sel => mux2_fwd_sel,
          m_out => mux2_fwd_out);

--mux_pc
pc_signed <= signed(pc_idex);

mux1_alu_pc: mux2to1 GENERIC MAP (32)
PORT MAP( a => mux1_fwd_out,
          b => pc_signed,
          s => mux1_pc_sel_idex,
          z => alu_inA);

--mux_imm
mux2_alu_imm: mux2to1 GENERIC MAP (32)
PORT MAP( a => mux2_fwd_out,
          b => immediate_idex,
          s => mux2_imm_sel_idex,
          z => alu_inB);

--ALU
control_alu: alu_control
PORT MAP( aluop => aluop_idex,
          funct3 => funct3_idex,
          alu_ctrl => alu_ctrl_input);

component_ALU: alu
PORT MAP( data_inA => alu_inA,
          data_inB => alu_inB,
          alu_ctr_input => alu_ctrl_input,
          result => alu_result);

--final mux
pc_next <= pc_signed + 4;

result_mux: mux3to1 GENERIC MAP (32) 
PORT MAP( a => alu_result,
          b => immediate_idex,
          c => pc_next,
          sel => mux_result_sel_idex,
          m_out => ex_result);

--forwarding_unit
forwarding: forwarding_unit
    PORT MAP( rs1_address_idex => rs1_address_idex,
              rs2_address_idex => rs2_address_idex,
              rd_address_exmem => rd_address_exmem_buff,
              rd_address_memwb => rd_address_memwb,
              exmem_fwd_en => RegWrite_exmem_buff,
              memwb_fwd_en => memwb_fwd_en,
              mux1_fwd => mux1_fwd_sel,
              mux2_fwd => mux2_fwd_sel);

--EX/MEM register
PROCESS(clk)
BEGIN
    IF RISING_EDGE(clk) THEN
        data2_fwd_exmem <= mux2_fwd_out;
        wb_exmem <= wb_idex;
        mem_exmem <= mem_idex;
        MemRead_exmem <= MemRead_idex;
        MemLoad_exmem <= MemLoad_idex;
        rd_address_exmem_buff <= rd_address_idex;
        result_exmem_buff <= ex_result;
        RegWrite_exmem_buff <= RegWrite_idex;
    END IF;
END PROCESS;

-- Buffer output
    result_exmem <= result_exmem_buff;
    rd_address_exmem <= rd_address_exmem_buff;
    RegWrite_exmem <= RegWrite_exmem_buff;
END structural;
