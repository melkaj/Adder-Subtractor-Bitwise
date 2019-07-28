
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.std_logic_unsigned.all;

entity TB_BitwiseOperations is
end TB_BitwiseOperations;

architecture arch_test of TB_BitwiseOperations is

	component BitwiseOperations
		generic (
			size	:	integer	:=	4
		);

		port(
			opcode	:	IN std_logic_vector (size-1 downto 0);
			A	:	IN std_logic_vector (size-1 downto 0);
			B	:	IN std_logic_vector (size-1 downto 0);
			F	:	OUT std_logic_vector (size-1 downto 0)
		);
	end component;
	
	-- Temporary signals for Input and Output
	signal At, Bt, Ft, opcodet: std_logic_vector (3 downto 0);
	
	-- Error placeholder
	signal error	: std_logic := '0';
	
	begin 
	uut:	BitwiseOperations port map (opcodet, At, Bt, Ft);
	
	process
		begin
			
			At <= "0000";
			Bt <= "0000";
			opcodet <= "0010";
			
			for I in 0 to 15 loop
				for J in 0 to 15 loop
					wait for 10ns;
					assert (Ft = (At AND Bt)) report "Ft should have been: " &
							integer'image(to_integer(unsigned((At AND Bt)))) & ". Design result was: " &
							integer'image(to_integer(unsigned(Ft))) severity Failure;
							
					Bt <= Bt + "0001";
				end loop;
				At <= At + "0001";
			end loop;
			
			report "Test One Complete (AND)";
			wait for 200ns;
			
			
			At <= "0000";
			Bt <= "0000";
			opcodet <= "0011";
			
			for K in 0 to 15 loop
				for L in 0 to 15 loop
					wait for 10ns;
					assert (Ft = (At OR Bt)) report "Ft should have been: " &
							integer'image(to_integer(unsigned((At OR Bt)))) & ". Design result was: " &
							integer'image(to_integer(unsigned(Ft))) severity Failure;
					Bt <= Bt + "0001";
				end loop;
				At <= At + "0001";
			end loop;
			
			report "Test Two Complete (OR)";
			wait for 200ns;
			
			
			At <= "0000";
			Bt <= "0000";
			opcodet <= "0100";
			
			for K in 0 to 15 loop
				for L in 0 to 15 loop
					wait for 10ns;
					assert (Ft = (At XOR Bt)) report "Ft should have been: " &
							integer'image(to_integer(unsigned((At XOR Bt)))) & ". Design result was: " &
							integer'image(to_integer(unsigned(Ft))) severity Failure;
					Bt <= Bt + "0001";
				end loop;
				At <= At + "0001";
			end loop;
			
			report "Test Three Complete (XOR)";
			wait for 200ns;
			
			
			At <= "0000";
			Bt <= "0000";
			opcodet <= "0101";
			
			for K in 0 to 15 loop
					wait for 10ns;
					assert (Ft = (NOT At)) report "Ft should have been: " &
							integer'image(to_integer(unsigned((NOT At)))) & ". Design result was: " &
							integer'image(to_integer(unsigned(Ft))) severity Failure;
				At <= At + "0001";
			end loop;
			
			report "Test Four Complete (NOT)";
			wait for 200ns;
			
			
			At <= "0000";
			Bt <= "0000";
			opcodet <= "0110";
			
			for K in 0 to 15 loop
					wait for 10ns;
					assert (Ft = (to_stdlogicvector(to_bitvector(At) SLL 1))) report "Ft should have been: " &
							integer'image(to_integer(unsigned((to_stdlogicvector(to_bitvector(At) SLL 1))))) & ". Design result was: " &
							integer'image(to_integer(unsigned(Ft))) severity Failure;
				At <= At + "0001";
			end loop;
			
			report "Test Five Complete (Shift Left)";
			wait for 200ns;
			
			
			At <= "0000";
			Bt <= "0000";
			opcodet <= "0111";
			
			for K in 0 to 15 loop
					wait for 10ns;
					assert (Ft = (to_stdlogicvector(to_bitvector(At) SRL 1))) report "Ft should have been: " &
							integer'image(to_integer(unsigned((to_stdlogicvector(to_bitvector(At) SRL 1))))) & ". Design result was: " &
							integer'image(to_integer(unsigned(Ft))) severity Failure;
				At <= At + "0001";
			end loop;
			
			report "Test Six Complete (Shift Right)";
			wait for 200ns;
			
			
			At <= "0000";
			Bt <= "0000";
			opcodet <= "1000";
			
			for K in 0 to 15 loop
					wait for 10ns;
					assert (Ft = (to_stdlogicvector(to_bitvector(At) ROL 1))) report "Ft should have been: " &
							integer'image(to_integer(unsigned((to_stdlogicvector(to_bitvector(At) ROL 1))))) & ". Design result was: " &
							integer'image(to_integer(unsigned(Ft))) severity Failure;
				At <= At + "0001";
			end loop;
			
			report "Test Seven Complete (Rotation Left)";
			wait for 200ns;
			
			
			At <= "0000";
			Bt <= "0000";
			opcodet <= "1001";
			
			for K in 0 to 15 loop
					wait for 10ns;
					assert (Ft = (to_stdlogicvector(to_bitvector(At) ROR 1))) report "Ft should have been: " &
							integer'image(to_integer(unsigned((to_stdlogicvector(to_bitvector(At) ROR 1))))) & ". Design result was: " &
							integer'image(to_integer(unsigned(Ft))) severity Failure;
				At <= At + "0001";
			end loop;
			
			report "Test Eight Complete (Rotation Right)";
			wait for 200ns;
			
			
			
			if (error = '0') then
				report "TestBench is Complete!" severity Failure;
			wait for 200ns;
			end if;
	end process;
		
		
	end arch_test;
		
		