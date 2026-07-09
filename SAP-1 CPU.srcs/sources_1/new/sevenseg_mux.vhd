----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/05/2026 01:41:27 PM
-- Design Name: 
-- Module Name: sevenseg_mux - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sevenseg_mux is
    Port (
        clk : in std_logic;
        bcd_in : in std_logic_vector(15 downto 0);
        seg : out std_logic_vector(6 downto 0);
        an : out std_logic_vector(3 downto 0)
    );
end sevenseg_mux;

architecture Behavioral of sevenseg_mux is
    signal refresh : unsigned(19 downto 0) := (others => '0');
    signal digit : std_logic_vector(3 downto 0);
    signal sel : std_logic_vector(1 downto 0);
begin

process(clk)
begin
    if rising_edge(clk) then
        refresh <= refresh + 1;
    end if;
end process;

sel <= std_logic_vector(refresh(19 downto 18));

process(sel, bcd_in)
begin
    case sel is
        when "00" =>
            digit <= bcd_in(3 downto 0);
            an <= "1110";
        when "01" =>
            digit <= bcd_in(7 downto 4);
            an <= "1101";
        when "10" =>
            digit <= bcd_in(11 downto 8);
            an <= "1011";
        when others =>
            digit <= bcd_in(15 downto 12);
            an <= "0111";
    end case;
end process;

process(digit)
begin
    case digit is
        when "0000" => seg <= "1000000";
        when "0001" => seg <= "1111001";
        when "0010" => seg <= "0100100";
        when "0011" => seg <= "0110000";
        when "0100" => seg <= "0011001";
        when "0101" => seg <= "0010010";
        when "0110" => seg <= "0000010";
        when "0111" => seg <= "1111000";
        when "1000" => seg <= "0000000";
        when "1001" => seg <= "0010000";
        when others => seg <= "1111111";
    end case;
end process;

end Behavioral;
