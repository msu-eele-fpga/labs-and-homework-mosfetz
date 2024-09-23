library ieee;
use ieee.std_logic_1164.all;
use work.assert_pkg.all;
use work.print_pkg.all;
use work.tb_pkg.all;

entity async_conditioner_tb is
end entity async_conditioner_tb;

architecture testbench of async_conditioner_tb is

  constant CLK_PERIOD : time := 20 ns;

component async_conditioner is 
	port ( 	clk	: in std_ulogic;
		rst	: in std_ulogic;
		async	: in std_ulogic;
		sync	: out std_ulogic
		);

end component async_conditioner;
 -- signal expected	: std_ulogic;
  signal clk_tb        	: std_ulogic := '0';
  signal rst_tb      	: std_ulogic := '0';
  signal async_tb       : std_ulogic := '0';
  signal sync_tb		: std_ulogic;

begin

  dut : component async_conditioner
    port map (
      clk  	=> clk_tb,
      rst 	=> rst_tb,
      async  	=> async_tb,
      sync	=> sync_tb 
    );

  clk_tb <= not clk_tb after CLK_PERIOD / 2;



  -- Reset Stimulus 
  rst_stim : process is
  begin

    rst_tb <= '1';
    wait for 1.8 * CLK_PERIOD;

    rst_tb <= '0';

    wait;

  end process rst_stim;

  -- Input Stimulus 
  input_stim : process is
  begin

    async_tb <= '0';
    wait for 4 * CLK_PERIOD;

    async_tb <= '1';
    wait for 0.50 * CLK_PERIOD;

    async_tb <= '0'; 
    wait for 0.50 * CLK_PERIOD;

    async_tb <= '1';
    wait for 0.25 * CLK_PERIOD;

    async_tb <= '0'; 
    wait for 0.25 * CLK_PERIOD;

    async_tb <= '1';
    wait for 3 * CLK_PERIOD;

    async_tb <= '0'; 
    wait for 3 * CLK_PERIOD;


    wait;

  end process input_stim;

  -- Create the expected synchronized output waveform
 check_pulse : process is 
	variable expected : std_ulogic;
    begin

	wait_for_clock_edge(clk_tb);
	expected := '0';
	assert_eq(sync_tb, expected, "Expected Low at 2 CC");

	wait_for_clock_edge(clk_tb);
	expected := '0';
	assert_eq(sync_tb, expected, "Expected high at 3 CC");

	wait_for_clock_edge(clk_tb);
	expected := '0';
	assert_eq(sync_tb, expected, "Expected Low at 4 CC");

	wait_for_clock_edge(clk_tb);
	expected := '0';
	assert_eq(sync_tb, expected, "Expected Low at 4 CC");

	wait_for_clock_edge(clk_tb);
	expected := '0';
	assert_eq(sync_tb, expected, "Expected Low at 4 CC");

	wait_for_clock_edge(clk_tb);
	expected := '0';
	assert_eq(sync_tb, expected, "Expected Low at 4 CC");
	
	wait_for_clock_edge(clk_tb);
	expected := '0';
	assert_eq(sync_tb, expected, "Expected Low at 4 CC");
	
	wait_for_clock_edge(clk_tb);
	expected := '1';
	assert_eq(sync_tb, expected, "Expected Low at A CC");
	

	





 end process check_pulse;

end architecture testbench;
