
library ieee;
use ieee.std_logic_1164.all;

entity HalfAdder is
	port(
		X		:	in std_logic;
		Y 		: 	in std_logic;
		SUM	:  out std_logic;
		Cout	: 	out std_logic
	);
end HalfAdder;

architecture arch of HalfAdder is
	begin 
			SUM <= (X XOR Y);
			Cout <= (X AND Y);
end arch;	
	