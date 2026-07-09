----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/28/2026 09:46:11 AM
-- Design Name: 
-- Module Name: AdderSubtractor - Behavioral
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

entity AdderSubtractor is
Port (
    ADD : in std_logic;
    load_A : in std_logic;
    load_B : in std_logic;
    input_A: in std_logic_vector(7 downto 0);
    input_B: in std_logic_vector(7 downto 0);
    output : out std_logic_vector(7 downto 0)
 );
end AdderSubtractor;

architecture Behavioral of AdderSubtractor is
    signal result : unsigned(7 downto 0) := (others => '0'); -- assuming unsigned numbers only for both addition and subtraction
    signal A : unsigned(7 downto 0) := (others => '0');
    signal B : unsigned(7 downto 0) := (others => '0');
begin
    process(ADD, input_A, input_B, A, B) 
    begin
        --if load_A = '1' then
            A <= unsigned(input_A);
        --elsif load_B = '1' then 
            B <= unsigned(input_B);
        --end if;
        
        if ADD = '1' then 
            result <= A + B;-- add
        else    
            result <= A - B;-- sub
        end if;
    end process;
    output <= std_logic_vector(result);
end Behavioral;
