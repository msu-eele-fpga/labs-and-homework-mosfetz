library ieee;
use ieee.std_logic_1164.all;

entity timed_counter is

generic (clk_period : time;
	count_time : time);

port (clk : in std_ulogic;
      enable : in boolean;
      done : out boolean);

end entity timed_counter;

	

architecture timed_counter_arch of timed_counter is 

	signal Count_Out_int	:	integer range 0 to 10000000;
	constant COUNTER_LIMIT	:	integer:= (count_time/clk_period);

	begin

	Counter : process (clk, enable)
		begin
			if (enable = false) then
			    Count_Out_int <= 0;
			    done <= false;

			elsif (rising_edge(clk)) then 

				if (Count_Out_int = COUNTER_LIMIT) then
				  Count_Out_int <= 0;
				  done <= true;
				else
				  Count_Out_int <= Count_Out_int + 1;
				  done <= false;
				end if;

			end if;

		end process;
end architecture; 
