LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity MBE_mult is 
		port(	
				a : IN std_logic_vector (23 downto 0);
				b : IN std_logic_vector (23 downto 0);
				p : OUT std_logic_vector (47 downto 0)	
);
end MBE_mult;

ARCHITECTURE behavioural of MBE_mult IS 

component MBE_n is
generic(nbit : integer);
    port(
        a : in std_logic_vector(nbit-1 downto 0);
        b0 : in std_logic; 
        b1 : in std_logic;
        b2 : in std_logic;
        pp : out std_logic_vector(nbit downto 0)
    );
end component;

component HA is
	port (a, b: in std_logic;
			s, cout : out std_logic);
end component;

component FA is
	port (a, b, cin : in std_logic;
			s, cout : out std_logic);
end component;

type array_mbe IS array (0 to 12) of std_logic_vector (24 downto 0);
SIGNAL mbe_out : array_mbe;

--dadda input preparation
type array_s IS array (0 to 12) of std_logic_vector (28 downto 0);
SIGNAL in_dadda : array_s;

--
type array_int is array (0 to 47) of integer;
type array_stage_int is array (0 to 5) of array_int;

type array_target is array (0 to 5) of integer;

type array_matrix is array (0 to 12) of std_logic_vector(48 downto 0);
type array_stage is array(0 to 5) of array_matrix;
SIGNAL dadda_i : array_stage;
SIGNAL zero : std_logic;

BEGIN
--MBE
zero <= '0';

mbe_pp0: MBE_n generic map (24) port map(
			a => a,
			b0 => zero,
			b1 => b(0),
			b2 => b(1),
			pp=> mbe_out(0));

mult_pp: for i in 1 to 11
	generate 
		mult1: MBE_n generic map (24) port map(
			a => a,
			b0 => b(2*i-1),
			b1 => b(2*i),
			b2 => b(2*i+1),
			pp=> mbe_out(i));
	end generate;

mbe_pp12: MBE_n generic map (24) port map(
			a => a,
			b0 => b(23),
			b1 => zero,
			b2 => zero,
			pp=> mbe_out(12));

--input DADDA
in_dadda(0) <= NOT(b(1)) & b(1) & b(1) & mbe_out(0) & b(1);
 
input_dadda : for i in 1 to 10
	generate
		in_dadda(i)(27 downto 0) <= '1' & NOT(b(2*i+1)) & mbe_out(i) & b(2*i+1);
	end generate;
	
in_dadda(11)(26 downto 0) <= NOT(b(2*11+1)) & mbe_out(11) & b(2*11+1);
in_dadda(12)(23 downto 0) <= mbe_out(12) (23 downto 0);


-- Initialization of dadda_i(0)

-- First row
dadda_i(0)(0)(27 downto 0) <= in_dadda(0)(28 downto 1);

-- Middle row
dadda_init : for i in 1 to 11
generate
	dadda_i(0)(i)(27 downto 2*i) <= in_dadda(i)(28 -2*i downto 1);
	dadda_i(0)(i)(2*(i-1)) <= in_dadda(i-1)(0);
	
	-- column 28 lifts of one position 
	dadda_i(0)(i-1)(28) <= in_dadda(i)(27 - 2*(i-1));
	
	-- each column lifts as much as possible
	middle_row_lift: for j in 2 to i 
	generate
		last_midcol_lift: if j = 11 generate 
			dadda_i(0)(0)(47) <= in_dadda(11)(26);
		end generate;
		midcol_lift: if j < 11 generate
			dadda_i(0)(i-j)(27 + 2*(j-1) + 1 downto 27 + 2*(j-1) ) <= in_dadda(i)(27+2*(-i+j) downto 26+2*(-i+j));
		end generate;
	end generate;

end generate;

--Last row, i = 12

dadda_i(0)(12)(27 downto 24) <= in_dadda(12)(3 downto 0);
dadda_i(0)(12)(22) <= in_dadda(11)(0);

-- column 28 bit lift
dadda_i(0)(11)(28) <= in_dadda(12)(4);

lastrow_lift: for j in 2 to 11 
generate
	
	lastrow_lastcol_lift: if j = 11 generate 
	dadda_i(0)(1)(47) <= in_dadda(12)(23);
	end generate;
	lastrow_midcol_lift: if j < 11 generate
	dadda_i(0)(12-j)(27 + 2*(j-1) + 1 downto 27 + 2*(j-1) ) <= in_dadda(12)(24+2*(-11+j) downto 23+2*(-11+j));
	end generate;

end generate;

--------------------------------------------------------------------

-- Numero non processati: 2
dadda_i(1)(0)(0) <= dadda_i(0)(0)(0);
dadda_i(1)(1)(0) <= dadda_i(0)(1)(0);

-- Numero non processati: 1
dadda_i(1)(0)(1) <= dadda_i(0)(0)(1);

-- Numero non processati: 3
dadda_i(1)(0)(2) <= dadda_i(0)(0)(2);
dadda_i(1)(1)(2) <= dadda_i(0)(1)(2);
dadda_i(1)(2)(2) <= dadda_i(0)(2)(2);

-- Numero non processati: 2
dadda_i(1)(0)(3) <= dadda_i(0)(0)(3);
dadda_i(1)(1)(3) <= dadda_i(0)(1)(3);

-- Numero non processati: 4
dadda_i(1)(0)(4) <= dadda_i(0)(0)(4);
dadda_i(1)(1)(4) <= dadda_i(0)(1)(4);
dadda_i(1)(2)(4) <= dadda_i(0)(2)(4);
dadda_i(1)(3)(4) <= dadda_i(0)(3)(4);

-- Numero non processati: 3
dadda_i(1)(0)(5) <= dadda_i(0)(0)(5);
dadda_i(1)(1)(5) <= dadda_i(0)(1)(5);
dadda_i(1)(2)(5) <= dadda_i(0)(2)(5);

-- Numero non processati: 5
dadda_i(1)(0)(6) <= dadda_i(0)(0)(6);
dadda_i(1)(1)(6) <= dadda_i(0)(1)(6);
dadda_i(1)(2)(6) <= dadda_i(0)(2)(6);
dadda_i(1)(3)(6) <= dadda_i(0)(3)(6);
dadda_i(1)(4)(6) <= dadda_i(0)(4)(6);

-- Numero non processati: 4
dadda_i(1)(0)(7) <= dadda_i(0)(0)(7);
dadda_i(1)(1)(7) <= dadda_i(0)(1)(7);
dadda_i(1)(2)(7) <= dadda_i(0)(2)(7);
dadda_i(1)(3)(7) <= dadda_i(0)(3)(7);

-- Numero non processati: 6
dadda_i(1)(0)(8) <= dadda_i(0)(0)(8);
dadda_i(1)(1)(8) <= dadda_i(0)(1)(8);
dadda_i(1)(2)(8) <= dadda_i(0)(2)(8);
dadda_i(1)(3)(8) <= dadda_i(0)(3)(8);
dadda_i(1)(4)(8) <= dadda_i(0)(4)(8);
dadda_i(1)(5)(8) <= dadda_i(0)(5)(8);

-- Numero non processati: 5
dadda_i(1)(0)(9) <= dadda_i(0)(0)(9);
dadda_i(1)(1)(9) <= dadda_i(0)(1)(9);
dadda_i(1)(2)(9) <= dadda_i(0)(2)(9);
dadda_i(1)(3)(9) <= dadda_i(0)(3)(9);
dadda_i(1)(4)(9) <= dadda_i(0)(4)(9);

-- Numero non processati: 7
dadda_i(1)(0)(10) <= dadda_i(0)(0)(10);
dadda_i(1)(1)(10) <= dadda_i(0)(1)(10);
dadda_i(1)(2)(10) <= dadda_i(0)(2)(10);
dadda_i(1)(3)(10) <= dadda_i(0)(3)(10);
dadda_i(1)(4)(10) <= dadda_i(0)(4)(10);
dadda_i(1)(5)(10) <= dadda_i(0)(5)(10);
dadda_i(1)(6)(10) <= dadda_i(0)(6)(10);

-- Numero non processati: 6
dadda_i(1)(0)(11) <= dadda_i(0)(0)(11);
dadda_i(1)(1)(11) <= dadda_i(0)(1)(11);
dadda_i(1)(2)(11) <= dadda_i(0)(2)(11);
dadda_i(1)(3)(11) <= dadda_i(0)(3)(11);
dadda_i(1)(4)(11) <= dadda_i(0)(4)(11);
dadda_i(1)(5)(11) <= dadda_i(0)(5)(11);

-- Numero non processati: 8
dadda_i(1)(0)(12) <= dadda_i(0)(0)(12);
dadda_i(1)(1)(12) <= dadda_i(0)(1)(12);
dadda_i(1)(2)(12) <= dadda_i(0)(2)(12);
dadda_i(1)(3)(12) <= dadda_i(0)(3)(12);
dadda_i(1)(4)(12) <= dadda_i(0)(4)(12);
dadda_i(1)(5)(12) <= dadda_i(0)(5)(12);
dadda_i(1)(6)(12) <= dadda_i(0)(6)(12);
dadda_i(1)(7)(12) <= dadda_i(0)(7)(12);

-- Numero non processati: 7
dadda_i(1)(0)(13) <= dadda_i(0)(0)(13);
dadda_i(1)(1)(13) <= dadda_i(0)(1)(13);
dadda_i(1)(2)(13) <= dadda_i(0)(2)(13);
dadda_i(1)(3)(13) <= dadda_i(0)(3)(13);
dadda_i(1)(4)(13) <= dadda_i(0)(4)(13);
dadda_i(1)(5)(13) <= dadda_i(0)(5)(13);
dadda_i(1)(6)(13) <= dadda_i(0)(6)(13);

-- Numero non processati: 9
dadda_i(1)(0)(14) <= dadda_i(0)(0)(14);
dadda_i(1)(1)(14) <= dadda_i(0)(1)(14);
dadda_i(1)(2)(14) <= dadda_i(0)(2)(14);
dadda_i(1)(3)(14) <= dadda_i(0)(3)(14);
dadda_i(1)(4)(14) <= dadda_i(0)(4)(14);
dadda_i(1)(5)(14) <= dadda_i(0)(5)(14);
dadda_i(1)(6)(14) <= dadda_i(0)(6)(14);
dadda_i(1)(7)(14) <= dadda_i(0)(7)(14);
dadda_i(1)(8)(14) <= dadda_i(0)(8)(14);

-- Numero non processati: 8
dadda_i(1)(0)(15) <= dadda_i(0)(0)(15);
dadda_i(1)(1)(15) <= dadda_i(0)(1)(15);
dadda_i(1)(2)(15) <= dadda_i(0)(2)(15);
dadda_i(1)(3)(15) <= dadda_i(0)(3)(15);
dadda_i(1)(4)(15) <= dadda_i(0)(4)(15);
dadda_i(1)(5)(15) <= dadda_i(0)(5)(15);
dadda_i(1)(6)(15) <= dadda_i(0)(6)(15);
dadda_i(1)(7)(15) <= dadda_i(0)(7)(15);


HA_0_16_0 : HA port map (
	a => dadda_i(0)(0)(16),
	b => dadda_i(0)(1)(16),
	s => dadda_i(1)(0)(16),
	cout => dadda_i(1)(0)(17));

-- Numero non processati: 8
dadda_i(1)(1)(16) <= dadda_i(0)(2)(16);
dadda_i(1)(2)(16) <= dadda_i(0)(3)(16);
dadda_i(1)(3)(16) <= dadda_i(0)(4)(16);
dadda_i(1)(4)(16) <= dadda_i(0)(5)(16);
dadda_i(1)(5)(16) <= dadda_i(0)(6)(16);
dadda_i(1)(6)(16) <= dadda_i(0)(7)(16);
dadda_i(1)(7)(16) <= dadda_i(0)(8)(16);
dadda_i(1)(8)(16) <= dadda_i(0)(9)(16);


HA_0_17_0 : HA port map (
	a => dadda_i(0)(0)(17),
	b => dadda_i(0)(1)(17),
	s => dadda_i(1)(1)(17),
	cout => dadda_i(1)(0)(18));

-- Numero non processati: 7
dadda_i(1)(2)(17) <= dadda_i(0)(2)(17);
dadda_i(1)(3)(17) <= dadda_i(0)(3)(17);
dadda_i(1)(4)(17) <= dadda_i(0)(4)(17);
dadda_i(1)(5)(17) <= dadda_i(0)(5)(17);
dadda_i(1)(6)(17) <= dadda_i(0)(6)(17);
dadda_i(1)(7)(17) <= dadda_i(0)(7)(17);
dadda_i(1)(8)(17) <= dadda_i(0)(8)(17);

FA_0_18_0 : FA port map (
	a => dadda_i(0)(0)(18),
	b => dadda_i(0)(1)(18),
	cin => dadda_i(0)(2)(18),
	s => dadda_i(1)(1)(18),
	cout => dadda_i(1)(0)(19));

HA_0_18_0 : HA port map (
	a => dadda_i(0)(3)(18),
	b => dadda_i(0)(4)(18),
	s => dadda_i(1)(2)(18),
	cout => dadda_i(1)(1)(19));

-- Numero non processati: 6
dadda_i(1)(3)(18) <= dadda_i(0)(5)(18);
dadda_i(1)(4)(18) <= dadda_i(0)(6)(18);
dadda_i(1)(5)(18) <= dadda_i(0)(7)(18);
dadda_i(1)(6)(18) <= dadda_i(0)(8)(18);
dadda_i(1)(7)(18) <= dadda_i(0)(9)(18);
dadda_i(1)(8)(18) <= dadda_i(0)(10)(18);

FA_0_19_0 : FA port map (
	a => dadda_i(0)(0)(19),
	b => dadda_i(0)(1)(19),
	cin => dadda_i(0)(2)(19),
	s => dadda_i(1)(2)(19),
	cout => dadda_i(1)(0)(20));

HA_0_19_0 : HA port map (
	a => dadda_i(0)(3)(19),
	b => dadda_i(0)(4)(19),
	s => dadda_i(1)(3)(19),
	cout => dadda_i(1)(1)(20));

-- Numero non processati: 5
dadda_i(1)(4)(19) <= dadda_i(0)(5)(19);
dadda_i(1)(5)(19) <= dadda_i(0)(6)(19);
dadda_i(1)(6)(19) <= dadda_i(0)(7)(19);
dadda_i(1)(7)(19) <= dadda_i(0)(8)(19);
dadda_i(1)(8)(19) <= dadda_i(0)(9)(19);

FA_0_20_0 : FA port map (
	a => dadda_i(0)(0)(20),
	b => dadda_i(0)(1)(20),
	cin => dadda_i(0)(2)(20),
	s => dadda_i(1)(2)(20),
	cout => dadda_i(1)(0)(21));
