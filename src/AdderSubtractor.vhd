
library ieee;
use ieee.std_logic_1164.all;

entity AdderSubtractor is 
	generic (
		size	:	integer	:=	4
	);

	port(
		A		:	in std_logic_vector (size-1 downto 0);	-- Input 1
		B		:	in std_logic_vector (size-1 downto 0);	-- Input 2
		F		: 	out std_logic_vector (size-1 downto 0);	-- Output
		Cout	:	out std_logic;								-- Carry-out
		M		: 	in std_logic;	--determines subtraction or addition
		V		: 	out std_logic	-- Overflow
	);	
end AdderSubtractor;

architecture arch of AdderSubtractor is
	
	-- Declaring Components
	component FullAdder is
		port(
			X		:	in std_logic;
			Y		: 	in std_logic;
			Cin	:	in std_logic;
			SUM	:	out std_logic;
			Cout 	: 	out std_logic
		);
	end component;
	
	signal Be, C	:	std_logic_vector (3 downto 0);
	--signal SSOutput: 	std_logic_vector (=3 downto 0);
	
		begin
		Be(0) <= (B(0) xor M);
		Be(1) <= (B(1) xor M);
		Be(2) <= (B(2) xor M);
		Be(3) <= (B(3) xor M);
		
		FA1: FullAdder port map (A(0), Be(0), M, F(0), C(0));
		FA2: FullAdder port map (A(1), Be(1), C(0), F(1), C(1));
		FA3: FullAdder port map (A(2), Be(2), C(1), F(2), C(2));
		FA4: FullAdder port map (A(3), Be(3), C(2), F(3), C(3));

		Cout <= C(3);
		V <= (C(3) xor C(2));
	
end arch;






