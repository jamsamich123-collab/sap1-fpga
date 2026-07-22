----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/27/2026 09:08:16 AM
-- Design Name: 
-- Module Name: RAM16x8 - Behavioral
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

entity ROM16x8 is -- upon second thought this will be more of a ROM then a ram as currently it does not have 
                  -- any ablity to be changed with in the cpu
                  -- file name is wrong this code should be put in a new file call ROM16x8 
Port (
 clk : in std_logic;
 ADDRESS_load : in std_logic;
 address_in : in std_logic_vector(3 downto 0);
 data_out : out std_logic_vector(7 downto 0)
 );
end ROM16x8;

architecture Behavioral of ROM16x8 is
    subtype Word is std_logic_vector(7 downto 0);
    type grid_16x8 is array (0 to 15) of Word;
    
    signal ROM : grid_16x8 := ( --default instruction used in the test bench
    0 => "00001000", -- LDA 8
    1 => "00011001", -- ADD 9
    2 => "11100000", -- OUT (value of 0e)
    3 => "00101010", -- SUB 10
    4 => "11100000", -- OUT (value of 0c)
    5 => "00011011", -- ADD 11
    6 => "11100000", -- OUT (value of 5b)
    7 => "11110000", --HLT
    
    8 => "00000110",
    9 => "00001000",
    10 => "00000010",
    11 => "01001111",
    12 => "00000000",
    13 => "00000000",
    14 => "00000000",
    15 => "00000000"
    );
    signal address : std_logic_vector(3 downto 0) := (others => 'X');
begin
    process(ADDRESS_load)
    begin
        if ADDRESS_load = '1' then
            address <= address_in;
        end if;
    end process;
    data_out <= ROM(to_integer(unsigned(address)))(7 downto 0);
end Behavioral;