FA_0_20_1 : FA port map (
	a => dadda_i(0)(3)(20),
	b => dadda_i(0)(4)(20),
	cin => dadda_i(0)(5)(20),
	s => dadda_i(1)(3)(20),
	cout => dadda_i(1)(1)(21));

HA_0_20_0 : HA port map (
	a => dadda_i(0)(6)(20),
	b => dadda_i(0)(7)(20),
	s => dadda_i(1)(4)(20),
	cout => dadda_i(1)(2)(21));

-- Numero non processati: 4
dadda_i(1)(5)(20) <= dadda_i(0)(8)(20);
dadda_i(1)(6)(20) <= dadda_i(0)(9)(20);
dadda_i(1)(7)(20) <= dadda_i(0)(10)(20);
dadda_i(1)(8)(20) <= dadda_i(0)(11)(20);

FA_0_21_0 : FA port map (
	a => dadda_i(0)(0)(21),
	b => dadda_i(0)(1)(21),
	cin => dadda_i(0)(2)(21),
	s => dadda_i(1)(3)(21),
	cout => dadda_i(1)(0)(22));
FA_0_21_1 : FA port map (
	a => dadda_i(0)(3)(21),
	b => dadda_i(0)(4)(21),
	cin => dadda_i(0)(5)(21),
	s => dadda_i(1)(4)(21),
	cout => dadda_i(1)(1)(22));

HA_0_21_0 : HA port map (
	a => dadda_i(0)(6)(21),
	b => dadda_i(0)(7)(21),
	s => dadda_i(1)(5)(21),
	cout => dadda_i(1)(2)(22));

-- Numero non processati: 3
dadda_i(1)(6)(21) <= dadda_i(0)(8)(21);
dadda_i(1)(7)(21) <= dadda_i(0)(9)(21);
dadda_i(1)(8)(21) <= dadda_i(0)(10)(21);

FA_0_22_0 : FA port map (
	a => dadda_i(0)(0)(22),
	b => dadda_i(0)(1)(22),
	cin => dadda_i(0)(2)(22),
	s => dadda_i(1)(3)(22),
	cout => dadda_i(1)(0)(23));
FA_0_22_1 : FA port map (
	a => dadda_i(0)(3)(22),
	b => dadda_i(0)(4)(22),
	cin => dadda_i(0)(5)(22),
	s => dadda_i(1)(4)(22),
	cout => dadda_i(1)(1)(23));
FA_0_22_2 : FA port map (
	a => dadda_i(0)(6)(22),
	b => dadda_i(0)(7)(22),
	cin => dadda_i(0)(8)(22),
	s => dadda_i(1)(5)(22),
	cout => dadda_i(1)(2)(23));

HA_0_22_0 : HA port map (
	a => dadda_i(0)(9)(22),
	b => dadda_i(0)(10)(22),
	s => dadda_i(1)(6)(22),
	cout => dadda_i(1)(3)(23));

-- Numero non processati: 2
dadda_i(1)(7)(22) <= dadda_i(0)(11)(22);
dadda_i(1)(8)(22) <= dadda_i(0)(12)(22);

FA_0_23_0 : FA port map (
	a => dadda_i(0)(0)(23),
	b => dadda_i(0)(1)(23),
	cin => dadda_i(0)(2)(23),
	s => dadda_i(1)(4)(23),
	cout => dadda_i(1)(0)(24));
FA_0_23_1 : FA port map (
	a => dadda_i(0)(3)(23),
	b => dadda_i(0)(4)(23),
	cin => dadda_i(0)(5)(23),
	s => dadda_i(1)(5)(23),
	cout => dadda_i(1)(1)(24));
FA_0_23_2 : FA port map (
	a => dadda_i(0)(6)(23),
	b => dadda_i(0)(7)(23),
	cin => dadda_i(0)(8)(23),
	s => dadda_i(1)(6)(23),
	cout => dadda_i(1)(2)(24));

HA_0_23_0 : HA port map (
	a => dadda_i(0)(9)(23),
	b => dadda_i(0)(10)(23),
	s => dadda_i(1)(7)(23),
	cout => dadda_i(1)(3)(24));

-- Numero non processati: 1
dadda_i(1)(8)(23) <= dadda_i(0)(11)(23);

FA_0_24_0 : FA port map (
	a => dadda_i(0)(0)(24),
	b => dadda_i(0)(1)(24),
	cin => dadda_i(0)(2)(24),
	s => dadda_i(1)(4)(24),
	cout => dadda_i(1)(0)(25));
FA_0_24_1 : FA port map (
	a => dadda_i(0)(3)(24),
	b => dadda_i(0)(4)(24),
	cin => dadda_i(0)(5)(24),
	s => dadda_i(1)(5)(24),
	cout => dadda_i(1)(1)(25));
FA_0_24_2 : FA port map (
	a => dadda_i(0)(6)(24),
	b => dadda_i(0)(7)(24),
	cin => dadda_i(0)(8)(24),
	s => dadda_i(1)(6)(24),
	cout => dadda_i(1)(2)(25));
FA_0_24_3 : FA port map (
	a => dadda_i(0)(9)(24),
	b => dadda_i(0)(10)(24),
	cin => dadda_i(0)(11)(24),
	s => dadda_i(1)(7)(24),
	cout => dadda_i(1)(3)(25));


-- Numero non processati: 1
dadda_i(1)(8)(24) <= dadda_i(0)(12)(24);

FA_0_25_0 : FA port map (
	a => dadda_i(0)(0)(25),
	b => dadda_i(0)(1)(25),
	cin => dadda_i(0)(2)(25),
	s => dadda_i(1)(4)(25),
	cout => dadda_i(1)(0)(26));
FA_0_25_1 : FA port map (
	a => dadda_i(0)(3)(25),
	b => dadda_i(0)(4)(25),
	cin => dadda_i(0)(5)(25),
	s => dadda_i(1)(5)(25),
	cout => dadda_i(1)(1)(26));
FA_0_25_2 : FA port map (
	a => dadda_i(0)(6)(25),
	b => dadda_i(0)(7)(25),
	cin => dadda_i(0)(8)(25),
	s => dadda_i(1)(6)(25),
	cout => dadda_i(1)(2)(26));
FA_0_25_3 : FA port map (
	a => dadda_i(0)(9)(25),
	b => dadda_i(0)(10)(25),
	cin => dadda_i(0)(11)(25),
	s => dadda_i(1)(7)(25),
	cout => dadda_i(1)(3)(26));


-- Numero non processati: 1
dadda_i(1)(8)(25) <= dadda_i(0)(12)(25);

FA_0_26_0 : FA port map (
	a => dadda_i(0)(0)(26),
	b => dadda_i(0)(1)(26),
	cin => dadda_i(0)(2)(26),
	s => dadda_i(1)(4)(26),
	cout => dadda_i(1)(0)(27));
FA_0_26_1 : FA port map (
	a => dadda_i(0)(3)(26),
	b => dadda_i(0)(4)(26),
	cin => dadda_i(0)(5)(26),
	s => dadda_i(1)(5)(26),
	cout => dadda_i(1)(1)(27));
FA_0_26_2 : FA port map (
	a => dadda_i(0)(6)(26),
	b => dadda_i(0)(7)(26),
	cin => dadda_i(0)(8)(26),
	s => dadda_i(1)(6)(26),
	cout => dadda_i(1)(2)(27));
FA_0_26_3 : FA port map (
	a => dadda_i(0)(9)(26),
	b => dadda_i(0)(10)(26),
	cin => dadda_i(0)(11)(26),
	s => dadda_i(1)(7)(26),
	cout => dadda_i(1)(3)(27));


-- Numero non processati: 1
dadda_i(1)(8)(26) <= dadda_i(0)(12)(26);

FA_0_27_0 : FA port map (
	a => dadda_i(0)(0)(27),
	b => dadda_i(0)(1)(27),
	cin => dadda_i(0)(2)(27),
	s => dadda_i(1)(4)(27),
	cout => dadda_i(1)(0)(28));
FA_0_27_1 : FA port map (
	a => dadda_i(0)(3)(27),
	b => dadda_i(0)(4)(27),
	cin => dadda_i(0)(5)(27),
	s => dadda_i(1)(5)(27),
	cout => dadda_i(1)(1)(28));
FA_0_27_2 : FA port map (
	a => dadda_i(0)(6)(27),
	b => dadda_i(0)(7)(27),
	cin => dadda_i(0)(8)(27),
	s => dadda_i(1)(6)(27),
	cout => dadda_i(1)(2)(28));
FA_0_27_3 : FA port map (
	a => dadda_i(0)(9)(27),
	b => dadda_i(0)(10)(27),
	cin => dadda_i(0)(11)(27),
	s => dadda_i(1)(7)(27),
	cout => dadda_i(1)(3)(28));


-- Numero non processati: 1
dadda_i(1)(8)(27) <= dadda_i(0)(12)(27);

FA_0_28_0 : FA port map (
	a => dadda_i(0)(0)(28),
	b => dadda_i(0)(1)(28),
	cin => dadda_i(0)(2)(28),
	s => dadda_i(1)(4)(28),
	cout => dadda_i(1)(0)(29));
FA_0_28_1 : FA port map (
	a => dadda_i(0)(3)(28),
	b => dadda_i(0)(4)(28),
	cin => dadda_i(0)(5)(28),
	s => dadda_i(1)(5)(28),
	cout => dadda_i(1)(1)(29));
FA_0_28_2 : FA port map (
	a => dadda_i(0)(6)(28),
	b => dadda_i(0)(7)(28),
	cin => dadda_i(0)(8)(28),
	s => dadda_i(1)(6)(28),
	cout => dadda_i(1)(2)(29));

HA_0_28_0 : HA port map (
	a => dadda_i(0)(9)(28),
	b => dadda_i(0)(10)(28),
	s => dadda_i(1)(7)(28),
	cout => dadda_i(1)(3)(29));

-- Numero non processati: 1
dadda_i(1)(8)(28) <= dadda_i(0)(11)(28);

FA_0_29_0 : FA port map (
	a => dadda_i(0)(0)(29),
	b => dadda_i(0)(1)(29),
	cin => dadda_i(0)(2)(29),
	s => dadda_i(1)(4)(29),
	cout => dadda_i(1)(0)(30));
FA_0_29_1 : FA port map (
	a => dadda_i(0)(3)(29),
	b => dadda_i(0)(4)(29),
	cin => dadda_i(0)(5)(29),
	s => dadda_i(1)(5)(29),
	cout => dadda_i(1)(1)(30));
FA_0_29_2 : FA port map (
	a => dadda_i(0)(6)(29),
	b => dadda_i(0)(7)(29),
	cin => dadda_i(0)(8)(29),
	s => dadda_i(1)(6)(29),
	cout => dadda_i(1)(2)(30));


-- Numero non processati: 2
dadda_i(1)(7)(29) <= dadda_i(0)(9)(29);
dadda_i(1)(8)(29) <= dadda_i(0)(10)(29);

FA_0_30_0 : FA port map (
	a => dadda_i(0)(0)(30),
	b => dadda_i(0)(1)(30),
	cin => dadda_i(0)(2)(30),
	s => dadda_i(1)(3)(30),
	cout => dadda_i(1)(0)(31));
FA_0_30_1 : FA port map (
	a => dadda_i(0)(3)(30),
	b => dadda_i(0)(4)(30),
	cin => dadda_i(0)(5)(30),
	s => dadda_i(1)(4)(30),
	cout => dadda_i(1)(1)(31));

HA_0_30_0 : HA port map (
	a => dadda_i(0)(6)(30),
	b => dadda_i(0)(7)(30),
	s => dadda_i(1)(5)(30),
	cout => dadda_i(1)(2)(31));

-- Numero non processati: 3
dadda_i(1)(6)(30) <= dadda_i(0)(8)(30);
dadda_i(1)(7)(30) <= dadda_i(0)(9)(30);
dadda_i(1)(8)(30) <= dadda_i(0)(10)(30);

FA_0_31_0 : FA port map (
	a => dadda_i(0)(0)(31),
	b => dadda_i(0)(1)(31),
	cin => dadda_i(0)(2)(31),
	s => dadda_i(1)(3)(31),
	cout => dadda_i(1)(0)(32));
FA_0_31_1 : FA port map (
	a => dadda_i(0)(3)(31),
	b => dadda_i(0)(4)(31),
	cin => dadda_i(0)(5)(31),
	s => dadda_i(1)(4)(31),
	cout => dadda_i(1)(1)(32));


-- Numero non processati: 4
dadda_i(1)(5)(31) <= dadda_i(0)(6)(31);
dadda_i(1)(6)(31) <= dadda_i(0)(7)(31);
dadda_i(1)(7)(31) <= dadda_i(0)(8)(31);
dadda_i(1)(8)(31) <= dadda_i(0)(9)(31);

FA_0_32_0 : FA port map (
	a => dadda_i(0)(0)(32),
	b => dadda_i(0)(1)(32),
	cin => dadda_i(0)(2)(32),
	s => dadda_i(1)(2)(32),
	cout => dadda_i(1)(0)(33));

HA_0_32_0 : HA port map (
	a => dadda_i(0)(3)(32),
	b => dadda_i(0)(4)(32),
	s => dadda_i(1)(3)(32),
	cout => dadda_i(1)(1)(33));

-- Numero non processati: 5
dadda_i(1)(4)(32) <= dadda_i(0)(5)(32);
dadda_i(1)(5)(32) <= dadda_i(0)(6)(32);
dadda_i(1)(6)(32) <= dadda_i(0)(7)(32);
dadda_i(1)(7)(32) <= dadda_i(0)(8)(32);
dadda_i(1)(8)(32) <= dadda_i(0)(9)(32);

FA_0_33_0 : FA port map (
	a => dadda_i(0)(0)(33),
	b => dadda_i(0)(1)(33),
	cin => dadda_i(0)(2)(33),
	s => dadda_i(1)(2)(33),
	cout => dadda_i(1)(0)(34));


-- Numero non processati: 6
dadda_i(1)(3)(33) <= dadda_i(0)(3)(33);
dadda_i(1)(4)(33) <= dadda_i(0)(4)(33);
dadda_i(1)(5)(33) <= dadda_i(0)(5)(33);
dadda_i(1)(6)(33) <= dadda_i(0)(6)(33);
dadda_i(1)(7)(33) <= dadda_i(0)(7)(33);
dadda_i(1)(8)(33) <= dadda_i(0)(8)(33);


HA_0_34_0 : HA port map (
	a => dadda_i(0)(0)(34),
	b => dadda_i(0)(1)(34),
	s => dadda_i(1)(1)(34),
	cout => dadda_i(1)(0)(35));

