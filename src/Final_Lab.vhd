
library ieee;
use ieee.std_logic_1164.all;

entity Final_Lab is
	generic (
		inputSize	:	integer	:= 4;
		SegmentSize	:	integer	:= 7
	);

  port(
		-- Input 1
		X	:	in std_logic_vector (inputSize-1 downto 0);
		
		-- Inout 2
		Y	:	in std_logic_vector (inputSize-1 downto 0);
		opcode	:	in std_logic_vector (inputSize-1 downto 0);
		
		-- EIGHT 7 SEGMENT DISPLAYS
		A   : out std_logic_vector (0 to SegmentSize-1);
		B	 : out std_logic_vector (0 to SegmentSize-1);
		C	 : out std_logic_vector (0 to SegmentSize-1);
		D	 : out std_logic_vector (0 to SegmentSize-1);
		
		E	 : out std_logic_vector (0 to SegmentSize-1);
		F	 : out std_logic_vector (0 to SegmentSize-1);
		G	 : out std_logic_vector (0 to SegmentSize-1);
		H	 : out std_logic_vector (0 to SegmentSize-1);
		
		-- Led Segments
		CoutLED	 		: out std_logic;
		OverFlowLED	   : out std_logic;
		ZeroLED			: out std_logic;
		
		-- Bitwise Led Segments
		BitZero			: out std_logic;
		BitOne			: out std_logic;
		BitTwo			: out std_logic;
		BitThree			: out std_logic;
		
		-- Register Switches
		clkSwitch		: in std_logic;	-- High or Low
		displayRegister: in std_logic	-- If on, will display contents of register
	);
end Final_Lab;

