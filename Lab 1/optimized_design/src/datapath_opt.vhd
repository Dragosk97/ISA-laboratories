LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity datapath_opt is
		port(
			DIN1 : in signed(6 downto 0);
			DIN2 : in signed(6 downto 0);
			DIN3 : in signed(6 downto 0);
			REG_IN_en : in std_logic;
			REG_sample_en : in std_logic;
			REG_OUT_en : in std_logic;
			reg_coeff_en : in std_logic;
			counter_en : in std_logic;
			rst_n: in std_logic;
			clk: in std_logic;
			
			b0: in signed(6 downto 0);
			b1: in signed(6 downto 0);
			b2: in signed(6 downto 0);
			b3: in signed(6 downto 0);
			b4: in signed(6 downto 0);
			b5: in signed(6 downto 0);
			b6: in signed(6 downto 0);
			b7: in signed(6 downto 0);
			b8: in signed(6 downto 0);
			
			--output
			DOUT1: out signed(6 downto 0);
			DOUT2: out signed(6 downto 0);
			DOUT3: out signed(6 downto 0);
			TC: out std_logic
		);
end datapath_opt;

architecture structural OF datapath_opt IS

component GenericReg IS
	generic(regwidth : integer);
	port(d : in signed (regwidth -1 downto 0);
		  clk : in std_logic;
		  rst_n: in std_logic;
		  en : in std_logic;
		  q : out signed (regwidth -1 downto 0));
end component;

component Counter_nbit IS
	GENERIC (n : INTEGER := 3);
	PORT( EN : in std_logic;
			RST_n : in std_logic;
			CLK : in std_logic;
			Q: buffer std_logic_vector(n-1 downto 0)
	);
end component;


type array10 IS array (0 to 10) of signed(6 downto 0);
type array9 IS array (0 to 9) of signed(6 downto 0);

SIGNAL x1: array9; 
SIGNAL x2: array10;
SIGNAL x3: array10;

type m IS array (0 to 8) of signed(13 downto 0);
type s IS array (0 to 7) of signed(6 downto 0);
type sout IS array (0 to 6) of signed(6 downto 0);
type mr IS array (0 to 8) of signed(6 downto 0);

SIGNAL m1, m2, m3: m; 
SIGNAL s1, s2, s3: s;
SIGNAL sout1, sout2, sout3: sout;
SIGNAL bq0, bq1, bq2, bq3, bq4, bq5, bq6, bq7, bq8 : signed(6 downto 0);
SIGNAL mr1, mr2, mr3: mr;

signal CNT_Q : std_logic_vector(2 downto 0);

BEGIN

--reg_in
Reg_in1 : GenericReg GENERIC MAP (7)
	PORT MAP ( 	d => DIN1,
					clk => clk,
					rst_n => rst_n,
					en => Reg_IN_en,
					q => x1(0)		
	);

Reg_in2 : GenericReg GENERIC MAP (7)
	PORT MAP ( 	d => DIN2,
					clk => clk,
					rst_n => rst_n,
					en => Reg_IN_en,
					q => x2(0)		
	);

Reg_in3 : GenericReg GENERIC MAP (7)
	PORT MAP ( 	d => DIN3,
					clk => clk,
					rst_n => rst_n,
					en => Reg_IN_en,
					q => x3(0)		
	);

Reg_coeff0 : GenericReg GENERIC MAP (7)
	PORT MAP (
		d => b0,
		clk => clk,
		rst_n => rst_n,
		en => Reg_coeff_en,
		q => bq0
	);

Reg_coeff1 : GenericReg GENERIC MAP (7)
	PORT MAP (
		d => b1,
		clk => clk,
		rst_n => rst_n,
		en => Reg_coeff_en,
		q => bq1
	);

Reg_coeff2 : GenericReg GENERIC MAP (7)
	PORT MAP (
		d => b2,
		clk => clk,
		rst_n => rst_n,
		en => Reg_coeff_en,
		q => bq2
	);

Reg_coeff3 : GenericReg GENERIC MAP (7)
	PORT MAP (
		d => b3,
		clk => clk,
		rst_n => rst_n,
		en => Reg_coeff_en,
		q => bq3
	);

Reg_coeff4 : GenericReg GENERIC MAP (7)
	PORT MAP (
		d => b4,
		clk => clk,
		rst_n => rst_n,
		en => Reg_coeff_en,
		q => bq4
	);

Reg_coeff5 : GenericReg GENERIC MAP (7)
	PORT MAP (
		d => b5,
		clk => clk,
		rst_n => rst_n,
		en => Reg_coeff_en,
		q => bq5
	);

Reg_coeff6 : GenericReg GENERIC MAP (7)
	PORT MAP (
		d => b6,
		clk => clk,
		rst_n => rst_n,
		en => Reg_coeff_en,
		q => bq6
	);

Reg_coeff7 : GenericReg GENERIC MAP (7)
	PORT MAP (
		d => b7,
		clk => clk,
		rst_n => rst_n,
		en => Reg_coeff_en,
		q => bq7
	);