-- Numero non processati: 7
dadda_i(1)(2)(34) <= dadda_i(0)(2)(34);
dadda_i(1)(3)(34) <= dadda_i(0)(3)(34);
dadda_i(1)(4)(34) <= dadda_i(0)(4)(34);
dadda_i(1)(5)(34) <= dadda_i(0)(5)(34);
dadda_i(1)(6)(34) <= dadda_i(0)(6)(34);
dadda_i(1)(7)(34) <= dadda_i(0)(7)(34);
dadda_i(1)(8)(34) <= dadda_i(0)(8)(34);

-- Numero non processati: 6
dadda_i(1)(1)(35) <= dadda_i(0)(0)(35);
dadda_i(1)(2)(35) <= dadda_i(0)(1)(35);
dadda_i(1)(3)(35) <= dadda_i(0)(2)(35);
dadda_i(1)(4)(35) <= dadda_i(0)(3)(35);
dadda_i(1)(5)(35) <= dadda_i(0)(4)(35);
dadda_i(1)(6)(35) <= dadda_i(0)(5)(35);

-- Numero non processati: 6
dadda_i(1)(0)(36) <= dadda_i(0)(0)(36);
dadda_i(1)(1)(36) <= dadda_i(0)(1)(36);
dadda_i(1)(2)(36) <= dadda_i(0)(2)(36);
dadda_i(1)(3)(36) <= dadda_i(0)(3)(36);
dadda_i(1)(4)(36) <= dadda_i(0)(4)(36);
dadda_i(1)(5)(36) <= dadda_i(0)(5)(36);

-- Numero non processati: 7
dadda_i(1)(0)(37) <= dadda_i(0)(0)(37);
dadda_i(1)(1)(37) <= dadda_i(0)(1)(37);
dadda_i(1)(2)(37) <= dadda_i(0)(2)(37);
dadda_i(1)(3)(37) <= dadda_i(0)(3)(37);
dadda_i(1)(4)(37) <= dadda_i(0)(4)(37);
dadda_i(1)(5)(37) <= dadda_i(0)(5)(37);
dadda_i(1)(6)(37) <= dadda_i(0)(6)(37);

-- Numero non processati: 7
dadda_i(1)(0)(38) <= dadda_i(0)(0)(38);
dadda_i(1)(1)(38) <= dadda_i(0)(1)(38);
dadda_i(1)(2)(38) <= dadda_i(0)(2)(38);
dadda_i(1)(3)(38) <= dadda_i(0)(3)(38);
dadda_i(1)(4)(38) <= dadda_i(0)(4)(38);
dadda_i(1)(5)(38) <= dadda_i(0)(5)(38);
dadda_i(1)(6)(38) <= dadda_i(0)(6)(38);

-- Numero non processati: 6
dadda_i(1)(0)(39) <= dadda_i(0)(0)(39);
dadda_i(1)(1)(39) <= dadda_i(0)(1)(39);
dadda_i(1)(2)(39) <= dadda_i(0)(2)(39);
dadda_i(1)(3)(39) <= dadda_i(0)(3)(39);
dadda_i(1)(4)(39) <= dadda_i(0)(4)(39);
dadda_i(1)(5)(39) <= dadda_i(0)(5)(39);

-- Numero non processati: 6
dadda_i(1)(0)(40) <= dadda_i(0)(0)(40);
dadda_i(1)(1)(40) <= dadda_i(0)(1)(40);
dadda_i(1)(2)(40) <= dadda_i(0)(2)(40);
dadda_i(1)(3)(40) <= dadda_i(0)(3)(40);
dadda_i(1)(4)(40) <= dadda_i(0)(4)(40);
dadda_i(1)(5)(40) <= dadda_i(0)(5)(40);

-- Numero non processati: 5
dadda_i(1)(0)(41) <= dadda_i(0)(0)(41);
dadda_i(1)(1)(41) <= dadda_i(0)(1)(41);
dadda_i(1)(2)(41) <= dadda_i(0)(2)(41);
dadda_i(1)(3)(41) <= dadda_i(0)(3)(41);
dadda_i(1)(4)(41) <= dadda_i(0)(4)(41);

-- Numero non processati: 5
dadda_i(1)(0)(42) <= dadda_i(0)(0)(42);
dadda_i(1)(1)(42) <= dadda_i(0)(1)(42);
dadda_i(1)(2)(42) <= dadda_i(0)(2)(42);
dadda_i(1)(3)(42) <= dadda_i(0)(3)(42);
dadda_i(1)(4)(42) <= dadda_i(0)(4)(42);

-- Numero non processati: 4
dadda_i(1)(0)(43) <= dadda_i(0)(0)(43);
dadda_i(1)(1)(43) <= dadda_i(0)(1)(43);
dadda_i(1)(2)(43) <= dadda_i(0)(2)(43);
dadda_i(1)(3)(43) <= dadda_i(0)(3)(43);

-- Numero non processati: 4
dadda_i(1)(0)(44) <= dadda_i(0)(0)(44);
dadda_i(1)(1)(44) <= dadda_i(0)(1)(44);
dadda_i(1)(2)(44) <= dadda_i(0)(2)(44);
dadda_i(1)(3)(44) <= dadda_i(0)(3)(44);

-- Numero non processati: 3
dadda_i(1)(0)(45) <= dadda_i(0)(0)(45);
dadda_i(1)(1)(45) <= dadda_i(0)(1)(45);
dadda_i(1)(2)(45) <= dadda_i(0)(2)(45);

-- Numero non processati: 3
dadda_i(1)(0)(46) <= dadda_i(0)(0)(46);
dadda_i(1)(1)(46) <= dadda_i(0)(1)(46);
dadda_i(1)(2)(46) <= dadda_i(0)(2)(46);

-- Numero non processati: 2
dadda_i(1)(0)(47) <= dadda_i(0)(0)(47);
dadda_i(1)(1)(47) <= dadda_i(0)(1)(47);

-- Numero non processati: 2
dadda_i(2)(0)(0) <= dadda_i(1)(0)(0);
dadda_i(2)(1)(0) <= dadda_i(1)(1)(0);

-- Numero non processati: 1
dadda_i(2)(0)(1) <= dadda_i(1)(0)(1);

-- Numero non processati: 3
dadda_i(2)(0)(2) <= dadda_i(1)(0)(2);
dadda_i(2)(1)(2) <= dadda_i(1)(1)(2);
dadda_i(2)(2)(2) <= dadda_i(1)(2)(2);

-- Numero non processati: 2
dadda_i(2)(0)(3) <= dadda_i(1)(0)(3);
dadda_i(2)(1)(3) <= dadda_i(1)(1)(3);

-- Numero non processati: 4
dadda_i(2)(0)(4) <= dadda_i(1)(0)(4);
dadda_i(2)(1)(4) <= dadda_i(1)(1)(4);
dadda_i(2)(2)(4) <= dadda_i(1)(2)(4);
dadda_i(2)(3)(4) <= dadda_i(1)(3)(4);

-- Numero non processati: 3
dadda_i(2)(0)(5) <= dadda_i(1)(0)(5);
dadda_i(2)(1)(5) <= dadda_i(1)(1)(5);
dadda_i(2)(2)(5) <= dadda_i(1)(2)(5);

-- Numero non processati: 5
dadda_i(2)(0)(6) <= dadda_i(1)(0)(6);
dadda_i(2)(1)(6) <= dadda_i(1)(1)(6);
dadda_i(2)(2)(6) <= dadda_i(1)(2)(6);
dadda_i(2)(3)(6) <= dadda_i(1)(3)(6);
dadda_i(2)(4)(6) <= dadda_i(1)(4)(6);

-- Numero non processati: 4
dadda_i(2)(0)(7) <= dadda_i(1)(0)(7);
dadda_i(2)(1)(7) <= dadda_i(1)(1)(7);
dadda_i(2)(2)(7) <= dadda_i(1)(2)(7);
dadda_i(2)(3)(7) <= dadda_i(1)(3)(7);

-- Numero non processati: 6
dadda_i(2)(0)(8) <= dadda_i(1)(0)(8);
dadda_i(2)(1)(8) <= dadda_i(1)(1)(8);
dadda_i(2)(2)(8) <= dadda_i(1)(2)(8);
dadda_i(2)(3)(8) <= dadda_i(1)(3)(8);
dadda_i(2)(4)(8) <= dadda_i(1)(4)(8);
dadda_i(2)(5)(8) <= dadda_i(1)(5)(8);

-- Numero non processati: 5
dadda_i(2)(0)(9) <= dadda_i(1)(0)(9);
dadda_i(2)(1)(9) <= dadda_i(1)(1)(9);
dadda_i(2)(2)(9) <= dadda_i(1)(2)(9);
dadda_i(2)(3)(9) <= dadda_i(1)(3)(9);
dadda_i(2)(4)(9) <= dadda_i(1)(4)(9);


HA_1_10_0 : HA port map (
	a => dadda_i(1)(0)(10),
	b => dadda_i(1)(1)(10),
	s => dadda_i(2)(0)(10),
	cout => dadda_i(2)(0)(11));

-- Numero non processati: 5
dadda_i(2)(1)(10) <= dadda_i(1)(2)(10);
dadda_i(2)(2)(10) <= dadda_i(1)(3)(10);
dadda_i(2)(3)(10) <= dadda_i(1)(4)(10);
dadda_i(2)(4)(10) <= dadda_i(1)(5)(10);
dadda_i(2)(5)(10) <= dadda_i(1)(6)(10);


HA_1_11_0 : HA port map (
	a => dadda_i(1)(0)(11),
	b => dadda_i(1)(1)(11),
	s => dadda_i(2)(1)(11),
	cout => dadda_i(2)(0)(12));

-- Numero non processati: 4
dadda_i(2)(2)(11) <= dadda_i(1)(2)(11);
dadda_i(2)(3)(11) <= dadda_i(1)(3)(11);
dadda_i(2)(4)(11) <= dadda_i(1)(4)(11);
dadda_i(2)(5)(11) <= dadda_i(1)(5)(11);

FA_1_12_0 : FA port map (
	a => dadda_i(1)(0)(12),
	b => dadda_i(1)(1)(12),
	cin => dadda_i(1)(2)(12),
	s => dadda_i(2)(1)(12),
	cout => dadda_i(2)(0)(13));

HA_1_12_0 : HA port map (
	a => dadda_i(1)(3)(12),
	b => dadda_i(1)(4)(12),
	s => dadda_i(2)(2)(12),
	cout => dadda_i(2)(1)(13));

-- Numero non processati: 3
dadda_i(2)(3)(12) <= dadda_i(1)(5)(12);
dadda_i(2)(4)(12) <= dadda_i(1)(6)(12);
dadda_i(2)(5)(12) <= dadda_i(1)(7)(12);

FA_1_13_0 : FA port map (
	a => dadda_i(1)(0)(13),
	b => dadda_i(1)(1)(13),
	cin => dadda_i(1)(2)(13),
	s => dadda_i(2)(2)(13),
	cout => dadda_i(2)(0)(14));

HA_1_13_0 : HA port map (
	a => dadda_i(1)(3)(13),
	b => dadda_i(1)(4)(13),
	s => dadda_i(2)(3)(13),
	cout => dadda_i(2)(1)(14));

-- Numero non processati: 2
dadda_i(2)(4)(13) <= dadda_i(1)(5)(13);
dadda_i(2)(5)(13) <= dadda_i(1)(6)(13);

FA_1_14_0 : FA port map (
	a => dadda_i(1)(0)(14),
	b => dadda_i(1)(1)(14),
	cin => dadda_i(1)(2)(14),
	s => dadda_i(2)(2)(14),
	cout => dadda_i(2)(0)(15));
FA_1_14_1 : FA port map (
	a => dadda_i(1)(3)(14),
	b => dadda_i(1)(4)(14),
	cin => dadda_i(1)(5)(14),
	s => dadda_i(2)(3)(14),
	cout => dadda_i(2)(1)(15));

HA_1_14_0 : HA port map (
	a => dadda_i(1)(6)(14),
	b => dadda_i(1)(7)(14),
	s => dadda_i(2)(4)(14),
	cout => dadda_i(2)(2)(15));

-- Numero non processati: 1
dadda_i(2)(5)(14) <= dadda_i(1)(8)(14);

FA_1_15_0 : FA port map (
	a => dadda_i(1)(0)(15),
	b => dadda_i(1)(1)(15),
	cin => dadda_i(1)(2)(15),
	s => dadda_i(2)(3)(15),
	cout => dadda_i(2)(0)(16));
FA_1_15_1 : FA port map (
	a => dadda_i(1)(3)(15),
	b => dadda_i(1)(4)(15),
	cin => dadda_i(1)(5)(15),
	s => dadda_i(2)(4)(15),
	cout => dadda_i(2)(1)(16));

HA_1_15_0 : HA port map (
	a => dadda_i(1)(6)(15),
	b => dadda_i(1)(7)(15),
	s => dadda_i(2)(5)(15),
	cout => dadda_i(2)(2)(16));

-- Numero non processati: 0

FA_1_16_0 : FA port map (
	a => dadda_i(1)(0)(16),
	b => dadda_i(1)(1)(16),
	cin => dadda_i(1)(2)(16),
	s => dadda_i(2)(3)(16),
	cout => dadda_i(2)(0)(17));
FA_1_16_1 : FA port map (
	a => dadda_i(1)(3)(16),
	b => dadda_i(1)(4)(16),
	cin => dadda_i(1)(5)(16),
	s => dadda_i(2)(4)(16),
	cout => dadda_i(2)(1)(17));
FA_1_16_2 : FA port map (
	a => dadda_i(1)(6)(16),
	b => dadda_i(1)(7)(16),
	cin => dadda_i(1)(8)(16),
	s => dadda_i(2)(5)(16),
	cout => dadda_i(2)(2)(17));


-- Numero non processati: 0

FA_1_17_0 : FA port map (
	a => dadda_i(1)(0)(17),
	b => dadda_i(1)(1)(17),
	cin => dadda_i(1)(2)(17),
	s => dadda_i(2)(3)(17),
	cout => dadda_i(2)(0)(18));
FA_1_17_1 : FA port map (
	a => dadda_i(1)(3)(17),
	b => dadda_i(1)(4)(17),
	cin => dadda_i(1)(5)(17),
	s => dadda_i(2)(4)(17),
	cout => dadda_i(2)(1)(18));
FA_1_17_2 : FA port map (
	a => dadda_i(1)(6)(17),
	b => dadda_i(1)(7)(17),
	cin => dadda_i(1)(8)(17),
	s => dadda_i(2)(5)(17),
	cout => dadda_i(2)(2)(18));


-- Numero non processati: 0

FA_1_18_0 : FA port map (
	a => dadda_i(1)(0)(18),
	b => dadda_i(1)(1)(18),
	cin => dadda_i(1)(2)(18),
	s => dadda_i(2)(3)(18),
	cout => dadda_i(2)(0)(19));
