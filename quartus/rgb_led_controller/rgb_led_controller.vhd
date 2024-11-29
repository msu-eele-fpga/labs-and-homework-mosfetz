library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rgb_led_controller is

	generic (CLK_PERIOD : time := 20 ns);
	
	
	port (clk 					: in std_logic;
	      rst 					: in std_logic;
	      period 				: in std_logic_vector(10 - 1 downto 0);
			red_duty_cycle 	: in std_logic_vector(18 - 1 downto 0);
	      green_duty_cycle 	: in std_logic_vector(18 - 1 downto 0);
			blue_duty_cycle 	: in std_logic_vector(18 - 1 downto 0);
	      rgb_output 			: out std_logic_vector(2 downto 0));

			
end entity rgb_led_controller;

architecture rgb_led_controller_arch of rgb_led_controller is

	component pwm_controller is

		generic (CLK_PERIOD : time := 20 ns);
	
		port (clk 			: in std_logic;
				rst 			: in std_logic;
				period 		: in unsigned(10 - 1 downto 0);
				duty_cycle 	: in unsigned(18 - 1 downto 0);
				output 		: out std_logic);

	end component pwm_controller;
				
	signal rgb_drive		: std_logic_vector(2 downto 0);
	

	begin
	
		rgb_output <= rgb_drive;
		
		
		RED :   pwm_controller 	port map (clk 				=> clk,
														rst 			=> rst,
														period 		=> unsigned(period),
														duty_cycle 	=> unsigned(red_duty_cycle),
														output		=> rgb_drive(2)
														);
											
		GREEN : pwm_controller 	port map (clk 				=> clk,
														rst 			=> rst,
														period 		=> unsigned(period),
														duty_cycle 	=> unsigned(green_duty_cycle),
														output		=> rgb_drive(1)
														);
											
		BLUE :  pwm_controller 	port map (clk 			=> clk,
														rst 			=> rst,
														period 		=> unsigned(period),
														duty_cycle 	=> unsigned(blue_duty_cycle),
														output		=> rgb_drive(0)
														);

		
		
end architecture;