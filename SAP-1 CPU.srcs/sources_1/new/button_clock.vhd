----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/05/2026 12:55:29 PM
-- Design Name: 
-- Module Name: button_clock - Behavioral
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

entity button_clock is
    Port (
        clk : in std_logic;
        btn_in : in std_logic;
        pulse : out std_logic
    );
end button_clock;

architecture Behavioral of button_clock is
    signal sync        : std_logic_vector(1 downto 0) := "00";
    signal debounced   : std_logic := '0';
    signal last        : std_logic := '0';
    signal counter     : unsigned(19 downto 0) := (others => '0');
    -- 10ms at 100MHz = 1,000,000 cycles 20 bits covers that
    constant DEBOUNCE_LIMIT : unsigned(19 downto 0) := to_unsigned(1000000, 20);
begin
    process(clk)
    begin
        if rising_edge(clk) then
            -- 2 flop synchronizer
            sync(0) <= btn_in;
            sync(1) <= sync(0);

            -- debounce: only updates once sync(1) has been
            -- stable at its current value for DEBOUNCE_LIMIT cycles
            if sync(1) = debounced then
                counter <= (others => '0');
            else
                if counter = DEBOUNCE_LIMIT then
                    debounced <= sync(1);
                    counter <= (others => '0');
                else
                    counter <= counter + 1;
                end if;
            end if;
            
            last <= debounced;
        end if;
    end process;

    pulse <= debounced and not last;
end Behavioral;
