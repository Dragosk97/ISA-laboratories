LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity datapath is
		port(
			DIN : in signed(6 downto 0);
			REG_IN_en : in std_logic;
			REG_sample_en : in std_logic;
			REG_coeff_en : in std_logic;
			REG_OUT_en : in std_logic;
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
			DOUT: out signed(6 downto 0)
		);
end datapath;

ARCHITECTURE structural of datapath is

component GenericReg IS
	generic(regwidth : integer);
	port(d : in signed (regwidth -1 downto 0);
		  clk : in std_logic;
		  rst_n: in std_logic;
		  en : in std_logic;
		  q : out signed (regwidth -1 downto 0));
end component;

SIGNAL x0, x1, x2, x3, x4, x5, x6, x7, x8 : signed(6 downto 0);
SIGNAL bq0, bq1, bq2, bq3, bq4, bq5, bq6, bq7, bq8 : signed(6 downto 0);
SIGNAL M0, M1, M2, M3, M4, M5, M6, M7, M8 : signed(13 downto 0);
SIGNAL M0e, M1e, M2e, M3e, M4e, M5e, M6e, M7e, M8e : signed(6 downto 0);
SIGNAL S0, S1, S2, S3, S4, S5, S6 : signed(6 downto 0);
SIGNAL Y : signed(6 downto 0);

BEGIN

--register
Reg_in : GenericReg GENERIC MAP (7)
	PORT MAP ( 	d => DIN,
					clk => clk,
					rst_n => rst_n,
					en => Reg_IN_en,
					q => x0			
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

Reg_Sample1 : GenericReg GENERIC MAP (7)
	PORT MAP ( 	d => x0,
					clk => clk,
					rst_n => rst_n,
					en => Reg_sample_en,
					q => x1			
	);

Reg_Sample2 : GenericReg GENERIC MAP (7)
	PORT MAP ( 	d => x1,
					clk => clk,
					rst_n => rst_n,
					en => Reg_sample_en,
					q => x2		
	);

Reg_Sample3 : GenericReg GENERIC MAP (7)
	PORT MAP ( 	d => x2,
					clk => clk,
					rst_n => rst_n,
					en => Reg_sample_en,
					q => x3		
	);
	
Reg_Sample4 : GenericReg GENERIC MAP (7)
	PORT MAP ( 	d => x3,
					clk => clk,
					rst_n => rst_n,
					en => Reg_sample_en,
					q => x4		
	);
	
Reg_Sample5 : GenericReg GENERIC MAP (7)
	PORT MAP ( 	d => x4,
					clk => clk,
					rst_n => rst_n,
					en => Reg_sample_en,
					q => x5		
	);
	
Reg_Sample6 : GenericReg GENERIC MAP (7)
	PORT MAP ( 	d => x5,
					clk => clk,
					rst_n => rst_n,
					en => Reg_sample_en,
					q => x6		
	);

Reg_Sample7 : GenericReg GENERIC MAP (7)
	PORT MAP ( 	d => x6,
					clk => clk,
					rst_n => rst_n,
					en => Reg_sample_en,
					q => x7		
	);

Reg_Sample8 : GenericReg GENERIC MAP (7)
	PORT MAP ( 	d => x7,
					clk => clk,
					rst_n => rst_n,
					en => Reg_sample_en,
					q => x8		
	);
	
--multiplication
M0 <= x0 * bq0;
M1 <= x1 * bq1;
M2 <= x2 * bq2;
M3 <= x3 * bq3;
M4 <= x4 * bq4;
M5 <= x5 * bq5;
M6 <= x6 * bq6;
M7 <= x7 * bq7;
M8 <= x8 * bq8;

--sign extention
--M0e <= resize(M0(12 downto 6),14);
--M1e <= resize(M1(12 downto 6),14);
--M2e <= resize(M2(12 downto 6),14);
--M3e <= resize(M3(12 downto 6),14);
--M4e <= resize(M4(12 downto 6),14);
--M5e <= resize(M5(12 downto 6),14);
--M6e <= resize(M6(12 downto 6),14);
--M7e <= resize(M7(12 downto 6),14);
--M8e <= resize(M8(12 downto 6),14);

M0e <= M0(12 downto 6);
M1e <= M1(12 downto 6);
M2e <= M2(12 downto 6);
M3e <= M3(12 downto 6);
M4e <= M4(12 downto 6);
M5e <= M5(12 downto 6);
M6e <= M6(12 downto 6);
M7e <= M7(12 downto 6);
M8e <= M8(12 downto 6);

--addition
S0 <= M0e + M1e;
S1 <= S0 + M2e;
S2 <= S1 + M3e;
S3 <= S2 + M4e;
S4 <= S3 + M5e;
S5 <= S4 + M6e;
S6 <= S5 + M7e;

Y  <= S6 + M8e;

--reg_out
Reg_out : GenericReg GENERIC MAP (7)
	PORT MAP ( 	d => Y(6 downto 0), --truncation
					clk => clk,
					rst_n => rst_n,
					en => Reg_OUT_en,
					q => DOUT		
	);

end structural;
