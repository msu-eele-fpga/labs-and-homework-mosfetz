library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity rgb_led_controller_avalon is
port (
			clk 						: in std_logic;
			rst 						: in std_logic;
-- avalon memory-mapped slave interface
			avs_read 				: in std_logic;
			avs_write 				: in std_logic;
			avs_address 			: in std_logic_vector(1 downto 0);
			avs_readdata 			: out std_logic_vector(31 downto 0);
			avs_writedata 			: in std_logic_vector(31 downto 0);
-- external I/O; export to top-level
			rgb_output				: out std_logic_vector(2 downto 0));
			
end entity rgb_led_controller_avalon;


architecture rgb_led_controller_avalon_arch of rgb_led_controller_avalon is

	component rgb_led_controller is

		generic (CLK_PERIOD : time := 20 ns
);
		port (clk 					: in std_logic;
				rst 					: in std_logic;
				period 				: in std_logic_vector(10 - 1 downto 0);
				red_duty_cycle 	: in std_logic_vector(18 - 1 downto 0);
				green_duty_cycle 	: in std_logic_vector(18 - 1 downto 0);
				blue_duty_cycle 	: in std_logic_vector(18 - 1 downto 0);
				rgb_output 			: out std_logic_vector(2 downto 0));
				
	end component rgb_led_controller;


		signal red_duty_cycle 		: std_logic_vector(18 - 1 downto 0) := "011110000000000000";
		signal green_duty_cycle 	: std_logic_vector(18 - 1 downto 0) := "000000000000000000";
		signal blue_duty_cycle 		: std_logic_vector(18 - 1 downto 0) := "000000000000000000";
		signal period			: std_logic_vector(10-1 downto 0)  := "0000001010";
		

	begin
		
		RGB_LINKER : rgb_led_controller port map (	clk 					=> clk,
																	rst 					=> rst,
																	period 				=> period,
																	red_duty_cycle 	=> red_duty_cycle,
																	green_duty_cycle 	=> green_duty_cycle,
																	blue_duty_cycle 	=> blue_duty_cycle,
																	rgb_output 			=> rgb_output
																	);
		
		avalon_register_read : process(clk)
			
			begin
			
			if (rst = '1') then
			
				
			
			
			elsif rising_edge(clk) and avs_read = '1' then
			
				case avs_address is
					
					when "00" =>  	avs_readdata <= ("00000000000000" & red_duty_cycle); --32 bit register
					when "01" => 	avs_readdata <= ("00000000000000" & green_duty_cycle);
					when "10" => 	avs_readdata <= ("00000000000000" & blue_duty_cycle);
					when "11" => 	avs_readdata <= ("0000000000000000000000" & period);
					when others => avs_readdata <= (others => '0'); 
				end case;
			end if;
			end process;
			
		avalon_register_write : process(clk)
			begin
			
			if (rst = '1') then
			
			
			elsif rising_edge(clk) and avs_write = '1' then
			  case avs_address is
					when "00" => red_duty_cycle 	<= avs_writedata(18 - 1 downto 0);
					when "01" => green_duty_cycle <= avs_writedata(18 - 1 downto 0);
					when "10" => blue_duty_cycle 	<= avs_writedata(18 - 1 downto 0);
					when "11" => period				<= avs_writedata(10 - 1 downto 0);
					when others => 
				end case;
			end if;
			end process;
			
			
 

 


end architecture;