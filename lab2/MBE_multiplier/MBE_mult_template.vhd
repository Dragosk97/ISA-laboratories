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
	dadda_i(0)(12-j)(27 + 2*(j-1) + 1 downto 27 + 2*(j-1) ) <= in_dadda(12)(23+2*(-11+j) downto 22+2*(-11+j) );
	end generate;

end generate;

--------------------------------------------------------------------

{{ netlist_str }}

last_HA : HA port map(
	dadda_i(5)(0)(0),
	dadda_i(5)(1)(0),
	p(0),
	dadda_i(5)(1)(1)
);

p(47 downto 1) <= std_logic_vector(unsigned(dadda_i(5)(0)(47 downto 1)) + unsigned(dadda_i(5)(1)(47 downto 1)));
 
end behavioural; 
