library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pwm_controller is

	generic (CLK_PERIOD : time := 20 ns
);
	
	port (clk 			: in std_logic;
	      rst 			: in std_logic;					             -- W.D --
	      period 		: in unsigned(10 - 1 downto 0); --period     10.4
	      duty_cycle 	: in unsigned(18 - 1 downto 0); --duty cycle 18.17
	      output 		: out std_logic
);

end entity pwm_controller;



architecture pwm_controller_arch of pwm_controller is
	

	signal    period_cnt			: unsigned(25 downto 0);
	signal    duty_cnt			: unsigned(43 downto 0);
	signal	 cnt					: unsigned(33 downto 0);
	signal    done					: std_logic := '0';
	signal	 clock_number		: unsigned(15 downto 0);

	begin
				clock_number <= to_unsigned((1 ms/CLK_PERIOD), 16);
				period_cnt <= unsigned(clock_number * period);
				duty_cnt <= unsigned((duty_cycle*(clock_number*period))/131072);

	Counter : process (clk, rst)
		
		begin
		
		
					if (rst = '1') then
							cnt <= to_unsigned(1, 34);
							output <= '1';
							done <= '0';

					elsif (rising_edge(clk) and cnt < period_cnt) then
								cnt <= cnt + 1;
								done <= '1';
				
						if (cnt > duty_cnt) then
							output <= '0';
							done <= '0';
							else
							output <='1';
						end if;
						
					elsif (rising_edge(clk) and cnt >= period_cnt) then
							cnt <= to_unsigned(1, 34);
							done <= '0';
				

					end if;

				end process;



end architecture;