Reg_coeff8 : GenericReg GENERIC MAP (7)
	PORT MAP (
		d => b8,
		clk => clk,
		rst_n => rst_n,
		en => Reg_coeff_en,
		q => bq8
	);

--pipeline
pipe_x1 : for i in 0 to 8 
	generate
		x1_reg : GenericReg generic map (7) port map (
			d => x1(i),
			clk => clk,
			rst_n => rst_n,
			en => REG_sample_en,
			q => x1(i+1));
	end generate;

pipe_x2 : for i in 0 to 9 
	generate
		x2_reg : GenericReg generic map (7) port map (
			d => x2(i),
			clk => clk,
			rst_n => rst_n,
			en => REG_sample_en,
			q => x2(i+1));
	end generate;
	
pipe_x3 : for i in 0 to 9 
	generate
		x3_reg : GenericReg generic map (7) port map (
			d => x3(i),
			clk => clk,
			rst_n => rst_n,
			en => REG_sample_en,
			q => x3(i+1));
	end generate;

--mr assignment
mr_assignment: for i in 0 to 8
	generate
		m1_reg : GenericReg generic map(7) port map(
			d => m1(i)(12 downto 6),
			clk => clk,
			rst_n => rst_n,
			en => REG_sample_en,
			q => mr1(i));
		m2_reg : GenericReg generic map(7) port map(
			d => m2(i)(12 downto 6),
			clk => clk,
			rst_n => rst_n,
			en => REG_sample_en,
			q => mr2(i));
		m3_reg : GenericReg generic map(7) port map(
			d => m3(i)(12 downto 6),
			clk => clk,
			rst_n => rst_n,
			en => REG_sample_en,
			q => mr3(i));
	end generate;

--adder
s1(0) <= mr1(0) + mr1(1);
s2(0) <= mr2(0) + mr2(1);
s3(0) <= mr3(0) + mr3(1);

add_reg : for i in 0 to 6
	generate
		s1_reg : GenericReg generic map(7) port map(
			d => s1(i),
			clk => clk,
			rst_n => rst_n,
			en => REG_sample_en,
			q => sout1(i));
		s2_reg : GenericReg generic map(7) port map(
			d => s2(i),
			clk => clk,
			rst_n => rst_n,
			en => REG_sample_en,
			q => sout2(i));
		s3_reg : GenericReg generic map(7) port map(
			d => s3(i),
			clk => clk,
			rst_n => rst_n,
			en => REG_sample_en,
			q => sout3(i));
	end generate;

add_sum : for i in 1 to 7
	generate
		s1(i) <= sout1(i-1) + mr1(i+1);
		s2(i) <= sout2(i-1) + mr2(i+1);
		s3(i) <= sout3(i-1) + mr3(i+1);
	end generate;

--multiplier
--multiplication of the data x1
m1(0) <= x1(0)*bq0;
m2(1) <= x1(0)*bq1;
m3(2) <= x1(1)*bq2;

m1(3) <= x1(3)*bq3;
m2(4) <= x1(4)*bq4;
m3(5) <= x1(5)*bq5;

m1(6) <= x1(7)*bq6;
m2(7) <= x1(8)*bq7;
m3(8) <= x1(9)*bq8;

--multiplication of the data x2

m2(0) <= x2(0)*bq0;
m3(1) <= x2(0)*bq1;

m1(2) <= x2(2)*bq2;
m2(3) <= x2(3)*bq3;
m3(4) <= x2(4)*bq4;

m1(5) <= x2(6)*bq5;
m2(6) <= x2(7)*bq6;
m3(7) <= x2(8)*bq7;

m1(8) <= x2(10)*bq8;

--multiplication of the data x3

m3(0) <= x3(0)*bq0;

m1(1) <= x3(1)*bq1;
m2(2) <= x3(2)*bq2;
m3(3) <= x3(3)*bq3;

m1(4) <= x3(5)*bq4;
m2(5) <= x3(6)*bq5;
m3(6) <= x3(7)*bq6;

m1(7) <= x3(9)*bq7;
m2(8) <= x3(10)*bq8;

--reg_out
Reg_out1 : GenericReg GENERIC MAP (7)
	PORT MAP ( 	d => s1(7)(6 downto 0),
					clk => clk,
					rst_n => rst_n,
					en => Reg_OUT_en,
					q => DOUT1		
	);

Reg_out2 : GenericReg GENERIC MAP (7)
	PORT MAP ( 	d => s2(7)(6 downto 0),
					clk => clk,
					rst_n => rst_n,
					en => Reg_OUT_en,
					q => DOUT2		
	);

Reg_out3 : GenericReg GENERIC MAP (7)
	PORT MAP ( 	d => s3(7)(6 downto 0),
					clk => clk,
					rst_n => rst_n,
					en => Reg_OUT_en,
					q => DOUT3		
	);

--counter
CNT: Counter_nbit generic map (3)
	port map (	EN => counter_en,
				RST_n => rst_n,
				CLK => clk,
				Q => CNT_Q
	);

TC <= '1' WHEN CNT_Q = "111" ELSE '0';

end structural;
