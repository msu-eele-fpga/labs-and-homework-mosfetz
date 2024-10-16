library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity one_pulse is 
	port(
		clk	: in std_logic;
		rst	: in std_logic;
		input	: in std_logic;
		pulse	: out std_logic);
end entity one_pulse;
 


architecture one_pulse_arch of one_pulse is 

signal mem	: std_logic;

	begin

	POP : process (clk, rst, input)
		begin	
			if (rst = '1') then
				pulse <= '0';
				mem <= '0';
		
			elsif (rising_edge(clk)) then
				if (input = '1') and (mem = '0') then
					pulse <= '1';
					mem <= '1';
				elsif (input = '1') and (mem = '1') then
					pulse <= '0';
				elsif (input = '0') and (mem = '1') then
					pulse <= '0';
					mem <= '0';
				end if;
			end if;
		end process;
end architecture;