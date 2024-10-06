
# ChatGPT Citation: pat_machine_tb

## Description of AI Tools used
ChatGPT was used to create the pat_machine_tb testbench.

## How the AI tools were used
This code was generated to stimulate the pat_machine component of lab4. A testbench was required for every component used in the lab.

## Why AI tools were used 
I had no idea where to begin wrting a testbench for this component, I resorted to ChatGPT to eliminate writer's block. 

## Entire Exchange 
-- The following code was written by ChatGPT

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_pat_machine is
end tb_pat_machine;

architecture behavior of tb_pat_machine is

    -- Component declaration for the Unit Under Test (UUT)
    component pat_machine is
        port (
            clk            : in std_ulogic;
            rst            : in std_ulogic;
            clk_b0125      : in std_ulogic;
            clk_b025       : in std_ulogic;
            clk_b05        : in std_ulogic;
            clk_b1         : in std_ulogic;
            clk_b2         : in std_ulogic;
            Pat_S0         : out std_logic_vector(6 downto 0);
            Pat_S1         : out std_logic_vector(6 downto 0);
            Pat_S2         : out std_logic_vector(6 downto 0);
            Pat_S3         : out std_logic_vector(6 downto 0);
            Pat_S4         : out std_logic_vector(6 downto 0);
            blink          : out std_logic
        );
    end component;

    -- Testbench signals
    signal clk           : std_ulogic := '0';
    signal rst           : std_ulogic := '0';
    signal clk_b0125     : std_ulogic := '0';
    signal clk_b025      : std_ulogic := '0';
    signal clk_b05       : std_ulogic := '0';
    signal clk_b1        : std_ulogic := '0';
    signal clk_b2        : std_ulogic := '0';
    signal Pat_S0        : std_logic_vector(6 downto 0);
    signal Pat_S1        : std_logic_vector(6 downto 0);
    signal Pat_S2        : std_logic_vector(6 downto 0);
    signal Pat_S3        : std_logic_vector(6 downto 0);
    signal Pat_S4        : std_logic_vector(6 downto 0);
    signal blink         : std_logic;

    -- Clock period definitions
    constant clk_period      : time := 10 ns;
    constant clk_b0125_period: time := 80 ns;
    constant clk_b025_period : time := 40 ns;
    constant clk_b05_period  : time := 20 ns;
    constant clk_b1_period   : time := 10 ns;
    constant clk_b2_period   : time := 5 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: pat_machine
        port map (
            clk => clk,
            rst => rst,
            clk_b0125 => clk_b0125,
            clk_b025 => clk_b025,
            clk_b05 => clk_b05,
            clk_b1 => clk_b1,
            clk_b2 => clk_b2,
            Pat_S0 => Pat_S0,
            Pat_S1 => Pat_S1,
            Pat_S2 => Pat_S2,
            Pat_S3 => Pat_S3,
            Pat_S4 => Pat_S4,
            blink => blink
        );

    -- Clock generation
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    clk_b0125_process: process
    begin
        clk_b0125 <= '0';
        wait for clk_b0125_period / 2;
        clk_b0125 <= '1';
        wait for clk_b0125_period / 2;
    end process;

    clk_b025_process: process
    begin
        clk_b025 <= '0';
        wait for clk_b025_period / 2;
        clk_b025 <= '1';
        wait for clk_b025_period / 2;
    end process;

    clk_b05_process: process
    begin
        clk_b05 <= '0';
        wait for clk_b05_period / 2;
        clk_b05 <= '1';
        wait for clk_b05_period / 2;
    end process;

    clk_b1_process: process
    begin
        clk_b1 <= '0';
        wait for clk_b1_period / 2;
        clk_b1 <= '1';
        wait for clk_b1_period / 2;
    end process;

    clk_b2_process: process
    begin
        clk_b2 <= '0';
        wait for clk_b2_period / 2;
        clk_b2 <= '1';
        wait for clk_b2_period / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset the system
        rst <= '1';
        wait for 10 ns;
        rst <= '0';

        -- Wait for the system to run
        wait for 1000 ns;

        -- End simulation
        wait;
    end process;

end behavior;

---- END GPT CODE

