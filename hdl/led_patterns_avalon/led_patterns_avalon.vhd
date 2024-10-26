library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity led_patterns_avalon is
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
			push_button 			: in std_logic;
			switches 				: in std_logic_vector(3 downto 0);
			led 						: out std_logic_vector(7 downto 0));
			
end entity led_patterns_avalon;


architecture led_patterns_avalon_arch of led_patterns_avalon is

component led_patterns is

	generic (system_clock_period : time := 20 ns);
 
			port   (clk						: in std_logic;
					  rst						: in std_logic;
					  push_button			: in std_logic;
					  base_period			: in unsigned(7 downto 0);
					  switches				: in std_logic_vector(3 downto 0);
					  hps_led_control		: in std_logic;
					  led_reg				: in std_logic_vector(7 downto 0);
					  led						: out std_logic_vector(7 downto 0));
				
end component led_patterns;


signal hps_led_control	: std_logic;
signal base_period		: unsigned(7 downto 0)  := "00010000";
signal led_reg				: std_logic_vector(7 downto 0);

begin
		
		LED_STATES : led_patterns port map (	clk   			 => clk,
															rst   			 => rst,
															push_button 	 => push_button,
															switches 		 => switches,
															hps_led_control => hps_led_control,
															base_period 	 => base_period,
															led_reg			 => led_reg,
															led				 => led);
		
		
		avalon_register_read : process(clk)
			begin
			if rising_edge(clk) and avs_read = '1' then
			case avs_address is
			when "00" =>  avs_readdata <= ("0000000000000000000000000000000" & hps_led_control);
			when "01" => avs_readdata <= ("000000000000000000000000" & std_logic_vector(base_period));
			when "10" => avs_readdata <= ("000000000000000000000000" & led_reg);
			when others => avs_readdata <= (others => '0'); 
			end case;
			end if;
			end process;
			
		avalon_register_write : process(clk)
			begin
			if rising_edge(clk) and avs_write = '1' then
			  case avs_address is
			when "00" => hps_led_control <= avs_writedata(0);
			when "01" => base_period(7 downto 3) <= unsigned(avs_writedata(7 downto 3));
			when "10" => led_reg(7 downto 0) <= avs_writedata(7 downto 0);
			when others => 
			end case;
			end if;
			end process;
			
			
 

 


end architecture;