----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/05/2026 11:05:58 AM
-- Design Name: 
-- Module Name: FPGA_Top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FPGA_Top is
Port ( 
    clk100 : in std_logic;
    btn_step : in std_logic;
    reset : in std_logic;
    mode : in std_logic;
    seg : out std_logic_vector(6 downto 0);
    an : out std_logic_vector(3 downto 0);
    bus_value : out std_logic_vector(7 downto 0)
);
end FPGA_Top;
architecture Behavioral of FPGA_Top is
    signal slow_clk : std_logic;
    signal step_clk : std_logic;
    signal cpu_clk : std_logic;
    signal cpu_out : std_logic_vector(7 downto 0);
    signal cpu_bus_value : std_logic_vector(7 downto 0);  

    signal bcd_raw : std_logic_vector(11 downto 0);
    signal bcd_bus : std_logic_vector(15 downto 0);

    signal sel_a, sel_b : std_logic := '0';
    signal mode_sync_a : std_logic_vector(1 downto 0) := (others => '0');
    signal mode_sync_b : std_logic_vector(1 downto 0) := (others => '0');
begin

CPU_inst : entity work.CPU
port map(
    clk => cpu_clk,
    clear => reset,
    data_output => cpu_out,
    bus_value => cpu_bus_value
);

bcd_conv : entity work.double_dabble
generic map (
    INPUT_WIDTH => 8
)
port map (
    binary_input => cpu_out,
    bcd_output => bcd_raw
);

bcd_bus <= "0000" & bcd_raw;

clk_div : entity work.clock_divider
port map (
    clk_in => clk100,
    reset => reset,
    clk_out => slow_clk
);

btn_clk : entity work.button_clock
port map (
    clk => clk100,
    btn_in => btn_step,
    pulse => step_clk
);

display : entity work.sevenseg_mux
port map (
    clk => clk100,
    bcd_in => bcd_bus,
    seg => seg,
    an => an
);


process(slow_clk, reset)
begin
    if reset = '1' then
        mode_sync_a <= (others => '0');
        sel_a <= '0';
    elsif falling_edge(slow_clk) then
        mode_sync_a <= mode_sync_a(0) & mode;
        if sel_b = '0' then
            sel_a <= not mode_sync_a(1);
        end if;
    end if;
end process;

process(step_clk, reset)
begin
    if reset = '1' then
        mode_sync_b <= (others => '0');
        sel_b <= '0';
    elsif falling_edge(step_clk) then
        mode_sync_b <= mode_sync_b(0) & mode;
        if sel_a = '0' then
            sel_b <= mode_sync_b(1);
        end if;
    end if;
end process;

cpu_clk <= (slow_clk and sel_a) or (step_clk and sel_b);
bus_value <= cpu_bus_value;

end Behavioral;
