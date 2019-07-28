
library ieee;  
use ieee.std_logic_1164.all;

entity Decoder is
	generic (
		sizeINPUT	:	integer := 4;
		sizeOUTPUT	:	integer := 7
	);
	
	port(
		-- Input bits
		A	:	in std_logic_vector (sizeINPUT-1 downto 0);
		signedOrUnsigned	:	in std_logic;
		-- 7 segment display output
		-- X is least significant digit
		-- Y is most significant digit
		-- Z is the sign of the output
		X	:	out std_logic_vector (sizeOUTPUT-1 downto 0);
		Y	: 	out std_logic_vector (sizeOUTPUT-1 downto 0);
		Z	:	out std_logic_vector (sizeOUTPUT-1 downto 0)
	);
	
end Decoder;

architecture arch of Decoder is
	
	-- Unsigned
	begin
		process ( signedOrUnsigned, A )
		 begin
			if ( signedOrUnsigned = '0' ) then
				X(0) <= (A(3) AND (NOT A(2)) AND A(1) AND A(0)) OR ((NOT A(3)) AND (NOT A(2)) AND (NOT A(1)) AND A(0)) OR (A(3) AND A(2) AND A(1) AND (NOT A(0))) OR ((NOT A(3)) AND A(2) AND (NOT A(1)) AND (NOT A(0)));
				X(1) <= (A(3) AND A(2) AND A(1) AND A(0)) OR ((NOT A(3)) AND A(2) AND (NOT A(1)) AND A(0)) OR ((NOT A(3)) AND A(2) AND A(1) AND (NOT A(0)));
				X(2) <= ((NOT A(3)) AND (NOT A(2)) AND A(1) AND (NOT A(0))) OR (A(3) AND A(2) AND (NOT A(1)) AND (NOT A(0)));
				X(3) <= (A(3) AND (NOT A(2)) AND A(0)) OR ((NOT A(2)) AND (NOT A(1)) AND A(0)) OR ((NOT A(3)) AND A(2) AND A(1) AND A(0)) OR (A(3) AND A(2) AND A(1) AND (NOT A(0))) OR ((NOT A(3)) AND A(2) AND (NOT A(1)) AND (NOT A(0)));
				X(4) <= A(0) OR (A(3) AND A(2) AND A(1)) OR ((NOT A(3)) AND A(2) AND (NOT A(1)));
				X(5) <= ((NOT A(3)) AND (NOT A(2)) AND A(1)) OR (A(3) AND A(2) AND (NOT A(1))) OR ((NOT A(3)) AND (NOT A(2)) AND A(0)) OR ((NOT A(3)) AND A(1) AND A(0)) OR ((NOT A(2)) AND A(1) AND A(0));
				X(6) <= (A(3) AND (NOT A(2)) AND A(1)) OR ((NOT A(3)) AND (NOT A(2)) AND (NOT A(1))) OR ((NOT A(3)) AND A(2) AND A(1) AND A(0));
				
				Y(0) <= (A(3) AND A(2)) OR (A(3) AND A(1));
				Y(1) <= '0';
				Y(2) <= '0';
				Y(3) <= (A(3) AND A(2)) OR (A(3) AND A(1));
				Y(4) <= (A(3) AND A(2)) OR (A(3) AND A(1));
				Y(5) <= (A(3) AND A(2)) OR (A(3) AND A(1));
				Y(6) <= '1';
				
				Z <= "1001110";
				
			-- SIGNED
			else
				X(0) <= (A(2) AND (not (A(1))) AND (not (A(0)))) OR (A(3) AND A(2) AND A(1) AND A(0)) OR ((not (A(3))) AND (not (A(2))) AND (not (A(1))) AND A(0));
				X(1) <= (A(3) AND (not (A(2))) AND A(1)) OR ((not (A(3))) AND A(2) AND (not (A(1))) AND A(0)) OR ((not (A(3))) AND A(2) AND A(1) AND (not (A(0))));
				X(2) <= (A(3) AND A(2) AND A(1) AND (not (A(0)))) OR ((not (A(3))) AND (not (A(2))) AND A(1) AND (not (A(0))));
				X(3) <= (A(2) AND A(1) AND A(0)) OR ((not (A(2))) AND (not (A(1))) AND A(0)) OR (A(2) AND (not (A(1))) AND (not (A(0))));
				X(4) <= A(0) OR (A(2) AND (not (A(1))));
				X(5) <= (A(3) AND A(2) AND A(1)) OR ((not (A(3))) AND (not (A(2))) AND A(1)) OR (A(2) AND A(1) AND A(0)) OR (A(3) AND (not (A(1))) AND A(0)) OR ((not (A(2))) AND (not (A(1))) AND A(0));
				X(6) <= ((not (A(3))) AND (not (A(2))) AND (not (A(1)))) OR (A(2) AND A(1) AND A(0)) OR ((not (A(2))) AND (not (A(1))) AND A(0));
				
				Y <= "0000001";
				
				if (A(3) ='1') then
					Z <= "1111110";
				else
					Z <= "1001110";
				end if;
				
			end if;
		end process;
end arch;














