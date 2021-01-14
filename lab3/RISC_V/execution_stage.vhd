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
	GENERIC (n : INTEGER := 47 );
	port
	(	a: in signed(n-1 downto 0);
		b: in signed(n-1 downto 0);
		s: in std_logic;
		z: out signed(n-1 downto 0));
end component;

BEGIN

	
		  
END structural;