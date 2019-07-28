
library ieee;  
use ieee.std_logic_1164.all;  
 
entity FlipFlop is  
	generic (size	:	integer	:=	4);

	port(Clk		 : in std_logic;
		 INvalue  : in std_logic_vector (size-1 downto 0);  
		 OUTvalue : out std_logic_vector (size-1 downto 0)
	);  
end FlipFlop;  

architecture archi of FlipFlop is  
  begin  
    process (Clk)  
      begin  
        if (Clk'event and Clk='1') then  
          OUTvalue <= INvalue;  
        end if;  
    end process;  
end archi; 