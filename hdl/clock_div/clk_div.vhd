library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity clock_div is
 
		port (clk				: in std_logic;
		      rst				: in std_logic;
		      base_period		: in unsigned(7 downto 0);
		      clk_b0125		: out std_logic;
		      clk_b025			: out std_logic;				
		      clk_b05			: out std_logic;
	              clk_b1			: out std_logic;
		      clk_b2			: out std_logic);
							
end entity clock_div;

architecture clock_div_arch of clock_div is
	
	signal	proper_unsigned_clk_frequency: unsigned(35 downto 0);
	signal	munsigned_clk_frequency: unsigned(39 downto 0);
	signal	unsigned_clk_frequency: unsigned(31 downto 0);	
	constant system_clk_frequency	: integer := 50000000;
	signal	count_clk_b0125		: integer range 0 to 50000000;
	signal	count_clk_b025			: integer range 0 to 50000000;
	signal	count_clk_b05			: integer range 0 to 50000000;
	signal	count_clk_b1			: integer range 0 to 50000000;
	signal	count_clk_b2			: integer range 0 to 100000000;
	signal	wclk_b0125				: std_logic;
	signal	wclk_b025				: std_logic;
	signal	wclk_b05					: std_logic;
	signal	wclk_b1					: std_logic;
	signal	wclk_b2					: std_logic;
	signal	cycles_clk_b0125		: integer range 0 to 50000000;
	signal	cycles_clk_b025		: integer range 0 to 50000000;
	signal	cycles_clk_b05			: integer range 0 to 50000000;
	signal	cycles_clk_b1			: integer range 0 to 50000000;
	signal	cycles_clk_b2			: integer range 0 to 1000000000;

	begin
	unsigned_clk_frequency <= to_unsigned(system_clk_frequency, unsigned_clk_frequency'length);
	munsigned_clk_frequency <= (base_period * unsigned_clk_frequency);
	proper_unsigned_clk_frequency <= munsigned_clk_frequency(39 downto 4);
	
	cycles_clk_b0125 <= to_integer(shift_right(unsigned(proper_unsigned_clk_frequency), 3));
	cycles_clk_b025 <= to_integer(shift_right(unsigned(proper_unsigned_clk_frequency), 2));
	cycles_clk_b05 <= to_integer(shift_right(unsigned(proper_unsigned_clk_frequency), 1));
	cycles_clk_b1 <= to_integer(unsigned(proper_unsigned_clk_frequency));
	cycles_clk_b2 <= to_integer(shift_left(unsigned(proper_unsigned_clk_frequency), 1));
				
	
	clk_b0125 <= wclk_b0125;
	clk_b025 <= wclk_b025;
	clk_b05 <= wclk_b05;
	clk_b1 <= wclk_b1;
	clk_b2 <= wclk_b2; 

	Counter : process (clk, rst)
		begin
		
		
			if (rst = '1') then
			   count_clk_b0125 <= 0;
				count_clk_b025 <= 0;
				count_clk_b05 <= 0;
				count_clk_b1 <= 0;
				count_clk_b2 <= 0;

			elsif (rising_edge(clk)) then 
					
				  count_clk_b0125 <= count_clk_b0125 + 1;
				  count_clk_b025 <= count_clk_b025 + 1;
				  count_clk_b05 <= count_clk_b05 + 1;
				  count_clk_b1 <= count_clk_b1 + 1;
				  count_clk_b2 <= count_clk_b2 + 1;
			

				if (count_clk_b0125 = (cycles_clk_b0125)) then
				  	count_clk_b0125 <= 0;
				  	wclk_b0125 <= not wclk_b0125;
					end if;
				
				if (count_clk_b025 = (cycles_clk_b025)) then
				  	count_clk_b025 <= 0;
				  	wclk_b025 <= not wclk_b025;
					end if;
				
				if (count_clk_b05 = (cycles_clk_b05)) then
				  	count_clk_b05 <= 0;
				  	wclk_b05 <= not wclk_b05;
					end if;

				if (count_clk_b1 = (cycles_clk_b1)) then
				  	count_clk_b1 <= 0;
				  	wclk_B1 <= not wclk_B1;
					end if;

				if (count_clk_b2 = (cycles_clk_b2)) then
				  	count_clk_b2 <= 0;
				  	wclk_b2 <= not wclk_b2;
					end if;

			end if;

		end process;
			
	

		
end architecture;

