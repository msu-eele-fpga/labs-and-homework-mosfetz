-- SPDX-License-Identifier: MIT
-- Copyright (c) 2024 Ross K. Snider, Trevor Vannoy.  All rights reserved.
----------------------------------------------------------------------------
-- Description:  Top level VHDL file for the DE10-Nano
----------------------------------------------------------------------------
-- Author:       Ross K. Snider, Trevor Vannoy
-- Company:      Montana State University
-- Create Date:  September 1, 2017
-- Revision:     1.0
-- License: MIT  (opensource.org/licenses/MIT)
----------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity pwm_top is
  port (
    ----------------------------------------
    --  Clock inputs
    --  See DE10 Nano User Manual page 23
    ----------------------------------------
    fpga_clk1_50 : in    std_logic;
    fpga_clk2_50 : in    std_logic;
    fpga_clk3_50 : in    std_logic;


    ----------------------------------------
    --  Push button inputs (KEY[0] and KEY[1])
    --  See DE10 Nano User Manual page 24
    --  The KEY push button inputs produce a '0'
    --  when pressed (asserted)
    --  and produce a '1' in the rest (non-pushed) state
    ----------------------------------------
    push_button_n : in    std_logic_vector(1 downto 0);

    ----------------------------------------
    --  Slide switch inputs (SW)
    --  See DE10 Nano User Manual page 25
    --  The slide switches produce a '0' when
    --  in the down position
    --  (towards the edge of the board)
    ----------------------------------------
    sw : in    std_logic_vector(3 downto 0);

    ----------------------------------------
    --  LED outputs
    --  See DE10 Nano User Manual page 26
    --  Setting LED to 1 will turn it on
    ----------------------------------------
    led : out   std_logic_vector(7 downto 0);

    ----------------------------------------
    --  GPIO expansion headers (40-pin)
    --  See DE10 Nano User Manual page 27
    --  Pin 11 = 5V supply (1A max)
    --  Pin 29 = 3.3 supply (1.5A max)
    --  Pins 12, 30 = GND
    ----------------------------------------
    gpio_0 : inout std_logic_vector(35 downto 0);
    gpio_1 : inout std_logic_vector(35 downto 0);

    ----------------------------------------
    --  Arudino headers
    --  See DE10 Nano User Manual page 30
    ----------------------------------------
    arduino_io      : inout std_logic_vector(15 downto 0);
    arduino_reset_n : inout std_logic

	 );
end entity pwm_top;


architecture pwm_top_arch of pwm_top is

 signal	period 				:	unsigned(10 - 1 downto 0) := "0000011001";
 signal	duty_cycle			:	unsigned(18 - 1 downto 0)	:= "010000000000000000";
 signal	rst					:	std_logic;
 signal	inverse_button		:	std_logic_vector(1 downto 0);
 signal 	output				: 	std_logic;
 
 
	component async_conditioner is
	
		port (clk	: in std_logic;
				rst	: in std_logic;
				async	: in std_logic;
				sync	: out std_logic);

   	end component async_conditioner;

	component pwm_controller is
	
		port (clk 		: in std_logic;
				rst 		: in std_logic;
	      --period 10.4 ms
				period 		: in unsigned(10 - 1 downto 0);
	      --duty cycle 18.17 percent
				duty_cycle 	: in unsigned(18 - 1 downto 0);
				output 		: out std_logic);
	
   	end component pwm_controller;
		
		begin
		
					rst 			<= inverse_button(0);
					led(0) 		<= output;
					gpio_0(0) 	<= output;
					
					inverse_button(1 downto 0) <= not push_button_n(1 downto 0);
					
					
													
			RED 	: pwm_controller port map 		  (clk   			 => fpga_clk1_50,
																rst   			 => rst,
																period 			 => period,
																duty_cycle		 => duty_cycle,
																output 			 => output);
																
		
										
						
															

end architecture;
