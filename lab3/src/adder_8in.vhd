library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder_8in is
	generic ( n : integer := 16 );
	port (	IN0 : in signed(n-1 downto 0);
			IN1 : in signed(n-1 downto 0);
			IN2 : in signed(n-1 downto 0);
			IN3 : in signed(n-1 downto 0);
			IN4 : in signed(n-1 downto 0);
			IN5 : in signed(n-1 downto 0);
			IN6 : in signed(n-1 downto 0);
			IN7 : in signed(n-1 downto 0);
			Q	: out signed(n+2 downto 0)
	);
end adder_8in;

architecture behavioural of adder_8in is

signal IN0_ext, IN1_ext, IN2_ext, IN3_ext, IN4_ext, IN5_ext, IN6_ext, IN7_ext : signed (n+2 downto 0);

begin
	IN0_ext <= IN0(n-1) & IN0(n-1) & IN0(n-1) & IN0;
	IN1_ext <= IN1(n-1) & IN1(n-1) & IN1(n-1) & IN1;
	IN2_ext <= IN2(n-1) & IN2(n-1) & IN2(n-1) & IN2;
	IN3_ext <= IN3(n-1) & IN3(n-1) & IN3(n-1) & IN3;
	IN4_ext <= IN4(n-1) & IN4(n-1) & IN4(n-1) & IN4;
	IN5_ext <= IN5(n-1) & IN5(n-1) & IN5(n-1) & IN5;
	IN6_ext <= IN6(n-1) & IN6(n-1) & IN6(n-1) & IN6;
	IN7_ext <= IN7(n-1) & IN7(n-1) & IN7(n-1) & IN7;
	
	Q <= IN0_ext + IN1_ext + IN2_ext + IN3_ext + IN4_ext + IN5_ext + IN6_ext + IN7_ext;

end behavioural;
