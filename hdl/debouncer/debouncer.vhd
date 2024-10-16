library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity debouncer is 
	
	generic (clk_period	: time := 20 ns;
		 debounce_time	:time);
	
	port (clk	: in	std_logic;
	      rst	: in	std_logic;
         input	: in	std_logic;
	  debounced	: out	std_logic);
	  
end entity debouncer;


architecture debouncer_arch of debouncer is 

signal enable		:	std_logic; 
signal latch		:	std_logic;
signal count		:	integer range 0 to 5000000;
constant COUNTER_LIMIT	:	integer:= (debounce_time/clk_period);

	----- FSM ------------------------------------
type State_Type is (rest, noise_high, waiting, noise_low);
signal current_state : State_Type;
signal next_state    : State_type;

	begin
		
		COUNTER : process (clk, enable)
		begin
			if (enable = '0') then
				count <= 0;
			elsif (rising_edge(clk)) and (enable = '1') then 
				if (count < COUNTER_LIMIT - 2) then 				
					count <= count + 1;
					latch <= '0';
						
				elsif (count = COUNTER_LIMIT - 2) then
					latch <= '1';
					count <= 0;							
				end if;
			end if;
		end process;
		
	
		STATE_MEMORY : process (clk, rst)
		begin
			if (rst = '1')  then
				current_state <= rest;
			elsif (rising_edge(clk)) then 
				current_state <= next_state;
			end if;
		end process;
		
-------------------------------------------------

	NEXT_STATE_LOGIC : process (current_state, input, latch)
		begin
		
		case	(current_state) is

			when rest => if input = '0' then
					next_state <= rest;	
				     elsif input = '1' then
					next_state <= noise_high;
				end if;				
			
			when noise_high => if latch = '0' then
					   next_state <= noise_high;
					   elsif latch = '1' then
					   next_state <= waiting;
				end if;	

			when waiting => if input = '0' then
					next_state <= noise_low;
					elsif input = '1' then
					next_state <= waiting;
				end if;

			when noise_low => if latch = '0' then
					  next_state <= noise_low;
				          elsif latch = '1' then
					  next_state <= rest;
				end if;						
			
			end case;
		end process;
		
-----------------------------------------------------------

		OUTPUT_LOGIC : process (current_state)
			begin
				case (current_state) is
				
					when rest => 
						debounced <= '0';
						enable <= '0';
					
					when noise_high =>
						debounced <= '1';
						enable <= '1';					

					when waiting =>
						debounced <= input;
						enable <= '0';
						
					
					when noise_low =>
						debounced <= '0';
						enable <= '1';
		
						
					end case;
		end process;
end architecture;