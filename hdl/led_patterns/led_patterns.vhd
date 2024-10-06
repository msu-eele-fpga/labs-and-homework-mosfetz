library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity led_patterns is

	generic (system_clock_period : time := 20 ns);
 
			port   (clk					: in std_ulogic;
					  rst				: in std_ulogic;
					  push_button			: in std_ulogic;
					  base_period			: in unsigned(7 downto 0);
					  switches			: in std_logic_vector(3 downto 0);
					  hps_led_control		: in boolean;
					  led_reg			: in std_ulogic_vector(7 downto 0);
					  led				: out std_logic_vector(7 downto 0));
				
end entity led_patterns;

architecture led_patterns_arch of led_patterns is

	constant system_clk_frequency	: integer := 50000000;
	type State_Type is (S0, S1, S2, S3, S4, intermediate);
	signal current_state 	: State_type;
	signal next_state    	: State_type;
	signal last_state			: State_type;
	signal led_vector			: std_logic_vector(7 downto 0);
	signal done				: std_ulogic;
	signal reset_n				: std_ulogic;
	signal push_button_out 			: std_ulogic;
	signal LED_1AAT				: std_logic_vector(6 downto 0) := "1000000";
	signal LED_1AAT_R			: unsigned(6 downto 0);
	signal LED_2AAT				: std_logic_vector(6 downto 0) := "0000011";
	signal LED_7UP				: unsigned(6 downto 0) := "0000000";
	signal LED_7DOWN			: unsigned(6 downto 0) := "1111111";
	signal LED_CUST				: std_logic_vector(6 downto 0) := "1111010";
	signal Count_Out_int			: integer range 0 to 50000000;
	signal clk_b0125			: std_ulogic;
	signal clk_b025				: std_ulogic;				
	signal clk_b05				: std_ulogic;
	signal clk_b1				: std_ulogic;
	signal clk_b2				: std_ulogic;
	signal Pat_S0				: std_logic_vector(6 downto 0);
	signal Pat_S1				: std_logic_vector(6 downto 0);
	signal Pat_S2				: std_logic_vector(6 downto 0);
	signal Pat_S3				: std_logic_vector(6 downto 0);
	signal Pat_S4				: std_logic_vector(6 downto 0);
	signal pat				: std_logic_vector(3 downto 0);
	signal start				: std_logic;
	signal blink				: std_logic;
	
	
	component clock_div is
 
		port (clk			: in std_ulogic;
		      rst			: in std_ulogic;
		      base_period		: in unsigned(7 downto 0);
		      clk_b0125			: out std_ulogic;
		      clk_b025			: out std_ulogic;				
		      clk_b05			: out std_ulogic;
	              clk_b1			: out std_ulogic;
		      clk_b2			: out std_logic);
							
	end component clock_div;
	
	component pat_machine is
 
			port   (clk						: in std_ulogic;
					  rst					: in std_ulogic;
					  clk_b0125				: in std_ulogic;
					  clk_b025				: in std_ulogic;				
					  clk_b05				: in std_ulogic;
	              			  clk_b1				: in std_ulogic;
					  clk_b2				: in std_logic;
					  Pat_S0				: out std_logic_vector(6 downto 0);
					  Pat_S1				: out std_logic_vector(6 downto 0);
					  Pat_S2				: out std_logic_vector(6 downto 0);
					  Pat_S3				: out std_logic_vector(6 downto 0);
					  Pat_S4				: out std_logic_vector(6 downto 0);
					  blink					: out std_logic);
				
	end component pat_machine;

	


	begin
	
	
	
	
																		 
	 clock_src : clock_div port map (	clk   		=> clk,
													rst   		=> rst,
													base_period => base_period,
													clk_b0125 	=> clk_b0125,
													clk_b025 	=> clk_b025,
													clk_b05 		=> clk_b05,
													clk_b1 		=> clk_b1,
													clk_b2		=> clk_b2);
													
	 pat_m	  : pat_machine port map ( clk			=> clk,
													rst			=> rst,
													clk_b0125	=> clk_b0125,	
													clk_b025		=> clk_b025,
													clk_b05		=> clk_b05,
													clk_b1		=> clk_b1,
													clk_b2		=> clk_b2,
													Pat_S0		=> Pat_S0,
													Pat_S1		=> Pat_S1,
													Pat_S2		=> Pat_S2,
													Pat_S3		=> Pat_S3,
													Pat_S4		=> Pat_S4,
													blink			=> blink);
																	
																	
			----- FSM ---------------------------------------------------------------------------
	
			STATE_MEMORY : process (clk, rst)
			begin
			if (rst = '1') then
				current_state <= S0;
						
			
			elsif (rising_edge(clk)) then 
				current_state <= next_state;
			end if;
			end process;
			
			
			
			NEXT_STATE_LOGIC : process (current_state, push_button, done)
				begin
		
			case	(current_state) is
			when S0 => if push_button = '0' then
						last_state <= current_state;
						next_state <= current_state;
				elsif push_button = '1' then
						next_state <= intermediate;
						
				end if;				
			
			when S1 => if push_button = '0' then
						last_state <= current_state;
						next_state <= current_state;
				elsif push_button = '1' then
						
						next_state <= intermediate;
				end if;			
			
			when S2 => if push_button = '0' then
						last_state <= current_state;
						next_state <= current_state;
				elsif push_button = '1' then
						
						next_state <= intermediate;
				end if;
				
			when S3 => if push_button = '0' then
						last_state <= current_state;
						next_state <= current_state;
				elsif push_button = '1' then
						
						next_state <= intermediate;
				end if;
			
			when S4 => if push_button = '0' then
						last_state <= current_state;
						next_state <= current_state;
				elsif push_button = '1' then
						
						next_state <= intermediate;
				end if;

			when intermediate => 
				
				if done = '0' then
					next_state <= current_state;	
					end if;	
				if done = '1' then						
					case (switches) is 
						
					when "0000" => 
					next_state <= S0;
						
					when "0001" =>
					next_state <= S1;
						
					when "0010" => 
					next_state <= S2;
						
					when "0011" =>
					next_state <= S3;
						
					when "0100" => 
					next_state <= S4;
					
					when others =>
					next_state <= last_state;
				end case;
				end if;
			end case;
			end process;
		
		OUTPUT_LOGIC : process (current_state)
			begin
				case (current_state) is
				
					when S0	=> 
						
						led(6 downto 0) <= Pat_S0;
						led(7) <= blink;
						start <= '0';
						
					when S1 =>				
						
						led(6 downto 0) <= Pat_S1;
						led(7) <= blink;
						start <= '0';
						
					when S2 =>				
						
						led(6 downto 0) <= Pat_S2;
						led(7) <= blink;
						start <= '0';
						
					when S3 =>	
		
						led(6 downto 0) <= Pat_S3;
						led(7) <= blink;
						 start <= '0';
						
					when S4 =>	
						
						led(6 downto 0) <= Pat_S4;
						led(7) <= blink;
						start <= '0';
						
					when intermediate =>
					
						led(7 downto 0) <= "0000" & switches(3 downto 0);
						start <= '1';
						
						
				end case;
			end process;
						
	
	tima : process (clk, start)
			
			
			begin
			if (start = '0') then
			
			elsif (rising_edge(clk)) then 
			
						if (Count_Out_int	< system_clk_frequency) then
							Count_Out_int <= Count_Out_int + 1;
							done <= '0';
							end if;
						if (Count_Out_int	= system_clk_frequency) then
							Count_Out_int <= 0;
							done <= '1';
							end if;
							
					end if;
			end process;
			
	
	
		end architecture;
	
	