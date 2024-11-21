
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pwm_controller_tb is
    -- Testbench has no ports
end pwm_controller_tb;

architecture pwm_controller_tb_arch of pwm_controller_tb is
    -- Component declaration
    component pwm_controller is
        generic (
            CLK_PERIOD: time:= 20 ns
        );
        port (
            clk         : in  std_logic;
            rst         : in  std_logic;
            period      : in  unsigned(10 - 1 downto 0);
            duty_cycle  : in  unsigned(18 - 1 downto 0);
            output      : out std_logic
        );
    end component;

    -- Clock signal
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal period : unsigned(10 - 1 downto 0) := "0000001010";
    signal duty_cycle : unsigned(18 - 1 downto 0):= "011110000000000000";
    signal output : std_logic;

    -- Clock period constant (50 MHz)
    constant CLK_PERIOD : time := 20 ns;

begin

    -- Clock generation process
    clk_gen : process
    begin
        while true loop
            clk <= not clk;
            wait for CLK_PERIOD / 2; -- Toggle every half period
        end loop;
    end process clk_gen;

    -- DUT instantiation
    dut: pwm_controller
        generic map (
            CLK_PERIOD => CLK_PERIOD
        )
        port map (
            clk        => clk,
            rst        => rst,
            period     => period,
            duty_cycle => duty_cycle,
	    output     => output
        );

    -- Stimulus process
    stimulus : process
    begin
        -- Reset the DUT
        rst <= '1';
        wait for 50 ns; -- Hold reset for a while
        rst <= '0';

        wait;
    end process stimulus;

end architecture;
