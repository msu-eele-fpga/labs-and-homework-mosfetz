library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity one_pulse is 
	port(
		clk	: in std_ulogic;
		rst	: in std_ulogic;
		input	: in std_ulogic;
		pulse	: out std_ulogic);
end entity one_pulse;
 


architecture one_pulse_arch of one_pulse is 

signal mem	: std_ulogic;

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