architecture arch of Final_Lab is

	-- DECLARING COMPONENTS
	component AdderSubtractor is
		generic (
			size	:	integer	:=	4
		);

		port(
			A		:	in std_logic_vector (size-1 downto 0);		-- Input 1
			B		:	in std_logic_vector (size-1 downto 0);		-- Input 2
			F		: 	out std_logic_vector (size-1 downto 0);	-- Output
			Cout	:	out std_logic;	-- Carry-out
			M		: 	in std_logic;	--determines subtraction or addition
			V		: 	out std_logic	-- Overflow
		);	
	end component;
	
	component BitwiseOperations is
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
	
	component FlipFlop is
		generic (size	:	integer	:=	4);

		port(
			Clk		: in std_logic;
			INvalue  : in std_logic_vector (size-1 downto 0);  
			OUTvalue : out std_logic_vector (size-1 downto 0)
		);
	end component;
	
	component Decoder is 
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
	end component;
	-- END COMPONENTS
	
	signal S		: std_logic_vector (inputSize-1 downto 0);	-- AdderSubtractor Result
	signal BWR	: std_logic_vector (inputSize-1 downto 0); -- Bitwise Operation Result
	signal reg1	:	std_logic_vector (inputSize-1 downto 0);-- temporary registers
	signal reg2	:	std_logic_vector (inputSize-1 downto 0);-- temporary registers
	signal co 	:	std_logic;	-- temporary Cout
	signal overflow 	:	std_logic;	-- temporary OverFlow
	
	signal AS_A	: std_logic_vector (0 to SegmentSize-1);	-- temporary segment for adderSubtractor
	signal AS_B	: std_logic_vector (0 to SegmentSize-1);	-- temporary segment for adderSubtractor
	signal AS_C	: std_logic_vector (0 to SegmentSize-1);	-- temporary segment for adderSubtractor
	
	signal BW_A	: std_logic_vector (0 to SegmentSize-1);	-- temporary segment for bitwiseOper
	signal BW_B	: std_logic_vector (0 to SegmentSize-1);	-- temporary segment for bitwiseOper
	signal BW_C	: std_logic_vector (0 to SegmentSize-1);	-- temporary segment for bitwiseOper
	
	signal R1_A	: std_logic_vector (0 to SegmentSize-1);	-- temporary segment for register one 
	signal R1_B	: std_logic_vector (0 to SegmentSize-1);	-- temporary segment for register one 
	signal R1_C	: std_logic_vector (0 to SegmentSize-1);	-- temporary segment for register one 
	
	signal R2_A	: std_logic_vector (0 to SegmentSize-1);	-- temporary segment for register two
	signal R2_B	: std_logic_vector (0 to SegmentSize-1);	-- temporary segment for register two
	signal R2_C	: std_logic_vector (0 to SegmentSize-1);	-- temporary segment for register two
	
	begin
	
		-- Inserting inputs into the registers
		regist1:	FlipFlop port map (clkSwitch, X, reg1);
		regist2:	FlipFlop port map (clkSwitch, Y, reg2);
		
		-- Taking the register values and putting them through the 
		-- AdderSubtractor and BitwiseOperations
		fourbit: AdderSubtractor port map (reg1, reg2, S, co, opcode(0), overflow);
		bitwise: BitwiseOperations port map (opcode, reg1, reg2, BWR);
		
		-- Decoder
		AS_decoder: Decoder port map (S, S(3), AS_A, AS_B, AS_C);
		BW_decoder: Decoder port map (BWR, BWR(3), BW_A, BW_B, BW_C);
		R1_decoder: Decoder port map (reg1, reg1(3), R1_A, R1_B, R1_C);
		R2_decoder: Decoder port map (reg2, reg2(3), R2_A, R2_B, R2_C);
		
		process (opcode, displayRegister, S, BWR, reg1, reg2, AS_A, AS_B, AS_C, 
				   BW_A, BW_B, BW_C, R1_A, R1_B, R1_C, R2_A, R2_B, R2_C, co, overflow)
		begin 
			if ( (opcode = "0000" OR opcode = "0001") AND (displayRegister = '0') ) then
				-- Takes temporary segments and puts them as actual output
				A <= AS_A;
				B <= AS_B;
				C <= AS_C;
				
				-- Keeps 4th segment off at all times
				D <= "1111111";
				E <= "1111111";
				F <= "1111111";
				G <= "1111111";
				H <= "1111111";
				
				CoutLED <= co;
				OverFlowLED <= overflow;
		
				-- When the output is Zero
				if (S = "0000") then
					zeroLED <= '1';
				else
					zeroLED <= '0';
				end if;
				
				-- Turning off the green LEDs when adding or subtracting
				BitZero <= '0';
				BitOne <= '0';
				BitTwo <= '0';
				BitThree <= '0';
			
			
			-- Display what is in the registers while turning off
			-- everything else
			elsif (displayRegister = '1') then
				A <= R1_A;
				B <= R1_B;
				C <= R1_C;
				D <= "1111111";
				E <= R2_A;
				F <= R2_B;
				G <= R2_C;
				H <= "1111111";
				
				-- Turning off all LEDs
				BitZero <= '0';
				BitOne <= '0';
				BitTwo <= '0';
				BitThree <= '0';
				CoutLED <= '0';
				overFlowLED <= '0';
				ZeroLED <= '0';
				
				
			-- Showing the Bitwise Operation Result
			else
				A <= BW_A;
				B <= BW_B;
				C <= BW_C;
				
				-- Keeps 4th segment off at all times
				D <= "1111111";
				E <= "1111111";
				F <= "1111111";
				G <= "1111111";
				H <= "1111111";
				
				-- Process for lighting up the Leds
				if (BWR(0) = '1') then
					BitZero <= '1';
				else
					BitZero <= '0';
				end if;
				
				if (BWR(1) = '1') then
					BitOne <= '1';
				else
					BitOne <= '0';
				end if;
					
				if (BWR(2) = '1') then
					BitTwo <= '1';
				else
					BitTwo <= '0';
				end if;
				
				if (BWR(3) = '1') then
					BitThree <= '1';
				else
					BitThree <= '0';
				end if;
				
				-- Turning off green LEDs
				CoutLED <= '0';
				overFlowLED <= '0';
				ZeroLED <= '0';
				
			end if;
		end process;
  
end arch;