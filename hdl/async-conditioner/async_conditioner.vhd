library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity async_conditioner is 
	port ( 	clk	: in std_logic;
		rst	: in std_logic;
		async	: in std_logic;
		sync	: out std_logic
		);
end entity async_conditioner;

architecture async_conditioner_arch of async_conditioner is


	component synchronizer is
    	port (clk   : in    std_logic;
      	      async : in    std_logic;
      	      sync  : out   std_logic);
	end component synchronizer;

	component debouncer is 
	
	generic (clk_period	: time := 20 ns;
		 debounce_time	:time);
	
	port (clk	: in	std_logic;
	      rst	: in	std_logic;
              input	: in	std_logic;
	      debounced	: out	std_logic);

	end component debouncer;

	component one_pulse is 
	port(   clk	: in std_logic;
		rst	: in std_logic;
		input	: in std_logic;
		pulse	: out std_logic);

	end component one_pulse;

signal pinput	: std_logic;
signal input	: std_logic;
signal debounce	: std_logic;

 
	begin
	SYNCO: synchronizer port map (clk => clk,
			  	      async => async,
				      sync => input);

	DEBOG : debouncer generic map  (debounce_time => 100 ms)

			  port map (clk => clk,
				    rst => rst,
				    input => input,
				    debounced => pinput);

	ONEPU : one_pulse port map (clk => clk,
				    rst => rst,
				    input => pinput,
				    pulse => sync);
  
end architecture;