FA_1_18_1 : FA port map (
	a => dadda_i(1)(3)(18),
	b => dadda_i(1)(4)(18),
	cin => dadda_i(1)(5)(18),
	s => dadda_i(2)(4)(18),
	cout => dadda_i(2)(1)(19));
FA_1_18_2 : FA port map (
	a => dadda_i(1)(6)(18),
	b => dadda_i(1)(7)(18),
	cin => dadda_i(1)(8)(18),
	s => dadda_i(2)(5)(18),
	cout => dadda_i(2)(2)(19));


-- Numero non processati: 0

FA_1_19_0 : FA port map (
	a => dadda_i(1)(0)(19),
	b => dadda_i(1)(1)(19),
	cin => dadda_i(1)(2)(19),
	s => dadda_i(2)(3)(19),
	cout => dadda_i(2)(0)(20));
FA_1_19_1 : FA port map (
	a => dadda_i(1)(3)(19),
	b => dadda_i(1)(4)(19),
	cin => dadda_i(1)(5)(19),
	s => dadda_i(2)(4)(19),
	cout => dadda_i(2)(1)(20));
FA_1_19_2 : FA port map (
	a => dadda_i(1)(6)(19),
	b => dadda_i(1)(7)(19),
	cin => dadda_i(1)(8)(19),
	s => dadda_i(2)(5)(19),
	cout => dadda_i(2)(2)(20));


-- Numero non processati: 0

FA_1_20_0 : FA port map (
	a => dadda_i(1)(0)(20),
	b => dadda_i(1)(1)(20),
	cin => dadda_i(1)(2)(20),
	s => dadda_i(2)(3)(20),
	cout => dadda_i(2)(0)(21));
FA_1_20_1 : FA port map (
	a => dadda_i(1)(3)(20),
	b => dadda_i(1)(4)(20),
	cin => dadda_i(1)(5)(20),
	s => dadda_i(2)(4)(20),
	cout => dadda_i(2)(1)(21));
FA_1_20_2 : FA port map (
	a => dadda_i(1)(6)(20),
	b => dadda_i(1)(7)(20),
	cin => dadda_i(1)(8)(20),
	s => dadda_i(2)(5)(20),
	cout => dadda_i(2)(2)(21));


-- Numero non processati: 0

FA_1_21_0 : FA port map (
	a => dadda_i(1)(0)(21),
	b => dadda_i(1)(1)(21),
	cin => dadda_i(1)(2)(21),
	s => dadda_i(2)(3)(21),
	cout => dadda_i(2)(0)(22));
FA_1_21_1 : FA port map (
	a => dadda_i(1)(3)(21),
	b => dadda_i(1)(4)(21),
	cin => dadda_i(1)(5)(21),
	s => dadda_i(2)(4)(21),
	cout => dadda_i(2)(1)(22));
FA_1_21_2 : FA port map (
	a => dadda_i(1)(6)(21),
	b => dadda_i(1)(7)(21),
	cin => dadda_i(1)(8)(21),
	s => dadda_i(2)(5)(21),
	cout => dadda_i(2)(2)(22));


-- Numero non processati: 0

FA_1_22_0 : FA port map (
	a => dadda_i(1)(0)(22),
	b => dadda_i(1)(1)(22),
	cin => dadda_i(1)(2)(22),
	s => dadda_i(2)(3)(22),
	cout => dadda_i(2)(0)(23));
FA_1_22_1 : FA port map (
	a => dadda_i(1)(3)(22),
	b => dadda_i(1)(4)(22),
	cin => dadda_i(1)(5)(22),
	s => dadda_i(2)(4)(22),
	cout => dadda_i(2)(1)(23));
FA_1_22_2 : FA port map (
	a => dadda_i(1)(6)(22),
	b => dadda_i(1)(7)(22),
	cin => dadda_i(1)(8)(22),
	s => dadda_i(2)(5)(22),
	cout => dadda_i(2)(2)(23));


-- Numero non processati: 0

FA_1_23_0 : FA port map (
	a => dadda_i(1)(0)(23),
	b => dadda_i(1)(1)(23),
	cin => dadda_i(1)(2)(23),
	s => dadda_i(2)(3)(23),
	cout => dadda_i(2)(0)(24));
FA_1_23_1 : FA port map (
	a => dadda_i(1)(3)(23),
	b => dadda_i(1)(4)(23),
	cin => dadda_i(1)(5)(23),
	s => dadda_i(2)(4)(23),
	cout => dadda_i(2)(1)(24));
FA_1_23_2 : FA port map (
	a => dadda_i(1)(6)(23),
	b => dadda_i(1)(7)(23),
	cin => dadda_i(1)(8)(23),
	s => dadda_i(2)(5)(23),
	cout => dadda_i(2)(2)(24));


-- Numero non processati: 0

FA_1_24_0 : FA port map (
	a => dadda_i(1)(0)(24),
	b => dadda_i(1)(1)(24),
	cin => dadda_i(1)(2)(24),
	s => dadda_i(2)(3)(24),
	cout => dadda_i(2)(0)(25));
FA_1_24_1 : FA port map (
	a => dadda_i(1)(3)(24),
	b => dadda_i(1)(4)(24),
	cin => dadda_i(1)(5)(24),
	s => dadda_i(2)(4)(24),
	cout => dadda_i(2)(1)(25));
FA_1_24_2 : FA port map (
	a => dadda_i(1)(6)(24),
	b => dadda_i(1)(7)(24),
	cin => dadda_i(1)(8)(24),
	s => dadda_i(2)(5)(24),
	cout => dadda_i(2)(2)(25));


-- Numero non processati: 0

FA_1_25_0 : FA port map (
	a => dadda_i(1)(0)(25),
	b => dadda_i(1)(1)(25),
	cin => dadda_i(1)(2)(25),
	s => dadda_i(2)(3)(25),
	cout => dadda_i(2)(0)(26));
FA_1_25_1 : FA port map (
	a => dadda_i(1)(3)(25),
	b => dadda_i(1)(4)(25),
	cin => dadda_i(1)(5)(25),
	s => dadda_i(2)(4)(25),
	cout => dadda_i(2)(1)(26));
FA_1_25_2 : FA port map (
	a => dadda_i(1)(6)(25),
	b => dadda_i(1)(7)(25),
	cin => dadda_i(1)(8)(25),
	s => dadda_i(2)(5)(25),
	cout => dadda_i(2)(2)(26));


-- Numero non processati: 0

FA_1_26_0 : FA port map (
	a => dadda_i(1)(0)(26),
	b => dadda_i(1)(1)(26),
	cin => dadda_i(1)(2)(26),
	s => dadda_i(2)(3)(26),
	cout => dadda_i(2)(0)(27));
FA_1_26_1 : FA port map (
	a => dadda_i(1)(3)(26),
	b => dadda_i(1)(4)(26),
	cin => dadda_i(1)(5)(26),
	s => dadda_i(2)(4)(26),
	cout => dadda_i(2)(1)(27));
FA_1_26_2 : FA port map (
	a => dadda_i(1)(6)(26),
	b => dadda_i(1)(7)(26),
	cin => dadda_i(1)(8)(26),
	s => dadda_i(2)(5)(26),
	cout => dadda_i(2)(2)(27));


-- Numero non processati: 0

FA_1_27_0 : FA port map (
	a => dadda_i(1)(0)(27),
	b => dadda_i(1)(1)(27),
	cin => dadda_i(1)(2)(27),
	s => dadda_i(2)(3)(27),
	cout => dadda_i(2)(0)(28));
FA_1_27_1 : FA port map (
	a => dadda_i(1)(3)(27),
	b => dadda_i(1)(4)(27),
	cin => dadda_i(1)(5)(27),
	s => dadda_i(2)(4)(27),
	cout => dadda_i(2)(1)(28));
FA_1_27_2 : FA port map (
	a => dadda_i(1)(6)(27),
	b => dadda_i(1)(7)(27),
	cin => dadda_i(1)(8)(27),
	s => dadda_i(2)(5)(27),
	cout => dadda_i(2)(2)(28));


-- Numero non processati: 0

FA_1_28_0 : FA port map (
	a => dadda_i(1)(0)(28),
	b => dadda_i(1)(1)(28),
	cin => dadda_i(1)(2)(28),
	s => dadda_i(2)(3)(28),
	cout => dadda_i(2)(0)(29));
FA_1_28_1 : FA port map (
	a => dadda_i(1)(3)(28),
	b => dadda_i(1)(4)(28),
	cin => dadda_i(1)(5)(28),
	s => dadda_i(2)(4)(28),
	cout => dadda_i(2)(1)(29));
FA_1_28_2 : FA port map (
	a => dadda_i(1)(6)(28),
	b => dadda_i(1)(7)(28),
	cin => dadda_i(1)(8)(28),
	s => dadda_i(2)(5)(28),
	cout => dadda_i(2)(2)(29));


-- Numero non processati: 0

FA_1_29_0 : FA port map (
	a => dadda_i(1)(0)(29),
	b => dadda_i(1)(1)(29),
	cin => dadda_i(1)(2)(29),
	s => dadda_i(2)(3)(29),
	cout => dadda_i(2)(0)(30));
FA_1_29_1 : FA port map (
	a => dadda_i(1)(3)(29),
	b => dadda_i(1)(4)(29),
	cin => dadda_i(1)(5)(29),
	s => dadda_i(2)(4)(29),
	cout => dadda_i(2)(1)(30));
FA_1_29_2 : FA port map (
	a => dadda_i(1)(6)(29),
	b => dadda_i(1)(7)(29),
	cin => dadda_i(1)(8)(29),
	s => dadda_i(2)(5)(29),
	cout => dadda_i(2)(2)(30));


-- Numero non processati: 0

FA_1_30_0 : FA port map (
	a => dadda_i(1)(0)(30),
	b => dadda_i(1)(1)(30),
	cin => dadda_i(1)(2)(30),
	s => dadda_i(2)(3)(30),
	cout => dadda_i(2)(0)(31));
FA_1_30_1 : FA port map (
	a => dadda_i(1)(3)(30),
	b => dadda_i(1)(4)(30),
	cin => dadda_i(1)(5)(30),
	s => dadda_i(2)(4)(30),
	cout => dadda_i(2)(1)(31));
FA_1_30_2 : FA port map (
	a => dadda_i(1)(6)(30),
	b => dadda_i(1)(7)(30),
	cin => dadda_i(1)(8)(30),
	s => dadda_i(2)(5)(30),
	cout => dadda_i(2)(2)(31));


-- Numero non processati: 0

FA_1_31_0 : FA port map (
	a => dadda_i(1)(0)(31),
	b => dadda_i(1)(1)(31),
	cin => dadda_i(1)(2)(31),
	s => dadda_i(2)(3)(31),
	cout => dadda_i(2)(0)(32));
FA_1_31_1 : FA port map (
	a => dadda_i(1)(3)(31),
	b => dadda_i(1)(4)(31),
	cin => dadda_i(1)(5)(31),
	s => dadda_i(2)(4)(31),
	cout => dadda_i(2)(1)(32));
FA_1_31_2 : FA port map (
	a => dadda_i(1)(6)(31),
	b => dadda_i(1)(7)(31),
	cin => dadda_i(1)(8)(31),
	s => dadda_i(2)(5)(31),
	cout => dadda_i(2)(2)(32));


-- Numero non processati: 0

FA_1_32_0 : FA port map (
	a => dadda_i(1)(0)(32),
	b => dadda_i(1)(1)(32),
	cin => dadda_i(1)(2)(32),
	s => dadda_i(2)(3)(32),
	cout => dadda_i(2)(0)(33));
FA_1_32_1 : FA port map (
	a => dadda_i(1)(3)(32),
	b => dadda_i(1)(4)(32),
	cin => dadda_i(1)(5)(32),
	s => dadda_i(2)(4)(32),
	cout => dadda_i(2)(1)(33));
FA_1_32_2 : FA port map (
	a => dadda_i(1)(6)(32),
	b => dadda_i(1)(7)(32),
	cin => dadda_i(1)(8)(32),
	s => dadda_i(2)(5)(32),
	cout => dadda_i(2)(2)(33));


-- Numero non processati: 0

FA_1_33_0 : FA port map (
	a => dadda_i(1)(0)(33),
	b => dadda_i(1)(1)(33),
	cin => dadda_i(1)(2)(33),
	s => dadda_i(2)(3)(33),
	cout => dadda_i(2)(0)(34));
FA_1_33_1 : FA port map (
	a => dadda_i(1)(3)(33),
	b => dadda_i(1)(4)(33),
	cin => dadda_i(1)(5)(33),
	s => dadda_i(2)(4)(33),
	cout => dadda_i(2)(1)(34));
FA_1_33_2 : FA port map (
	a => dadda_i(1)(6)(33),
	b => dadda_i(1)(7)(33),
	cin => dadda_i(1)(8)(33),
	s => dadda_i(2)(5)(33),
	cout => dadda_i(2)(2)(34));


-- Numero non processati: 0

FA_1_34_0 : FA port map (
	a => dadda_i(1)(0)(34),
	b => dadda_i(1)(1)(34),
	cin => dadda_i(1)(2)(34),
	s => dadda_i(2)(3)(34),
	cout => dadda_i(2)(0)(35));
FA_1_34_1 : FA port map (
	a => dadda_i(1)(3)(34),
	b => dadda_i(1)(4)(34),
	cin => dadda_i(1)(5)(34),
	s => dadda_i(2)(4)(34),
	cout => dadda_i(2)(1)(35));
FA_1_34_2 : FA port map (
	a => dadda_i(1)(6)(34),
	b => dadda_i(1)(7)(34),
	cin => dadda_i(1)(8)(34),
	s => dadda_i(2)(5)(34),
	cout => dadda_i(2)(2)(35));


-- Numero non processati: 0

FA_1_35_0 : FA port map (
	a => dadda_i(1)(0)(35),
	b => dadda_i(1)(1)(35),
	cin => dadda_i(1)(2)(35),
	s => dadda_i(2)(3)(35),
	cout => dadda_i(2)(0)(36));
FA_1_35_1 : FA port map (
	a => dadda_i(1)(3)(35),
	b => dadda_i(1)(4)(35),
	cin => dadda_i(1)(5)(35),
	s => dadda_i(2)(4)(35),
	cout => dadda_i(2)(1)(36));


-- Numero non processati: 1
dadda_i(2)(5)(35) <= dadda_i(1)(6)(35);

FA_1_36_0 : FA port map (
	a => dadda_i(1)(0)(36),
	b => dadda_i(1)(1)(36),
	cin => dadda_i(1)(2)(36),
	s => dadda_i(2)(2)(36),
	cout => dadda_i(2)(0)(37));


