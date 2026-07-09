----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/28/2026 01:20:24 PM
-- Design Name: 
-- Module Name: OutputRegister - Behavioral
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

entity OutputRegister is
Port ( 
    clk : in std_logic;
    load : in std_logic;
    reset : in std_logic;
    input : in std_logic_vector(7 downto 0);
    output: out std_logic_vector(7 downto 0)
);
end OutputRegister;

architecture Behavioral of OutputRegister is
    signal data : std_logic_vector(7 downto 0) := (others => '0');
begin
    process(clk, reset)
    begin
        if reset = '1' then
            data <= (others =>'0');
        
        elsif rising_edge(clk) then
            if load = '1' then
                data <= input;
            end if;
        end if;  
    end process;
    output <= data; -- always outputing to display 
end Behavioral;