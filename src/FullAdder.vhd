
library ieee;
use ieee.std_logic_1164.all;

entity FullAdder is
	port(
		X		:	in std_logic;
		Y		: 	in std_logic;
		Cin	:	in std_logic;
		SUM	:	out std_logic;
		Cout 	: 	out std_logic	
	);
end FullAdder;

architecture arch of FullAdder is

	-- Declare components
	component HalfAdder is
		port(
			X		:	in std_logic;
			Y 		: 	in std_logic;
			SUM	:  out std_logic;
			Cout	: 	out std_logic
		);	
	end component;
	
	signal andONE, xorONE, andTWO : std_logic;
	
		begin
		h1: HalfAdder port map (X, Y, xorONE, andONE);
		h2: HalfAdder port map (xorONE, Cin, SUM, andTwo);
		
		Cout <= (andONE or andTWO);
		
end arch;
	