-- Numero non processati: 3
dadda_i(2)(3)(36) <= dadda_i(1)(3)(36);
dadda_i(2)(4)(36) <= dadda_i(1)(4)(36);
dadda_i(2)(5)(36) <= dadda_i(1)(5)(36);

FA_1_37_0 : FA port map (
	a => dadda_i(1)(0)(37),
	b => dadda_i(1)(1)(37),
	cin => dadda_i(1)(2)(37),
	s => dadda_i(2)(1)(37),
	cout => dadda_i(2)(0)(38));


-- Numero non processati: 4
dadda_i(2)(2)(37) <= dadda_i(1)(3)(37);
dadda_i(2)(3)(37) <= dadda_i(1)(4)(37);
dadda_i(2)(4)(37) <= dadda_i(1)(5)(37);
dadda_i(2)(5)(37) <= dadda_i(1)(6)(37);

FA_1_38_0 : FA port map (
	a => dadda_i(1)(0)(38),
	b => dadda_i(1)(1)(38),
	cin => dadda_i(1)(2)(38),
	s => dadda_i(2)(1)(38),
	cout => dadda_i(2)(0)(39));


-- Numero non processati: 4
dadda_i(2)(2)(38) <= dadda_i(1)(3)(38);
dadda_i(2)(3)(38) <= dadda_i(1)(4)(38);
dadda_i(2)(4)(38) <= dadda_i(1)(5)(38);
dadda_i(2)(5)(38) <= dadda_i(1)(6)(38);


HA_1_39_0 : HA port map (
	a => dadda_i(1)(0)(39),
	b => dadda_i(1)(1)(39),
	s => dadda_i(2)(1)(39),
	cout => dadda_i(2)(0)(40));

-- Numero non processati: 4
dadda_i(2)(2)(39) <= dadda_i(1)(2)(39);
dadda_i(2)(3)(39) <= dadda_i(1)(3)(39);
dadda_i(2)(4)(39) <= dadda_i(1)(4)(39);
dadda_i(2)(5)(39) <= dadda_i(1)(5)(39);


HA_1_40_0 : HA port map (
	a => dadda_i(1)(0)(40),
	b => dadda_i(1)(1)(40),
	s => dadda_i(2)(1)(40),
	cout => dadda_i(2)(0)(41));

-- Numero non processati: 4
dadda_i(2)(2)(40) <= dadda_i(1)(2)(40);
dadda_i(2)(3)(40) <= dadda_i(1)(3)(40);
dadda_i(2)(4)(40) <= dadda_i(1)(4)(40);
dadda_i(2)(5)(40) <= dadda_i(1)(5)(40);

-- Numero non processati: 5
dadda_i(2)(1)(41) <= dadda_i(1)(0)(41);
dadda_i(2)(2)(41) <= dadda_i(1)(1)(41);
dadda_i(2)(3)(41) <= dadda_i(1)(2)(41);
dadda_i(2)(4)(41) <= dadda_i(1)(3)(41);
dadda_i(2)(5)(41) <= dadda_i(1)(4)(41);

-- Numero non processati: 5
dadda_i(2)(0)(42) <= dadda_i(1)(0)(42);
dadda_i(2)(1)(42) <= dadda_i(1)(1)(42);
dadda_i(2)(2)(42) <= dadda_i(1)(2)(42);
dadda_i(2)(3)(42) <= dadda_i(1)(3)(42);
dadda_i(2)(4)(42) <= dadda_i(1)(4)(42);

-- Numero non processati: 4
dadda_i(2)(0)(43) <= dadda_i(1)(0)(43);
dadda_i(2)(1)(43) <= dadda_i(1)(1)(43);
dadda_i(2)(2)(43) <= dadda_i(1)(2)(43);
dadda_i(2)(3)(43) <= dadda_i(1)(3)(43);

-- Numero non processati: 4
dadda_i(2)(0)(44) <= dadda_i(1)(0)(44);
dadda_i(2)(1)(44) <= dadda_i(1)(1)(44);
dadda_i(2)(2)(44) <= dadda_i(1)(2)(44);
dadda_i(2)(3)(44) <= dadda_i(1)(3)(44);

-- Numero non processati: 3
dadda_i(2)(0)(45) <= dadda_i(1)(0)(45);
dadda_i(2)(1)(45) <= dadda_i(1)(1)(45);
dadda_i(2)(2)(45) <= dadda_i(1)(2)(45);

-- Numero non processati: 3
dadda_i(2)(0)(46) <= dadda_i(1)(0)(46);
dadda_i(2)(1)(46) <= dadda_i(1)(1)(46);
dadda_i(2)(2)(46) <= dadda_i(1)(2)(46);

-- Numero non processati: 2
dadda_i(2)(0)(47) <= dadda_i(1)(0)(47);
dadda_i(2)(1)(47) <= dadda_i(1)(1)(47);

-- Numero non processati: 2
dadda_i(3)(0)(0) <= dadda_i(2)(0)(0);
dadda_i(3)(1)(0) <= dadda_i(2)(1)(0);

-- Numero non processati: 1
dadda_i(3)(0)(1) <= dadda_i(2)(0)(1);

-- Numero non processati: 3
dadda_i(3)(0)(2) <= dadda_i(2)(0)(2);
dadda_i(3)(1)(2) <= dadda_i(2)(1)(2);
dadda_i(3)(2)(2) <= dadda_i(2)(2)(2);

-- Numero non processati: 2
dadda_i(3)(0)(3) <= dadda_i(2)(0)(3);
dadda_i(3)(1)(3) <= dadda_i(2)(1)(3);

-- Numero non processati: 4
dadda_i(3)(0)(4) <= dadda_i(2)(0)(4);
dadda_i(3)(1)(4) <= dadda_i(2)(1)(4);
dadda_i(3)(2)(4) <= dadda_i(2)(2)(4);
dadda_i(3)(3)(4) <= dadda_i(2)(3)(4);

-- Numero non processati: 3
dadda_i(3)(0)(5) <= dadda_i(2)(0)(5);
dadda_i(3)(1)(5) <= dadda_i(2)(1)(5);
dadda_i(3)(2)(5) <= dadda_i(2)(2)(5);


HA_2_6_0 : HA port map (
	a => dadda_i(2)(0)(6),
	b => dadda_i(2)(1)(6),
	s => dadda_i(3)(0)(6),
	cout => dadda_i(3)(0)(7));

-- Numero non processati: 3
dadda_i(3)(1)(6) <= dadda_i(2)(2)(6);
dadda_i(3)(2)(6) <= dadda_i(2)(3)(6);
dadda_i(3)(3)(6) <= dadda_i(2)(4)(6);


HA_2_7_0 : HA port map (
	a => dadda_i(2)(0)(7),
	b => dadda_i(2)(1)(7),
	s => dadda_i(3)(1)(7),
	cout => dadda_i(3)(0)(8));

-- Numero non processati: 2
dadda_i(3)(2)(7) <= dadda_i(2)(2)(7);
dadda_i(3)(3)(7) <= dadda_i(2)(3)(7);

FA_2_8_0 : FA port map (
	a => dadda_i(2)(0)(8),
	b => dadda_i(2)(1)(8),
	cin => dadda_i(2)(2)(8),
	s => dadda_i(3)(1)(8),
	cout => dadda_i(3)(0)(9));

HA_2_8_0 : HA port map (
	a => dadda_i(2)(3)(8),
	b => dadda_i(2)(4)(8),
	s => dadda_i(3)(2)(8),
	cout => dadda_i(3)(1)(9));

-- Numero non processati: 1
dadda_i(3)(3)(8) <= dadda_i(2)(5)(8);

FA_2_9_0 : FA port map (
	a => dadda_i(2)(0)(9),
	b => dadda_i(2)(1)(9),
	cin => dadda_i(2)(2)(9),
	s => dadda_i(3)(2)(9),
	cout => dadda_i(3)(0)(10));

HA_2_9_0 : HA port map (
	a => dadda_i(2)(3)(9),
	b => dadda_i(2)(4)(9),
	s => dadda_i(3)(3)(9),
	cout => dadda_i(3)(1)(10));

-- Numero non processati: 0

FA_2_10_0 : FA port map (
	a => dadda_i(2)(0)(10),
	b => dadda_i(2)(1)(10),
	cin => dadda_i(2)(2)(10),
	s => dadda_i(3)(2)(10),
	cout => dadda_i(3)(0)(11));
FA_2_10_1 : FA port map (
	a => dadda_i(2)(3)(10),
	b => dadda_i(2)(4)(10),
	cin => dadda_i(2)(5)(10),
	s => dadda_i(3)(3)(10),
	cout => dadda_i(3)(1)(11));


-- Numero non processati: 0

FA_2_11_0 : FA port map (
	a => dadda_i(2)(0)(11),
	b => dadda_i(2)(1)(11),
	cin => dadda_i(2)(2)(11),
	s => dadda_i(3)(2)(11),
	cout => dadda_i(3)(0)(12));
FA_2_11_1 : FA port map (
	a => dadda_i(2)(3)(11),
	b => dadda_i(2)(4)(11),
	cin => dadda_i(2)(5)(11),
	s => dadda_i(3)(3)(11),
	cout => dadda_i(3)(1)(12));


-- Numero non processati: 0

FA_2_12_0 : FA port map (
	a => dadda_i(2)(0)(12),
	b => dadda_i(2)(1)(12),
	cin => dadda_i(2)(2)(12),
	s => dadda_i(3)(2)(12),
	cout => dadda_i(3)(0)(13));
FA_2_12_1 : FA port map (
	a => dadda_i(2)(3)(12),
	b => dadda_i(2)(4)(12),
	cin => dadda_i(2)(5)(12),
	s => dadda_i(3)(3)(12),
	cout => dadda_i(3)(1)(13));


-- Numero non processati: 0

FA_2_13_0 : FA port map (
	a => dadda_i(2)(0)(13),
	b => dadda_i(2)(1)(13),
	cin => dadda_i(2)(2)(13),
	s => dadda_i(3)(2)(13),
	cout => dadda_i(3)(0)(14));
FA_2_13_1 : FA port map (
	a => dadda_i(2)(3)(13),
	b => dadda_i(2)(4)(13),
	cin => dadda_i(2)(5)(13),
	s => dadda_i(3)(3)(13),
	cout => dadda_i(3)(1)(14));


-- Numero non processati: 0

FA_2_14_0 : FA port map (
	a => dadda_i(2)(0)(14),
	b => dadda_i(2)(1)(14),
	cin => dadda_i(2)(2)(14),
	s => dadda_i(3)(2)(14),
	cout => dadda_i(3)(0)(15));
FA_2_14_1 : FA port map (
	a => dadda_i(2)(3)(14),
	b => dadda_i(2)(4)(14),
	cin => dadda_i(2)(5)(14),
	s => dadda_i(3)(3)(14),
	cout => dadda_i(3)(1)(15));


-- Numero non processati: 0

FA_2_15_0 : FA port map (
	a => dadda_i(2)(0)(15),
	b => dadda_i(2)(1)(15),
	cin => dadda_i(2)(2)(15),
	s => dadda_i(3)(2)(15),
	cout => dadda_i(3)(0)(16));
FA_2_15_1 : FA port map (
	a => dadda_i(2)(3)(15),
	b => dadda_i(2)(4)(15),
	cin => dadda_i(2)(5)(15),
	s => dadda_i(3)(3)(15),
	cout => dadda_i(3)(1)(16));


-- Numero non processati: 0

FA_2_16_0 : FA port map (
	a => dadda_i(2)(0)(16),
	b => dadda_i(2)(1)(16),
	cin => dadda_i(2)(2)(16),
	s => dadda_i(3)(2)(16),
	cout => dadda_i(3)(0)(17));
FA_2_16_1 : FA port map (
	a => dadda_i(2)(3)(16),
	b => dadda_i(2)(4)(16),
	cin => dadda_i(2)(5)(16),
	s => dadda_i(3)(3)(16),
	cout => dadda_i(3)(1)(17));


-- Numero non processati: 0

FA_2_17_0 : FA port map (
	a => dadda_i(2)(0)(17),
	b => dadda_i(2)(1)(17),
	cin => dadda_i(2)(2)(17),
	s => dadda_i(3)(2)(17),
	cout => dadda_i(3)(0)(18));
FA_2_17_1 : FA port map (
	a => dadda_i(2)(3)(17),
	b => dadda_i(2)(4)(17),
	cin => dadda_i(2)(5)(17),
	s => dadda_i(3)(3)(17),
	cout => dadda_i(3)(1)(18));


-- Numero non processati: 0

FA_2_18_0 : FA port map (
	a => dadda_i(2)(0)(18),
	b => dadda_i(2)(1)(18),
	cin => dadda_i(2)(2)(18),
	s => dadda_i(3)(2)(18),
	cout => dadda_i(3)(0)(19));
FA_2_18_1 : FA port map (
	a => dadda_i(2)(3)(18),
	b => dadda_i(2)(4)(18),
	cin => dadda_i(2)(5)(18),
	s => dadda_i(3)(3)(18),
	cout => dadda_i(3)(1)(19));


-- Numero non processati: 0

FA_2_19_0 : FA port map (
	a => dadda_i(2)(0)(19),
	b => dadda_i(2)(1)(19),
	cin => dadda_i(2)(2)(19),
	s => dadda_i(3)(2)(19),
	cout => dadda_i(3)(0)(20));
FA_2_19_1 : FA port map (
	a => dadda_i(2)(3)(19),
	b => dadda_i(2)(4)(19),
	cin => dadda_i(2)(5)(19),
	s => dadda_i(3)(3)(19),
	cout => dadda_i(3)(1)(20));


-- Numero non processati: 0

FA_2_20_0 : FA port map (
	a => dadda_i(2)(0)(20),
	b => dadda_i(2)(1)(20),
	cin => dadda_i(2)(2)(20),
	s => dadda_i(3)(2)(20),
	cout => dadda_i(3)(0)(21));
FA_2_20_1 : FA port map (
	a => dadda_i(2)(3)(20),
	b => dadda_i(2)(4)(20),
	cin => dadda_i(2)(5)(20),
	s => dadda_i(3)(3)(20),
	cout => dadda_i(3)(1)(21));


-- Numero non processati: 0

FA_2_21_0 : FA port map (
	a => dadda_i(2)(0)(21),
	b => dadda_i(2)(1)(21),
	cin => dadda_i(2)(2)(21),
	s => dadda_i(3)(2)(21),
	cout => dadda_i(3)(0)(22));
FA_2_21_1 : FA port map (
	a => dadda_i(2)(3)(21),
	b => dadda_i(2)(4)(21),
	cin => dadda_i(2)(5)(21),
	s => dadda_i(3)(3)(21),
	cout => dadda_i(3)(1)(22));


