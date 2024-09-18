library ieee;
use ieee.std_logic_1164.all;
use work.assert_pkg.all;
use work.print_pkg.all;
use work.tb_pkg.all;

entity one_pulse_tb is
end entity one_pulse_tb;

architecture testbench of one_pulse_tb is

  constant CLK_PERIOD : time := 20 ns;

 component one_pulse is 
	port(	clk	: in std_ulogic;
		rst	: in std_ulogic;
		input	: in std_ulogic;
		pulse	: out std_ulogic);
end component one_pulse;
 -- signal expected	: std_ulogic;
  signal clk_tb        	: std_ulogic := '0';
  signal rst_tb      	: std_ulogic := '0';
  signal input_tb       : std_ulogic := '0';
  signal pulse_tb		: std_ulogic;

begin

  dut : component one_pulse
    port map (
      clk  	=> clk_tb,
      rst 	=> rst_tb,
      input  	=> input_tb,
      pulse	=> pulse_tb 
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

    input_tb <= '0';
    wait for 4 * CLK_PERIOD;

    input_tb <= '1';
    wait for 5 * CLK_PERIOD;

    input_tb <= '0'; 
    wait for 3 * CLK_PERIOD;

    input_tb <= '1';
    wait for 3 * CLK_PERIOD;

    input_tb <= '0'; 
    wait for 3 * CLK_PERIOD;

    wait;

  end process input_stim;

  -- Create the expected synchronized output waveform
 check_pulse : process is 
	variable expected : std_ulogic;
    begin

	wait_for_clock_edge(clk_tb);
	expected := '0';
	assert_eq(pulse_tb, expected, "Expected Low at 2 CC");

	wait_for_clock_edge(clk_tb);
	expected := '0';
	assert_eq(pulse_tb, expected, "Expected high at 3 CC");

	wait_for_clock_edge(clk_tb);
	expected := '0';
	assert_eq(pulse_tb, expected, "Expected Low at 4 CC");

	wait_for_clock_edge(clk_tb);
	expected := '0';
	assert_eq(pulse_tb, expected, "Expected Low at 4 CC");

	wait_for_clock_edge(clk_tb);
	expected := '1';
	assert_eq(pulse_tb, expected, "Expected Low at 4 CC");

	wait_for_clock_edge(clk_tb);
	expected := '0';
	assert_eq(pulse_tb, expected, "Expected Low at 4 CC");
	
	wait_for_clock_edge(clk_tb);
	expected := '0';
	assert_eq(pulse_tb, expected, "Expected Low at 4 CC");
	
	wait_for_clock_edge(clk_tb);
	expected := '0';
	assert_eq(pulse_tb, expected, "Expected Low at 4 CC");
	
	wait_for_clock_edge(clk_tb);
	expected := '0';
	assert_eq(pulse_tb, expected, "Expected Low at 4 CC");

	wait_for_clock_edge(clk_tb);
	expected := '0';
	assert_eq(pulse_tb, expected, "Expected Low at 4 CC");
	
	wait_for_clock_edge(clk_tb);
	expected := '0';
	assert_eq(pulse_tb, expected, "Expected Low at 4 CC");

	wait_for_clock_edge(clk_tb);
	expected := '0';
	assert_eq(pulse_tb, expected, "Expected Low at 4 CC");
	
	wait_for_clock_edge(clk_tb);
	expected := '1';
	assert_eq(pulse_tb, expected, "Expected Low at 4 CC");

	wait_for_clock_edge(clk_tb);
	expected := '0';
	assert_eq(pulse_tb, expected, "Expected Low at 4 CC");
	





 end process check_pulse;

end architecture testbench;
