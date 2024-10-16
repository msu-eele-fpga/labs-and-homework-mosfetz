library ieee;
use ieee.std_logic_1164.all;


entity synchronizer is
    port (
      clk   : in    std_logic;
      async : in    std_logic;
      sync  : out   std_logic
    );
end entity synchronizer;

architecture synchronizer_arch of synchronizer is

signal Q1 : std_logic; 
signal D1 : std_logic;
signal D2 : std_logic;
signal Q2 : std_logic;

begin 
	process(clk)
	 begin
		if(rising_edge(clk)) then
		Q1 <= async;
		Q2 <= D2;
		else
	 end if;
	end process;	


sync <= Q2;
D2 <= Q1;

end architecture;

