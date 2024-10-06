library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity pat_machine is
 
			port   (clk						: in std_ulogic;
					  rst					: in std_ulogic;
					  clk_b0125				: in std_ulogic;
					  clk_b025				: in std_ulogic;				
					  clk_b05				: in std_ulogic;
	              			  clk_b1				: in std_ulogic;
					  clk_b2				: in std_ulogic;
					  Pat_S0				: out std_logic_vector(6 downto 0);
					  Pat_S1				: out std_logic_vector(6 downto 0);
					  Pat_S2				: out std_logic_vector(6 downto 0);
					  Pat_S3				: out std_logic_vector(6 downto 0);
					  Pat_S4				: out std_logic_vector(6 downto 0);
					  blink					: out std_logic);
				
end entity pat_machine;

architecture pat_machine_arch of pat_machine is

	signal LED_1AAT			: unsigned(6 downto 0) := "1000000";
	signal LED_2AAT			: unsigned(6 downto 0) := "0000011";
	signal LED_7UP			: unsigned(6 downto 0) := "0000000";
	signal LED_7DOWN		: unsigned(6 downto 0) := "1111111";
	signal LED_CUST			: unsigned(6 downto 0) := "1111010";
	signal Count_Out_int		: integer range 0 to 50000000;
	signal blinkB			: std_logic;



	begin


																	
	P0 : process (clk_b05, rst)
			
			
			begin
			if (rst = '1') then	
				LED_1AAT <= "1000000";
				blink <= '0';
				blinkb <= '0';
			
			elsif (rising_edge(clk_b05)) then
				LED_1AAT <= rotate_right(LED_1AAT, 1);
				Pat_S0(6 downto 0) <= STD_LOGIC_VECTOR(LED_1AAT);
				blinkb <= not blinkb;
				blink <= blinkb;
						
			end if;
			
			end process;
	
	
	P1 : process (clk_b025, rst)
			
			
			begin
			if (rst = '1') then			
				LED_2AAT <= "0000011";

			elsif (rising_edge(clk_b025)) then
				LED_2AAT <= rotate_left(LED_2AAT, 1);
				Pat_S1(6 downto 0) <= STD_LOGIC_VECTOR(LED_2AAT);
			end if;
			end process;
	
	P2 : process (clk_b2, rst)
			
			
			begin
			if (rst = '1') then			
				LED_7UP <= "0000000";
			elsif (rising_edge(clk_b2)) then
				LED_7UP <= (LED_7UP + 1);
				Pat_S2(6 downto 0) <= STD_LOGIC_VECTOR(LED_7UP);
						
				end if;
		  end process;
						
	P3 : process (clk_b0125, rst)
			
			
			begin
			if (rst = '1') then			
				LED_7DOWN <= "1111111";
			elsif (rising_edge(clk_b0125)) then
				LED_7DOWN <= (LED_7DOWN - 1);
				Pat_S3(6 downto 0) <= STD_LOGIC_VECTOR(LED_7DOWN);
			end if;
			end process;
			
			
	P4 : process (clk_b1, rst)
			
			
			begin
			if (rst = '1') then			
				LED_CUST <= "1111010";
			elsif (rising_edge(clk_b1)) then
				LED_CUST <= (LED_CUST - 6);
				Pat_S4(6 downto 0) <= STD_LOGIC_VECTOR(LED_CUST);
						
			end if;
	
			end process;
	
		end architecture;
	