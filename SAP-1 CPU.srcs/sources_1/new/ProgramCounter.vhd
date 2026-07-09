----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/25/2026 02:10:59 PM
-- Design Name: 
-- Module Name: ProgramCounterSource - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: This entity defines the input and output ports and logic of the Program Counter in a SAP-1 CPU 
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

entity ProgramCounterSource is
Port ( 
    clk : in std_logic;
    reset : in std_logic;
    pc_inc : in std_logic; 
    pc_out : out std_logic_vector(3 downto 0)
    
);
end ProgramCounterSource;
architecture Behavioral of ProgramCounterSource is
    signal PC : unsigned(3 downto 0) := (others => '0'); 
begin
    process(clk, reset)
    begin
        if reset = '1' then
                PC <= (others => '0');
        elsif rising_edge(clk) then 
            if pc_inc = '1' then 
                PC <= PC + 1;
            end if;
        end if;
    end process;
    pc_out <= std_logic_vector(PC); 
end Behavioral;
