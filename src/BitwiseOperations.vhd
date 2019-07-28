
library ieee;
use ieee.std_logic_1164.all;

entity BitwiseOperations is
	generic (
		size	:	integer	:=	4
	);

	port(
		opcode	:	IN std_logic_vector (size-1 downto 0);
		A	:	IN std_logic_vector (size-1 downto 0);
		B	:	IN std_logic_vector (size-1 downto 0);
		F	:	OUT std_logic_vector (size-1 downto 0)
	);
end BitwiseOperations;

architecture arch of BitwiseOperations is
	signal op	:	std_logic_vector (size-1 downto 0);
	begin
	op <= opcode;
	process (op, A, B)
		begin
			case op is
				when ( "0010" ) => F <= (A AND B);	-- AND
				when ( "0011" ) => F <= (A OR B);	-- OR 
				when ( "0100" ) => F <= (A XOR B);	-- XOR
				when ( "0101" ) => F <= (NOT A);		-- NOT
	
				when ( "0110" ) => F <= to_stdlogicvector(to_bitvector(A) SLL 1);	-- shift left
				when ( "0111" ) => F <= to_stdlogicvector(to_bitvector(A) SRL 1);	-- shift right
				when ( "1000" ) => F <= to_stdlogicvector(to_bitvector(A) ROL 1);	-- rotation left
				when ( "1001" ) => F <= to_stdlogicvector(to_bitvector(A) ROR 1);	-- rotation right
				when others => F <= "1111";
			end case;
	end process;

end arch;