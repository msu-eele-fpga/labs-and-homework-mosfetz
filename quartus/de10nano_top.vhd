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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library altera;
use altera.altera_primitives_components.all;

entity de10nano_top is
  port (

    fpga_clk1_50 : in    std_logic;
    fpga_clk2_50 : in    std_logic;
    fpga_clk3_50 : in    std_logic;

    ----------------------------------------
    --  Push button inputs (KEY)
    --  See DE10 Nano User Manual page 24
    --  The KEY push button inputs produce a '0'
    --  when pressed (asserted)
    --  and produce a '1' in the rest (non-pushed) state
    ----------------------------------------
	 push_button_n	: in	  std_logic_vector(1 downto 0);
    sw 				: in    std_logic_vector(3 downto 0);
    led 				: out   std_logic_vector(7 downto 0);
    gpio_0 			: inout std_logic_vector(35 downto 0);
    gpio_1 			: inout std_logic_vector(35 downto 0);
    arduino_io      : inout std_logic_vector(15 downto 0);
    arduino_reset_n : inout std_logic);
	 
	 
end entity de10nano_top;


architecture de10nano_arch of de10nano_top is
	signal led_reg				: std_ulogic_vector(7 downto 0);
	signal rst					: std_ulogic;
	signal false 				: boolean;
	signal push_button		: std_ulogic;
	signal inverse_button	: std_logic_vector(1 downto 0);
	signal base_period		: unsigned(7 downto 0)  := "00010000";
	signal pat_led				: std_logic_vector(7 downto 0);
	
	component led_patterns is

	generic (system_clock_period : time := 20 ns);
 
			port   (	clk					: in std_ulogic;
						rst					: in std_ulogic;
						push_button			: in std_ulogic;
						switches				: in std_logic_vector(3 downto 0);
						hps_led_control	: in boolean;
						base_period			: in unsigned(7 downto 0);
						led_reg				: in std_ulogic_vector(7 downto 0);
						led					: out std_logic_vector(7 downto 0));
				
	end component led_patterns;
	
	component async_conditioner is
	
		port (clk	: in std_ulogic;
				rst	: in std_ulogic;
				async	: in std_ulogic;
				sync	: out std_ulogic);

   	end component async_conditioner;

		begin
		
				--	if (HPS_LED_control == true) then
			--		LED <= led_reg;
			--		else
			--		LED <= pat_led;
			--		end if;
					
					
					rst <= inverse_button(0);
					
					inverse_button(1 downto 0) <= not push_button_n(1 downto 0);
					false <= false;
					push_button <= push_button;
					

			LED_STATES : led_patterns port map (	clk   			 => fpga_clk1_50,
																rst   			 => rst,
																push_button 	 => push_button,
																switches 		 => sw,
																hps_led_control => false,
																base_period 	 => base_period,
																led_reg			 => led_reg,
																led				 => led);
																
			DEBOUNCE : async_conditioner port map (clk   			 => fpga_clk1_50,
																rst   			 => rst,
																async 	 		 => inverse_button(1),
																sync 		 		 => push_button);							
															

end architecture de10nano_arch;
