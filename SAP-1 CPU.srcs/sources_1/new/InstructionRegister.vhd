----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/27/2026 10:12:05 AM
-- Design Name: 
-- Module Name: InstructionRegister - Behavioral
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

entity InstructionRegister is
Port (
    clk : in std_logic;
    load : in std_logic;
    clear : in std_logic;
    data_in : in std_logic_vector(7 downto 0);
    bus_out : out std_logic_vector(7 downto 0)
 );
end InstructionRegister;

architecture Behavioral of InstructionRegister is
    signal data : std_logic_vector(7 downto 0) := (others => '0');
begin
    process(clk, clear)
    begin        
        if clear = '1' then
            data <= (others => '0');
        elsif rising_edge(clk) then
            if load = '1' then
                data <= data_in;
            end if;
        end if;
    end process;
    bus_out <= data;
end Behavioral;
