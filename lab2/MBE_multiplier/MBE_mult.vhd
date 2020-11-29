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
generic(nbit : integer)
    port(
        a : in std_logic_vector(nbit-1 downto 0);
        b0 : in std_logic_vector; 
        b1 : in std_logic_vector;
        b2 : in std_logic_vector;
        pp : out std_logic_vector(nbit downto 0)
    );
end component;

type array_mbe IS array (0 to 12) of std_logic_vector (24 downto 0);
SIGNAL mbe_out : array_mbe;

--dadda input preparation
type array_s IS array (0 to 12) of std_logic_vector (28 downto 0);
SIGNAL in_dadda : array_s;

--
type array_int is array (0 to 47) of integer;
type array_stage_int is array (0 to 5) of array_int

type array_target is array (0 to 5) of integer;

type array_matrix is array (0 to 12) of std_logic_vector(47 downto 0);
type array_stage is array(0 to 5) of array_matrix;
SIGNAL dadda_i is array_stage;

BEGIN
--MBE
mbe_pp0: MBE_n generic map (24) port map(
			a => a,
			b0 => '0',
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
			b1 => '0',
			b2 => '0',
			pp=> mbe_out(12));

--input DADDA
in_dadda(0) <= NOT(b(1)) & b(1) & b(1) & mbe_out(0) & b(1);
 
input_dadda : for i in 1 to 10
	generate
		in_dadda(i) <= '1' & NOT(b(2*i+1)) & mbe_out(i) & b(2*i+1);
	end generate;
	
in_dadda(11) <= NOT(b(2*11+1)) & mbe_out(11) & b(2*11+1);
in_dadda(12) <= mbe_out(12) (23 downto 0);



-- Initialization of dadda_i(0)

dadda_i(0)(0)(27 downto 0) <= in_dadda(0)(28 downto 1);

dadda_init : for i in 1 to 11
generate
	dadda_i(0)(i)(27 downto 2*i) <= in_dadda(i)(28 -2*i downto 1);
	dadda_i(0)(i)(2*(i-1)) <= in_dadda(i-1)(0);
	dadda_i(0)(i-1)(28) <= in_dadda(i)(27 - 2*(i-1));
	
	for j in 2 to i
	generate
		dadda_i(0)(i-j)(27-i downto 26 i+j) <= in_dadda(i)(27-i+j downto 26-i+j)
	end generate;
end generate;

dadda_i(0)(12)(27 downto 24) <= in_dadda(12)(3 downto 0);
dadda_i(0)(12)(22) <= in_dadda(11)(0);

dadda_transp : for 

for stage in 0 to 4
generate
	variable row_num : array_stage_int;
	constant row_target : array_target := {13, 9, 6, 4, 3, 2};
	row_num(0) := {2,1,3,2,4,3,5,4,6,5,7,6,8,7,9,8,10,9,11,10,12,11,13,12,13,13,13,13,12,11,11,10,10,9,9,6,6,7,7,6,6,5,5,4,4,3,3,2};
begin
	
	for column in 0 to 47
	generate
		if row_num(stage)
	end generate;
	

end generate;

end behavioural; 
