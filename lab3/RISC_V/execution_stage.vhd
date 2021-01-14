LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY execution_stage IS
	PORT (data1_idex, data2_idex: IN signed(31 downto 0);
          wb_idex: IN std_logic;
          mem_idex: IN std_logic_vector(1 downto 0);
          aluop_idex: IN std_logic_vector(1 downto 0);
          funct3_idex: IN std_logic_vector(2 downto 0); 
          rs1_address_idex: IN std_logic_vector(4 downto 0);
          rs2_address_idex: IN std_logic_vector(4 downto 0);
          rd_address_idex: IN std_logic_vector(4 downto 0);
         
          result_exmem: IN signed(31 downto 0);
          result_memwb: IN signed(31 downto 0);
          pc_idex: IN std_logic_vector(31 downto 0);
          immediate_idex: IN signed(31 downto 0);
          mux1_pc_sel: IN std_logic;
          mux2_imm_sel: IN std_logic;

          alu_result : OUT signed (31 downto 0);
          data2_fwd: OUT signed (31 downto 0);
          rd_address_out: IN std_logic_vector(4 downto 0));
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


SIGNAL mux1_fwd_sel, mux2_fwd_sel: std_logic;
SIGNAL mux1_fwd_out, mux2_fwd_out: signed(31 downto 0);

SIGNAL alu_inA , alu_inB: signed(31 downto 0);

SIGNAL pc_signed: signed(31 downto 0);

BEGIN

mux1_alu_fwd: GENERIC MAP (32) 
PORT MAP( a => data1_idex,
          b => result_memwb,
          c => result_exmem,
          sel => mux1_fwd_sel,
          m_out => mux1_fwd_out);

mux2_alu_fwd: GENERIC MAP (32) 
PORT MAP( a => data2_idex,
          b => result_memwb,
          c => result_exmem,
          sel => mux2_fwd_sel,
          m_out => mux2_fwd_out);

pc_signed <= signed(pc_idex);

mux1_alu_pc: GENERIC MAP (32)
PORT MAP( a => mux1_fwd_out,
          b => pc_signed,
          sel => mux1_pc_sel,
          z => alu_inA);

mux2_alu_imm: GENERIC MAP (32)
PORT MAP( a => mux2_fwd_out,
          b => immediate_idex,
          sel => mux2_imm_sel,
          z => alu_inB);
END structural;