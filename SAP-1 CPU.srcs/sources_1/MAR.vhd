----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/25/2026 02:43:46 PM
-- Design Name: 
-- Module Name: MAR - Behavioral
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
use IEEE.NUMERIC_STD.All;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MAR is
Port (
    clk : in std_logic;
    load : in std_logic;
    input : in std_logic_vector(3 downto 0);
    address_out : out std_logic_vector(3 downto 0)
 );
end MAR;

architecture Behavioral of MAR is
    signal address : std_logic_vector(3 downto 0) := (others => '0'); 
begin
    process (clk)
    begin
    if rising_edge(clk) then
        if load = '1' then
            address <= input;
        end if;
    end if;
    end process;
    address_out <= address;
end Behavioral;
