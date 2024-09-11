library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity vending_machine is 

	port (clk	:in	std_ulogic;
	      rst	:in	std_ulogic;
	      nickel	:in	std_ulogic;
	      dime	:in	std_ulogic;
	      dispense	:out	std_ulogic;
	      amount	:out	natural range 0 to 15);
						
end entity vending_machine;

architecture vending_machine_arch of vending_machine is 

	----- FSM ------------------------------------
	type State_Type is (C0, C5, C10, C15);
	signal current_state : State_Type;
	signal next_state    : State_type;

	begin

	
		STATE_MEMORY : process (clk, rst)
		begin
			if (rst = '1') then
				current_state <= C0;
			elsif (rising_edge(clk)) then 
				current_state <= next_state;
			end if;
		end process;
		
-------------------------------------------------

	NEXT_STATE_LOGIC : process (current_state, nickel, dime)
		begin
		
		case	(current_state) is
			when C0 => if nickel = '1' and dime = '1' then
					next_state <= C10;	
				elsif nickel = '1' and dime = '0' then
					next_state <= C5;
				elsif nickel = '0' and dime = '1' then
					next_state <= C10;
				elsif nickel = '0' and dime = '0' then
					next_state <= C0;
				end if;				
			
			when C5 => if nickel = '1' and dime = '1' then 
					next_state <= C15;	
				elsif nickel = '1' and dime = '0' then
					next_state <= C10;
				elsif nickel = '0' and dime = '1' then
					next_state <= C15;
				elsif nickel = '0' and dime = '0' then
					next_state <= C5;
				end if;			
			
			when C10 => if nickel = '1' and dime = '1' then 
					next_state <= C15;	
				elsif nickel = '1' and dime = '0' then
					next_state <= C15;
				elsif nickel = '0' and dime = '1' then
					next_state <= C15;
				elsif nickel = '0' and dime = '0' then
					next_state <= C10;
				end if;	
			
			when C15 => 
					next_state <= C0;					
			
			end case;
		end process;
		
-----------------------------------------------------------

		OUTPUT_LOGIC : process (current_state)
			begin
				case (current_state) is
				
					when C0	=> 
						amount <= 0;
						dispense <= '0';	
					when C5 =>				
						amount <= 5;
						dispense <= '0';
					when C10 =>				
						amount <= 10;
						dispense <= '0';
					when C15 =>				
						amount <= 15;
						dispense <= '1';
		
					end case;
			end process;
	
	
	
	
	

end architecture; 