-- Numero non processati: 0

FA_2_22_0 : FA port map (
	a => dadda_i(2)(0)(22),
	b => dadda_i(2)(1)(22),
	cin => dadda_i(2)(2)(22),
	s => dadda_i(3)(2)(22),
	cout => dadda_i(3)(0)(23));
FA_2_22_1 : FA port map (
	a => dadda_i(2)(3)(22),
	b => dadda_i(2)(4)(22),
	cin => dadda_i(2)(5)(22),
	s => dadda_i(3)(3)(22),
	cout => dadda_i(3)(1)(23));


-- Numero non processati: 0

FA_2_23_0 : FA port map (
	a => dadda_i(2)(0)(23),
	b => dadda_i(2)(1)(23),
	cin => dadda_i(2)(2)(23),
	s => dadda_i(3)(2)(23),
	cout => dadda_i(3)(0)(24));
FA_2_23_1 : FA port map (
	a => dadda_i(2)(3)(23),
	b => dadda_i(2)(4)(23),
	cin => dadda_i(2)(5)(23),
	s => dadda_i(3)(3)(23),
	cout => dadda_i(3)(1)(24));


-- Numero non processati: 0

FA_2_24_0 : FA port map (
	a => dadda_i(2)(0)(24),
	b => dadda_i(2)(1)(24),
	cin => dadda_i(2)(2)(24),
	s => dadda_i(3)(2)(24),
	cout => dadda_i(3)(0)(25));
FA_2_24_1 : FA port map (
	a => dadda_i(2)(3)(24),
	b => dadda_i(2)(4)(24),
	cin => dadda_i(2)(5)(24),
	s => dadda_i(3)(3)(24),
	cout => dadda_i(3)(1)(25));


-- Numero non processati: 0

FA_2_25_0 : FA port map (
	a => dadda_i(2)(0)(25),
	b => dadda_i(2)(1)(25),
	cin => dadda_i(2)(2)(25),
	s => dadda_i(3)(2)(25),
	cout => dadda_i(3)(0)(26));
FA_2_25_1 : FA port map (
	a => dadda_i(2)(3)(25),
	b => dadda_i(2)(4)(25),
	cin => dadda_i(2)(5)(25),
	s => dadda_i(3)(3)(25),
	cout => dadda_i(3)(1)(26));


-- Numero non processati: 0

FA_2_26_0 : FA port map (
	a => dadda_i(2)(0)(26),
	b => dadda_i(2)(1)(26),
	cin => dadda_i(2)(2)(26),
	s => dadda_i(3)(2)(26),
	cout => dadda_i(3)(0)(27));
FA_2_26_1 : FA port map (
	a => dadda_i(2)(3)(26),
	b => dadda_i(2)(4)(26),
	cin => dadda_i(2)(5)(26),
	s => dadda_i(3)(3)(26),
	cout => dadda_i(3)(1)(27));


-- Numero non processati: 0

FA_2_27_0 : FA port map (
	a => dadda_i(2)(0)(27),
	b => dadda_i(2)(1)(27),
	cin => dadda_i(2)(2)(27),
	s => dadda_i(3)(2)(27),
	cout => dadda_i(3)(0)(28));
FA_2_27_1 : FA port map (
	a => dadda_i(2)(3)(27),
	b => dadda_i(2)(4)(27),
	cin => dadda_i(2)(5)(27),
	s => dadda_i(3)(3)(27),
	cout => dadda_i(3)(1)(28));


-- Numero non processati: 0

FA_2_28_0 : FA port map (
	a => dadda_i(2)(0)(28),
	b => dadda_i(2)(1)(28),
	cin => dadda_i(2)(2)(28),
	s => dadda_i(3)(2)(28),
	cout => dadda_i(3)(0)(29));
FA_2_28_1 : FA port map (
	a => dadda_i(2)(3)(28),
	b => dadda_i(2)(4)(28),
	cin => dadda_i(2)(5)(28),
	s => dadda_i(3)(3)(28),
	cout => dadda_i(3)(1)(29));


-- Numero non processati: 0

FA_2_29_0 : FA port map (
	a => dadda_i(2)(0)(29),
	b => dadda_i(2)(1)(29),
	cin => dadda_i(2)(2)(29),
	s => dadda_i(3)(2)(29),
	cout => dadda_i(3)(0)(30));
FA_2_29_1 : FA port map (
	a => dadda_i(2)(3)(29),
	b => dadda_i(2)(4)(29),
	cin => dadda_i(2)(5)(29),
	s => dadda_i(3)(3)(29),
	cout => dadda_i(3)(1)(30));


-- Numero non processati: 0

FA_2_30_0 : FA port map (
	a => dadda_i(2)(0)(30),
	b => dadda_i(2)(1)(30),
	cin => dadda_i(2)(2)(30),
	s => dadda_i(3)(2)(30),
	cout => dadda_i(3)(0)(31));
FA_2_30_1 : FA port map (
	a => dadda_i(2)(3)(30),
	b => dadda_i(2)(4)(30),
	cin => dadda_i(2)(5)(30),
	s => dadda_i(3)(3)(30),
	cout => dadda_i(3)(1)(31));


-- Numero non processati: 0

FA_2_31_0 : FA port map (
	a => dadda_i(2)(0)(31),
	b => dadda_i(2)(1)(31),
	cin => dadda_i(2)(2)(31),
	s => dadda_i(3)(2)(31),
	cout => dadda_i(3)(0)(32));
FA_2_31_1 : FA port map (
	a => dadda_i(2)(3)(31),
	b => dadda_i(2)(4)(31),
	cin => dadda_i(2)(5)(31),
	s => dadda_i(3)(3)(31),
	cout => dadda_i(3)(1)(32));


-- Numero non processati: 0

FA_2_32_0 : FA port map (
	a => dadda_i(2)(0)(32),
	b => dadda_i(2)(1)(32),
	cin => dadda_i(2)(2)(32),
	s => dadda_i(3)(2)(32),
	cout => dadda_i(3)(0)(33));
FA_2_32_1 : FA port map (
	a => dadda_i(2)(3)(32),
	b => dadda_i(2)(4)(32),
	cin => dadda_i(2)(5)(32),
	s => dadda_i(3)(3)(32),
	cout => dadda_i(3)(1)(33));


-- Numero non processati: 0

FA_2_33_0 : FA port map (
	a => dadda_i(2)(0)(33),
	b => dadda_i(2)(1)(33),
	cin => dadda_i(2)(2)(33),
	s => dadda_i(3)(2)(33),
	cout => dadda_i(3)(0)(34));
FA_2_33_1 : FA port map (
	a => dadda_i(2)(3)(33),
	b => dadda_i(2)(4)(33),
	cin => dadda_i(2)(5)(33),
	s => dadda_i(3)(3)(33),
	cout => dadda_i(3)(1)(34));


-- Numero non processati: 0

FA_2_34_0 : FA port map (
	a => dadda_i(2)(0)(34),
	b => dadda_i(2)(1)(34),
	cin => dadda_i(2)(2)(34),
	s => dadda_i(3)(2)(34),
	cout => dadda_i(3)(0)(35));
FA_2_34_1 : FA port map (
	a => dadda_i(2)(3)(34),
	b => dadda_i(2)(4)(34),
	cin => dadda_i(2)(5)(34),
	s => dadda_i(3)(3)(34),
	cout => dadda_i(3)(1)(35));


-- Numero non processati: 0

FA_2_35_0 : FA port map (
	a => dadda_i(2)(0)(35),
	b => dadda_i(2)(1)(35),
	cin => dadda_i(2)(2)(35),
	s => dadda_i(3)(2)(35),
	cout => dadda_i(3)(0)(36));
FA_2_35_1 : FA port map (
	a => dadda_i(2)(3)(35),
	b => dadda_i(2)(4)(35),
	cin => dadda_i(2)(5)(35),
	s => dadda_i(3)(3)(35),
	cout => dadda_i(3)(1)(36));


-- Numero non processati: 0

FA_2_36_0 : FA port map (
	a => dadda_i(2)(0)(36),
	b => dadda_i(2)(1)(36),
	cin => dadda_i(2)(2)(36),
	s => dadda_i(3)(2)(36),
	cout => dadda_i(3)(0)(37));
FA_2_36_1 : FA port map (
	a => dadda_i(2)(3)(36),
	b => dadda_i(2)(4)(36),
	cin => dadda_i(2)(5)(36),
	s => dadda_i(3)(3)(36),
	cout => dadda_i(3)(1)(37));


-- Numero non processati: 0

FA_2_37_0 : FA port map (
	a => dadda_i(2)(0)(37),
	b => dadda_i(2)(1)(37),
	cin => dadda_i(2)(2)(37),
	s => dadda_i(3)(2)(37),
	cout => dadda_i(3)(0)(38));
FA_2_37_1 : FA port map (
	a => dadda_i(2)(3)(37),
	b => dadda_i(2)(4)(37),
	cin => dadda_i(2)(5)(37),
	s => dadda_i(3)(3)(37),
	cout => dadda_i(3)(1)(38));


-- Numero non processati: 0

FA_2_38_0 : FA port map (
	a => dadda_i(2)(0)(38),
	b => dadda_i(2)(1)(38),
	cin => dadda_i(2)(2)(38),
	s => dadda_i(3)(2)(38),
	cout => dadda_i(3)(0)(39));
FA_2_38_1 : FA port map (
	a => dadda_i(2)(3)(38),
	b => dadda_i(2)(4)(38),
	cin => dadda_i(2)(5)(38),
	s => dadda_i(3)(3)(38),
	cout => dadda_i(3)(1)(39));


-- Numero non processati: 0

FA_2_39_0 : FA port map (
	a => dadda_i(2)(0)(39),
	b => dadda_i(2)(1)(39),
	cin => dadda_i(2)(2)(39),
	s => dadda_i(3)(2)(39),
	cout => dadda_i(3)(0)(40));
FA_2_39_1 : FA port map (
	a => dadda_i(2)(3)(39),
	b => dadda_i(2)(4)(39),
	cin => dadda_i(2)(5)(39),
	s => dadda_i(3)(3)(39),
	cout => dadda_i(3)(1)(40));


-- Numero non processati: 0

FA_2_40_0 : FA port map (
	a => dadda_i(2)(0)(40),
	b => dadda_i(2)(1)(40),
	cin => dadda_i(2)(2)(40),
	s => dadda_i(3)(2)(40),
	cout => dadda_i(3)(0)(41));
FA_2_40_1 : FA port map (
	a => dadda_i(2)(3)(40),
	b => dadda_i(2)(4)(40),
	cin => dadda_i(2)(5)(40),
	s => dadda_i(3)(3)(40),
	cout => dadda_i(3)(1)(41));


-- Numero non processati: 0

FA_2_41_0 : FA port map (
	a => dadda_i(2)(0)(41),
	b => dadda_i(2)(1)(41),
	cin => dadda_i(2)(2)(41),
	s => dadda_i(3)(2)(41),
	cout => dadda_i(3)(0)(42));
FA_2_41_1 : FA port map (
	a => dadda_i(2)(3)(41),
	b => dadda_i(2)(4)(41),
	cin => dadda_i(2)(5)(41),
	s => dadda_i(3)(3)(41),
	cout => dadda_i(3)(1)(42));


-- Numero non processati: 0

FA_2_42_0 : FA port map (
	a => dadda_i(2)(0)(42),
	b => dadda_i(2)(1)(42),
	cin => dadda_i(2)(2)(42),
	s => dadda_i(3)(2)(42),
	cout => dadda_i(3)(0)(43));

HA_2_42_0 : HA port map (
	a => dadda_i(2)(3)(42),
	b => dadda_i(2)(4)(42),
	s => dadda_i(3)(3)(42),
	cout => dadda_i(3)(1)(43));

-- Numero non processati: 0

FA_2_43_0 : FA port map (
	a => dadda_i(2)(0)(43),
	b => dadda_i(2)(1)(43),
	cin => dadda_i(2)(2)(43),
	s => dadda_i(3)(2)(43),
	cout => dadda_i(3)(0)(44));


-- Numero non processati: 1
dadda_i(3)(3)(43) <= dadda_i(2)(3)(43);


HA_2_44_0 : HA port map (
	a => dadda_i(2)(0)(44),
	b => dadda_i(2)(1)(44),
	s => dadda_i(3)(1)(44),
	cout => dadda_i(3)(0)(45));

-- Numero non processati: 2
dadda_i(3)(2)(44) <= dadda_i(2)(2)(44);
dadda_i(3)(3)(44) <= dadda_i(2)(3)(44);

-- Numero non processati: 3
dadda_i(3)(1)(45) <= dadda_i(2)(0)(45);
dadda_i(3)(2)(45) <= dadda_i(2)(1)(45);
dadda_i(3)(3)(45) <= dadda_i(2)(2)(45);

-- Numero non processati: 3
dadda_i(3)(0)(46) <= dadda_i(2)(0)(46);
dadda_i(3)(1)(46) <= dadda_i(2)(1)(46);
dadda_i(3)(2)(46) <= dadda_i(2)(2)(46);

-- Numero non processati: 2
dadda_i(3)(0)(47) <= dadda_i(2)(0)(47);
dadda_i(3)(1)(47) <= dadda_i(2)(1)(47);

-- Numero non processati: 2
dadda_i(4)(0)(0) <= dadda_i(3)(0)(0);
dadda_i(4)(1)(0) <= dadda_i(3)(1)(0);

-- Numero non processati: 1
dadda_i(4)(0)(1) <= dadda_i(3)(0)(1);

-- Numero non processati: 3
dadda_i(4)(0)(2) <= dadda_i(3)(0)(2);
dadda_i(4)(1)(2) <= dadda_i(3)(1)(2);
dadda_i(4)(2)(2) <= dadda_i(3)(2)(2);

-- Numero non processati: 2
dadda_i(4)(0)(3) <= dadda_i(3)(0)(3);
dadda_i(4)(1)(3) <= dadda_i(3)(1)(3);


HA_3_4_0 : HA port map (
	a => dadda_i(3)(0)(4),
	b => dadda_i(3)(1)(4),
	s => dadda_i(4)(0)(4),
	cout => dadda_i(4)(0)(5));

-- Numero non processati: 2
dadda_i(4)(1)(4) <= dadda_i(3)(2)(4);
dadda_i(4)(2)(4) <= dadda_i(3)(3)(4);


HA_3_5_0 : HA port map (
	a => dadda_i(3)(0)(5),
	b => dadda_i(3)(1)(5),
	s => dadda_i(4)(1)(5),
	cout => dadda_i(4)(0)(6));

-- Numero non processati: 1
dadda_i(4)(2)(5) <= dadda_i(3)(2)(5);

