
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.std_logic_unsigned.all;

entity TB_AdderSubtractor is
end TB_AdderSubtractor;

architecture arch_test of TB_AdderSubtractor is

	component AdderSubtractor
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
	end component;
	
	--Add or subtract
	signal Mt, Coutt, Vt	:	std_logic;
	
	-- Temporary signals for Input and Output
	signal At, Bt, Ft	: std_logic_vector (3 downto 0);
	
	-- Error placeholder
	signal error	: std_logic := '0';
	
	begin 
	uut:	AdderSubtractor port map (At, Bt, Ft, Coutt, Mt, Vt);
	
	process
		begin
			
			At <= "0000";
			Bt <= "0000";
			Mt <= '0';
			
			for I in 0 to 15 loop
				for J in 0 to 15 loop
					wait for 10ns;
					assert (Ft = At + Bt) report "Ft should have been: " &
							integer'image(to_integer(unsigned((At + Bt)))) & ". Design result was: " &
							integer'image(to_integer(unsigned(Ft))) severity Failure;
							
					Bt <= Bt + "0001";
				end loop;
				At <= At + "0001";
			end loop;
			
			report "Test One Complete (Adding)";
			wait for 200ns;
			
			
			At <= "0000";
			Bt <= "0000";
			Mt <= '1';
			
			for K in 0 to 15 loop
				for L in 0 to 15 loop
					wait for 10ns;
					assert (Ft = At - Bt) report "Ft should have been: " &
							integer'image(to_integer(signed((At - Bt)))) & ". Design result was: " &
							integer'image(to_integer(signed(Ft))) severity Failure;
					Bt <= Bt + "0001";
				end loop;
				At <= At + "0001";
			end loop;
			
			report "Test Two Complete (Subtracting)";
			if (error = '0') then
				report "TestBench is Complete!" severity Failure;
			wait for 200ns;
			end if;
	end process;
		
	end arch_test;	