FA_3_6_0 : FA port map (
	a => dadda_i(3)(0)(6),
	b => dadda_i(3)(1)(6),
	cin => dadda_i(3)(2)(6),
	s => dadda_i(4)(1)(6),
	cout => dadda_i(4)(0)(7));


-- Numero non processati: 1
dadda_i(4)(2)(6) <= dadda_i(3)(3)(6);

FA_3_7_0 : FA port map (
	a => dadda_i(3)(0)(7),
	b => dadda_i(3)(1)(7),
	cin => dadda_i(3)(2)(7),
	s => dadda_i(4)(1)(7),
	cout => dadda_i(4)(0)(8));


-- Numero non processati: 1
dadda_i(4)(2)(7) <= dadda_i(3)(3)(7);

FA_3_8_0 : FA port map (
	a => dadda_i(3)(0)(8),
	b => dadda_i(3)(1)(8),
	cin => dadda_i(3)(2)(8),
	s => dadda_i(4)(1)(8),
	cout => dadda_i(4)(0)(9));


-- Numero non processati: 1
dadda_i(4)(2)(8) <= dadda_i(3)(3)(8);

FA_3_9_0 : FA port map (
	a => dadda_i(3)(0)(9),
	b => dadda_i(3)(1)(9),
	cin => dadda_i(3)(2)(9),
	s => dadda_i(4)(1)(9),
	cout => dadda_i(4)(0)(10));


-- Numero non processati: 1
dadda_i(4)(2)(9) <= dadda_i(3)(3)(9);

FA_3_10_0 : FA port map (
	a => dadda_i(3)(0)(10),
	b => dadda_i(3)(1)(10),
	cin => dadda_i(3)(2)(10),
	s => dadda_i(4)(1)(10),
	cout => dadda_i(4)(0)(11));


-- Numero non processati: 1
dadda_i(4)(2)(10) <= dadda_i(3)(3)(10);

FA_3_11_0 : FA port map (
	a => dadda_i(3)(0)(11),
	b => dadda_i(3)(1)(11),
	cin => dadda_i(3)(2)(11),
	s => dadda_i(4)(1)(11),
	cout => dadda_i(4)(0)(12));


-- Numero non processati: 1
dadda_i(4)(2)(11) <= dadda_i(3)(3)(11);

FA_3_12_0 : FA port map (
	a => dadda_i(3)(0)(12),
	b => dadda_i(3)(1)(12),
	cin => dadda_i(3)(2)(12),
	s => dadda_i(4)(1)(12),
	cout => dadda_i(4)(0)(13));


-- Numero non processati: 1
dadda_i(4)(2)(12) <= dadda_i(3)(3)(12);

FA_3_13_0 : FA port map (
	a => dadda_i(3)(0)(13),
	b => dadda_i(3)(1)(13),
	cin => dadda_i(3)(2)(13),
	s => dadda_i(4)(1)(13),
	cout => dadda_i(4)(0)(14));


-- Numero non processati: 1
dadda_i(4)(2)(13) <= dadda_i(3)(3)(13);

FA_3_14_0 : FA port map (
	a => dadda_i(3)(0)(14),
	b => dadda_i(3)(1)(14),
	cin => dadda_i(3)(2)(14),
	s => dadda_i(4)(1)(14),
	cout => dadda_i(4)(0)(15));


-- Numero non processati: 1
dadda_i(4)(2)(14) <= dadda_i(3)(3)(14);

FA_3_15_0 : FA port map (
	a => dadda_i(3)(0)(15),
	b => dadda_i(3)(1)(15),
	cin => dadda_i(3)(2)(15),
	s => dadda_i(4)(1)(15),
	cout => dadda_i(4)(0)(16));


-- Numero non processati: 1
dadda_i(4)(2)(15) <= dadda_i(3)(3)(15);

FA_3_16_0 : FA port map (
	a => dadda_i(3)(0)(16),
	b => dadda_i(3)(1)(16),
	cin => dadda_i(3)(2)(16),
	s => dadda_i(4)(1)(16),
	cout => dadda_i(4)(0)(17));


-- Numero non processati: 1
dadda_i(4)(2)(16) <= dadda_i(3)(3)(16);

FA_3_17_0 : FA port map (
	a => dadda_i(3)(0)(17),
	b => dadda_i(3)(1)(17),
	cin => dadda_i(3)(2)(17),
	s => dadda_i(4)(1)(17),
	cout => dadda_i(4)(0)(18));


-- Numero non processati: 1
dadda_i(4)(2)(17) <= dadda_i(3)(3)(17);

FA_3_18_0 : FA port map (
	a => dadda_i(3)(0)(18),
	b => dadda_i(3)(1)(18),
	cin => dadda_i(3)(2)(18),
	s => dadda_i(4)(1)(18),
	cout => dadda_i(4)(0)(19));


-- Numero non processati: 1
dadda_i(4)(2)(18) <= dadda_i(3)(3)(18);

FA_3_19_0 : FA port map (
	a => dadda_i(3)(0)(19),
	b => dadda_i(3)(1)(19),
	cin => dadda_i(3)(2)(19),
	s => dadda_i(4)(1)(19),
	cout => dadda_i(4)(0)(20));


-- Numero non processati: 1
dadda_i(4)(2)(19) <= dadda_i(3)(3)(19);

FA_3_20_0 : FA port map (
	a => dadda_i(3)(0)(20),
	b => dadda_i(3)(1)(20),
	cin => dadda_i(3)(2)(20),
	s => dadda_i(4)(1)(20),
	cout => dadda_i(4)(0)(21));


-- Numero non processati: 1
dadda_i(4)(2)(20) <= dadda_i(3)(3)(20);

FA_3_21_0 : FA port map (
	a => dadda_i(3)(0)(21),
	b => dadda_i(3)(1)(21),
	cin => dadda_i(3)(2)(21),
	s => dadda_i(4)(1)(21),
	cout => dadda_i(4)(0)(22));


-- Numero non processati: 1
dadda_i(4)(2)(21) <= dadda_i(3)(3)(21);

FA_3_22_0 : FA port map (
	a => dadda_i(3)(0)(22),
	b => dadda_i(3)(1)(22),
	cin => dadda_i(3)(2)(22),
	s => dadda_i(4)(1)(22),
	cout => dadda_i(4)(0)(23));


-- Numero non processati: 1
dadda_i(4)(2)(22) <= dadda_i(3)(3)(22);

FA_3_23_0 : FA port map (
	a => dadda_i(3)(0)(23),
	b => dadda_i(3)(1)(23),
	cin => dadda_i(3)(2)(23),
	s => dadda_i(4)(1)(23),
	cout => dadda_i(4)(0)(24));


-- Numero non processati: 1
dadda_i(4)(2)(23) <= dadda_i(3)(3)(23);

FA_3_24_0 : FA port map (
	a => dadda_i(3)(0)(24),
	b => dadda_i(3)(1)(24),
	cin => dadda_i(3)(2)(24),
	s => dadda_i(4)(1)(24),
	cout => dadda_i(4)(0)(25));


-- Numero non processati: 1
dadda_i(4)(2)(24) <= dadda_i(3)(3)(24);

FA_3_25_0 : FA port map (
	a => dadda_i(3)(0)(25),
	b => dadda_i(3)(1)(25),
	cin => dadda_i(3)(2)(25),
	s => dadda_i(4)(1)(25),
	cout => dadda_i(4)(0)(26));


-- Numero non processati: 1
dadda_i(4)(2)(25) <= dadda_i(3)(3)(25);

FA_3_26_0 : FA port map (
	a => dadda_i(3)(0)(26),
	b => dadda_i(3)(1)(26),
	cin => dadda_i(3)(2)(26),
	s => dadda_i(4)(1)(26),
	cout => dadda_i(4)(0)(27));


-- Numero non processati: 1
dadda_i(4)(2)(26) <= dadda_i(3)(3)(26);

FA_3_27_0 : FA port map (
	a => dadda_i(3)(0)(27),
	b => dadda_i(3)(1)(27),
	cin => dadda_i(3)(2)(27),
	s => dadda_i(4)(1)(27),
	cout => dadda_i(4)(0)(28));


-- Numero non processati: 1
dadda_i(4)(2)(27) <= dadda_i(3)(3)(27);

FA_3_28_0 : FA port map (
	a => dadda_i(3)(0)(28),
	b => dadda_i(3)(1)(28),
	cin => dadda_i(3)(2)(28),
	s => dadda_i(4)(1)(28),
	cout => dadda_i(4)(0)(29));


-- Numero non processati: 1
dadda_i(4)(2)(28) <= dadda_i(3)(3)(28);

FA_3_29_0 : FA port map (
	a => dadda_i(3)(0)(29),
	b => dadda_i(3)(1)(29),
	cin => dadda_i(3)(2)(29),
	s => dadda_i(4)(1)(29),
	cout => dadda_i(4)(0)(30));


-- Numero non processati: 1
dadda_i(4)(2)(29) <= dadda_i(3)(3)(29);

FA_3_30_0 : FA port map (
	a => dadda_i(3)(0)(30),
	b => dadda_i(3)(1)(30),
	cin => dadda_i(3)(2)(30),
	s => dadda_i(4)(1)(30),
	cout => dadda_i(4)(0)(31));


-- Numero non processati: 1
dadda_i(4)(2)(30) <= dadda_i(3)(3)(30);

FA_3_31_0 : FA port map (
	a => dadda_i(3)(0)(31),
	b => dadda_i(3)(1)(31),
	cin => dadda_i(3)(2)(31),
	s => dadda_i(4)(1)(31),
	cout => dadda_i(4)(0)(32));


-- Numero non processati: 1
dadda_i(4)(2)(31) <= dadda_i(3)(3)(31);

FA_3_32_0 : FA port map (
	a => dadda_i(3)(0)(32),
	b => dadda_i(3)(1)(32),
	cin => dadda_i(3)(2)(32),
	s => dadda_i(4)(1)(32),
	cout => dadda_i(4)(0)(33));


-- Numero non processati: 1
dadda_i(4)(2)(32) <= dadda_i(3)(3)(32);

FA_3_33_0 : FA port map (
	a => dadda_i(3)(0)(33),
	b => dadda_i(3)(1)(33),
	cin => dadda_i(3)(2)(33),
	s => dadda_i(4)(1)(33),
	cout => dadda_i(4)(0)(34));


-- Numero non processati: 1
dadda_i(4)(2)(33) <= dadda_i(3)(3)(33);

FA_3_34_0 : FA port map (
	a => dadda_i(3)(0)(34),
	b => dadda_i(3)(1)(34),
	cin => dadda_i(3)(2)(34),
	s => dadda_i(4)(1)(34),
	cout => dadda_i(4)(0)(35));


-- Numero non processati: 1
dadda_i(4)(2)(34) <= dadda_i(3)(3)(34);

FA_3_35_0 : FA port map (
	a => dadda_i(3)(0)(35),
	b => dadda_i(3)(1)(35),
	cin => dadda_i(3)(2)(35),
	s => dadda_i(4)(1)(35),
	cout => dadda_i(4)(0)(36));


-- Numero non processati: 1
dadda_i(4)(2)(35) <= dadda_i(3)(3)(35);

FA_3_36_0 : FA port map (
	a => dadda_i(3)(0)(36),
	b => dadda_i(3)(1)(36),
	cin => dadda_i(3)(2)(36),
	s => dadda_i(4)(1)(36),
	cout => dadda_i(4)(0)(37));


-- Numero non processati: 1
dadda_i(4)(2)(36) <= dadda_i(3)(3)(36);

FA_3_37_0 : FA port map (
	a => dadda_i(3)(0)(37),
	b => dadda_i(3)(1)(37),
	cin => dadda_i(3)(2)(37),
	s => dadda_i(4)(1)(37),
	cout => dadda_i(4)(0)(38));


-- Numero non processati: 1
dadda_i(4)(2)(37) <= dadda_i(3)(3)(37);

FA_3_38_0 : FA port map (
	a => dadda_i(3)(0)(38),
	b => dadda_i(3)(1)(38),
	cin => dadda_i(3)(2)(38),
	s => dadda_i(4)(1)(38),
	cout => dadda_i(4)(0)(39));


-- Numero non processati: 1
dadda_i(4)(2)(38) <= dadda_i(3)(3)(38);

FA_3_39_0 : FA port map (
	a => dadda_i(3)(0)(39),
	b => dadda_i(3)(1)(39),
	cin => dadda_i(3)(2)(39),
	s => dadda_i(4)(1)(39),
	cout => dadda_i(4)(0)(40));


-- Numero non processati: 1
dadda_i(4)(2)(39) <= dadda_i(3)(3)(39);

FA_3_40_0 : FA port map (
	a => dadda_i(3)(0)(40),
	b => dadda_i(3)(1)(40),
	cin => dadda_i(3)(2)(40),
	s => dadda_i(4)(1)(40),
	cout => dadda_i(4)(0)(41));


-- Numero non processati: 1
dadda_i(4)(2)(40) <= dadda_i(3)(3)(40);

FA_3_41_0 : FA port map (
	a => dadda_i(3)(0)(41),
	b => dadda_i(3)(1)(41),
	cin => dadda_i(3)(2)(41),
	s => dadda_i(4)(1)(41),
	cout => dadda_i(4)(0)(42));


-- Numero non processati: 1
dadda_i(4)(2)(41) <= dadda_i(3)(3)(41);

FA_3_42_0 : FA port map (
	a => dadda_i(3)(0)(42),
	b => dadda_i(3)(1)(42),
	cin => dadda_i(3)(2)(42),
	s => dadda_i(4)(1)(42),
	cout => dadda_i(4)(0)(43));


-- Numero non processati: 1
dadda_i(4)(2)(42) <= dadda_i(3)(3)(42);

FA_3_43_0 : FA port map (
	a => dadda_i(3)(0)(43),
	b => dadda_i(3)(1)(43),
	cin => dadda_i(3)(2)(43),
	s => dadda_i(4)(1)(43),
	cout => dadda_i(4)(0)(44));


-- Numero non processati: 1
dadda_i(4)(2)(43) <= dadda_i(3)(3)(43);

FA_3_44_0 : FA port map (
	a => dadda_i(3)(0)(44),
	b => dadda_i(3)(1)(44),
	cin => dadda_i(3)(2)(44),
	s => dadda_i(4)(1)(44),
	cout => dadda_i(4)(0)(45));


-- Numero non processati: 1
dadda_i(4)(2)(44) <= dadda_i(3)(3)(44);

FA_3_45_0 : FA port map (
	a => dadda_i(3)(0)(45),
	b => dadda_i(3)(1)(45),
	cin => dadda_i(3)(2)(45),
	s => dadda_i(4)(1)(45),
	cout => dadda_i(4)(0)(46));


-- Numero non processati: 1
dadda_i(4)(2)(45) <= dadda_i(3)(3)(45);


HA_3_46_0 : HA port map (
	a => dadda_i(3)(0)(46),
	b => dadda_i(3)(1)(46),
	s => dadda_i(4)(1)(46),
	cout => dadda_i(4)(0)(47));

-- Numero non processati: 1
dadda_i(4)(2)(46) <= dadda_i(3)(2)(46);

-- Numero non processati: 2
dadda_i(4)(1)(47) <= dadda_i(3)(0)(47);
dadda_i(4)(2)(47) <= dadda_i(3)(1)(47);

-- Numero non processati: 2
dadda_i(5)(0)(0) <= dadda_i(4)(0)(0);
dadda_i(5)(1)(0) <= dadda_i(4)(1)(0);

-- Numero non processati: 1
dadda_i(5)(0)(1) <= dadda_i(4)(0)(1);


HA_4_2_0 : HA port map (
	a => dadda_i(4)(0)(2),
	b => dadda_i(4)(1)(2),
	s => dadda_i(5)(0)(2),
	cout => dadda_i(5)(0)(3));

-- Numero non processati: 1
dadda_i(5)(1)(2) <= dadda_i(4)(2)(2);


HA_4_3_0 : HA port map (
	a => dadda_i(4)(0)(3),
	b => dadda_i(4)(1)(3),
	s => dadda_i(5)(1)(3),
	cout => dadda_i(5)(0)(4));

-- Numero non processati: 0

FA_4_4_0 : FA port map (
	a => dadda_i(4)(0)(4),
	b => dadda_i(4)(1)(4),
	cin => dadda_i(4)(2)(4),
	s => dadda_i(5)(1)(4),
	cout => dadda_i(5)(0)(5));


-- Numero non processati: 0

FA_4_5_0 : FA port map (
	a => dadda_i(4)(0)(5),
	b => dadda_i(4)(1)(5),
	cin => dadda_i(4)(2)(5),
	s => dadda_i(5)(1)(5),
	cout => dadda_i(5)(0)(6));


-- Numero non processati: 0

FA_4_6_0 : FA port map (
	a => dadda_i(4)(0)(6),
	b => dadda_i(4)(1)(6),
	cin => dadda_i(4)(2)(6),
	s => dadda_i(5)(1)(6),
	cout => dadda_i(5)(0)(7));


-- Numero non processati: 0

FA_4_7_0 : FA port map (
	a => dadda_i(4)(0)(7),
	b => dadda_i(4)(1)(7),
	cin => dadda_i(4)(2)(7),
	s => dadda_i(5)(1)(7),
	cout => dadda_i(5)(0)(8));


-- Numero non processati: 0

FA_4_8_0 : FA port map (
	a => dadda_i(4)(0)(8),
	b => dadda_i(4)(1)(8),
	cin => dadda_i(4)(2)(8),
	s => dadda_i(5)(1)(8),
	cout => dadda_i(5)(0)(9));


-- Numero non processati: 0

FA_4_9_0 : FA port map (
	a => dadda_i(4)(0)(9),
	b => dadda_i(4)(1)(9),
	cin => dadda_i(4)(2)(9),
	s => dadda_i(5)(1)(9),
	cout => dadda_i(5)(0)(10));


-- Numero non processati: 0

FA_4_10_0 : FA port map (
	a => dadda_i(4)(0)(10),
	b => dadda_i(4)(1)(10),
	cin => dadda_i(4)(2)(10),
	s => dadda_i(5)(1)(10),
	cout => dadda_i(5)(0)(11));


-- Numero non processati: 0

FA_4_11_0 : FA port map (
	a => dadda_i(4)(0)(11),
	b => dadda_i(4)(1)(11),
	cin => dadda_i(4)(2)(11),
	s => dadda_i(5)(1)(11),
	cout => dadda_i(5)(0)(12));


-- Numero non processati: 0

FA_4_12_0 : FA port map (
	a => dadda_i(4)(0)(12),
	b => dadda_i(4)(1)(12),
	cin => dadda_i(4)(2)(12),
	s => dadda_i(5)(1)(12),
	cout => dadda_i(5)(0)(13));


-- Numero non processati: 0

FA_4_13_0 : FA port map (
	a => dadda_i(4)(0)(13),
	b => dadda_i(4)(1)(13),
	cin => dadda_i(4)(2)(13),
	s => dadda_i(5)(1)(13),
	cout => dadda_i(5)(0)(14));


-- Numero non processati: 0

FA_4_14_0 : FA port map (
	a => dadda_i(4)(0)(14),
	b => dadda_i(4)(1)(14),
	cin => dadda_i(4)(2)(14),
	s => dadda_i(5)(1)(14),
	cout => dadda_i(5)(0)(15));


-- Numero non processati: 0

FA_4_15_0 : FA port map (
	a => dadda_i(4)(0)(15),
	b => dadda_i(4)(1)(15),
	cin => dadda_i(4)(2)(15),
	s => dadda_i(5)(1)(15),
	cout => dadda_i(5)(0)(16));


-- Numero non processati: 0

FA_4_16_0 : FA port map (
	a => dadda_i(4)(0)(16),
	b => dadda_i(4)(1)(16),
	cin => dadda_i(4)(2)(16),
	s => dadda_i(5)(1)(16),
	cout => dadda_i(5)(0)(17));


-- Numero non processati: 0

FA_4_17_0 : FA port map (
	a => dadda_i(4)(0)(17),
	b => dadda_i(4)(1)(17),
	cin => dadda_i(4)(2)(17),
	s => dadda_i(5)(1)(17),
	cout => dadda_i(5)(0)(18));


-- Numero non processati: 0

FA_4_18_0 : FA port map (
	a => dadda_i(4)(0)(18),
	b => dadda_i(4)(1)(18),
	cin => dadda_i(4)(2)(18),
	s => dadda_i(5)(1)(18),
	cout => dadda_i(5)(0)(19));


-- Numero non processati: 0

FA_4_19_0 : FA port map (
	a => dadda_i(4)(0)(19),
	b => dadda_i(4)(1)(19),
	cin => dadda_i(4)(2)(19),
	s => dadda_i(5)(1)(19),
	cout => dadda_i(5)(0)(20));


-- Numero non processati: 0

FA_4_20_0 : FA port map (
	a => dadda_i(4)(0)(20),
	b => dadda_i(4)(1)(20),
	cin => dadda_i(4)(2)(20),
	s => dadda_i(5)(1)(20),
	cout => dadda_i(5)(0)(21));


-- Numero non processati: 0

FA_4_21_0 : FA port map (
	a => dadda_i(4)(0)(21),
	b => dadda_i(4)(1)(21),
	cin => dadda_i(4)(2)(21),
	s => dadda_i(5)(1)(21),
	cout => dadda_i(5)(0)(22));


-- Numero non processati: 0

FA_4_22_0 : FA port map (
	a => dadda_i(4)(0)(22),
	b => dadda_i(4)(1)(22),
	cin => dadda_i(4)(2)(22),
	s => dadda_i(5)(1)(22),
	cout => dadda_i(5)(0)(23));


-- Numero non processati: 0

FA_4_23_0 : FA port map (
	a => dadda_i(4)(0)(23),
	b => dadda_i(4)(1)(23),
	cin => dadda_i(4)(2)(23),
	s => dadda_i(5)(1)(23),
	cout => dadda_i(5)(0)(24));


-- Numero non processati: 0

FA_4_24_0 : FA port map (
	a => dadda_i(4)(0)(24),
	b => dadda_i(4)(1)(24),
	cin => dadda_i(4)(2)(24),
	s => dadda_i(5)(1)(24),
	cout => dadda_i(5)(0)(25));


-- Numero non processati: 0

FA_4_25_0 : FA port map (
	a => dadda_i(4)(0)(25),
	b => dadda_i(4)(1)(25),
	cin => dadda_i(4)(2)(25),
	s => dadda_i(5)(1)(25),
	cout => dadda_i(5)(0)(26));


-- Numero non processati: 0

FA_4_26_0 : FA port map (
	a => dadda_i(4)(0)(26),
	b => dadda_i(4)(1)(26),
	cin => dadda_i(4)(2)(26),
	s => dadda_i(5)(1)(26),
	cout => dadda_i(5)(0)(27));


-- Numero non processati: 0

FA_4_27_0 : FA port map (
	a => dadda_i(4)(0)(27),
	b => dadda_i(4)(1)(27),
	cin => dadda_i(4)(2)(27),
	s => dadda_i(5)(1)(27),
	cout => dadda_i(5)(0)(28));


-- Numero non processati: 0

FA_4_28_0 : FA port map (
	a => dadda_i(4)(0)(28),
	b => dadda_i(4)(1)(28),
	cin => dadda_i(4)(2)(28),
	s => dadda_i(5)(1)(28),
	cout => dadda_i(5)(0)(29));


-- Numero non processati: 0

FA_4_29_0 : FA port map (
	a => dadda_i(4)(0)(29),
	b => dadda_i(4)(1)(29),
	cin => dadda_i(4)(2)(29),
	s => dadda_i(5)(1)(29),
	cout => dadda_i(5)(0)(30));


-- Numero non processati: 0

FA_4_30_0 : FA port map (
	a => dadda_i(4)(0)(30),
	b => dadda_i(4)(1)(30),
	cin => dadda_i(4)(2)(30),
	s => dadda_i(5)(1)(30),
	cout => dadda_i(5)(0)(31));


-- Numero non processati: 0

FA_4_31_0 : FA port map (
	a => dadda_i(4)(0)(31),
	b => dadda_i(4)(1)(31),
	cin => dadda_i(4)(2)(31),
	s => dadda_i(5)(1)(31),
	cout => dadda_i(5)(0)(32));


-- Numero non processati: 0

FA_4_32_0 : FA port map (
	a => dadda_i(4)(0)(32),
	b => dadda_i(4)(1)(32),
	cin => dadda_i(4)(2)(32),
	s => dadda_i(5)(1)(32),
	cout => dadda_i(5)(0)(33));


-- Numero non processati: 0

FA_4_33_0 : FA port map (
	a => dadda_i(4)(0)(33),
	b => dadda_i(4)(1)(33),
	cin => dadda_i(4)(2)(33),
	s => dadda_i(5)(1)(33),
	cout => dadda_i(5)(0)(34));


-- Numero non processati: 0

FA_4_34_0 : FA port map (
	a => dadda_i(4)(0)(34),
	b => dadda_i(4)(1)(34),
	cin => dadda_i(4)(2)(34),
	s => dadda_i(5)(1)(34),
	cout => dadda_i(5)(0)(35));


-- Numero non processati: 0

FA_4_35_0 : FA port map (
	a => dadda_i(4)(0)(35),
	b => dadda_i(4)(1)(35),
	cin => dadda_i(4)(2)(35),
	s => dadda_i(5)(1)(35),
	cout => dadda_i(5)(0)(36));


-- Numero non processati: 0

FA_4_36_0 : FA port map (
	a => dadda_i(4)(0)(36),
	b => dadda_i(4)(1)(36),
	cin => dadda_i(4)(2)(36),
	s => dadda_i(5)(1)(36),
	cout => dadda_i(5)(0)(37));


-- Numero non processati: 0

FA_4_37_0 : FA port map (
	a => dadda_i(4)(0)(37),
	b => dadda_i(4)(1)(37),
	cin => dadda_i(4)(2)(37),
	s => dadda_i(5)(1)(37),
	cout => dadda_i(5)(0)(38));


-- Numero non processati: 0

FA_4_38_0 : FA port map (
	a => dadda_i(4)(0)(38),
	b => dadda_i(4)(1)(38),
	cin => dadda_i(4)(2)(38),
	s => dadda_i(5)(1)(38),
	cout => dadda_i(5)(0)(39));


-- Numero non processati: 0

FA_4_39_0 : FA port map (
	a => dadda_i(4)(0)(39),
	b => dadda_i(4)(1)(39),
	cin => dadda_i(4)(2)(39),
	s => dadda_i(5)(1)(39),
	cout => dadda_i(5)(0)(40));


-- Numero non processati: 0

FA_4_40_0 : FA port map (
	a => dadda_i(4)(0)(40),
	b => dadda_i(4)(1)(40),
	cin => dadda_i(4)(2)(40),
	s => dadda_i(5)(1)(40),
	cout => dadda_i(5)(0)(41));


-- Numero non processati: 0

FA_4_41_0 : FA port map (
	a => dadda_i(4)(0)(41),
	b => dadda_i(4)(1)(41),
	cin => dadda_i(4)(2)(41),
	s => dadda_i(5)(1)(41),
	cout => dadda_i(5)(0)(42));


-- Numero non processati: 0

FA_4_42_0 : FA port map (
	a => dadda_i(4)(0)(42),
	b => dadda_i(4)(1)(42),
	cin => dadda_i(4)(2)(42),
	s => dadda_i(5)(1)(42),
	cout => dadda_i(5)(0)(43));


-- Numero non processati: 0

FA_4_43_0 : FA port map (
	a => dadda_i(4)(0)(43),
	b => dadda_i(4)(1)(43),
	cin => dadda_i(4)(2)(43),
	s => dadda_i(5)(1)(43),
	cout => dadda_i(5)(0)(44));


-- Numero non processati: 0

FA_4_44_0 : FA port map (
	a => dadda_i(4)(0)(44),
	b => dadda_i(4)(1)(44),
	cin => dadda_i(4)(2)(44),
	s => dadda_i(5)(1)(44),
	cout => dadda_i(5)(0)(45));


-- Numero non processati: 0

FA_4_45_0 : FA port map (
	a => dadda_i(4)(0)(45),
	b => dadda_i(4)(1)(45),
	cin => dadda_i(4)(2)(45),
	s => dadda_i(5)(1)(45),
	cout => dadda_i(5)(0)(46));


-- Numero non processati: 0

FA_4_46_0 : FA port map (
	a => dadda_i(4)(0)(46),
	b => dadda_i(4)(1)(46),
	cin => dadda_i(4)(2)(46),
	s => dadda_i(5)(1)(46),
	cout => dadda_i(5)(0)(47));


-- Numero non processati: 0

FA_4_47_0 : FA port map (
	a => dadda_i(4)(0)(47),
	b => dadda_i(4)(1)(47),
	cin => dadda_i(4)(2)(47),
	s => dadda_i(5)(1)(47),
	cout => dadda_i(5)(0)(48));


-- Numero non processati: 0



last_HA : HA port map(
	dadda_i(5)(0)(0),
	dadda_i(5)(1)(0),
	p(0),
	dadda_i(5)(1)(1)
);

p(47 downto 1) <= std_logic_vector(unsigned(dadda_i(5)(0)(47 downto 1)) + unsigned(dadda_i(5)(1)(47 downto 1)));
 
end behavioural; 