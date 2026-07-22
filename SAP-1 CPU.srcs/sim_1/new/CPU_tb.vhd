----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/01/2026 03:45:15 PM
-- Design Name: 
-- Module Name: CPU_tb - Behavioral
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

entity CPU_tb is
end CPU_tb;

architecture Behavioral of CPU_tb is

    signal clk : std_logic := '0';
    signal clear : std_logic := '0';
    signal OUT_en : std_logic := '0';
    signal data_output : std_logic_vector(7 downto 0);
    signal bus_value : std_logic_vector(7 downto 0);

begin

    DUT : entity work.CPU
        port map(
            clk => clk,
            clear => clear,
            OUT_en => OUT_en,
            
            data_output => data_output,
            bus_value => bus_value
        );

    -- 10 ns clock
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;
    
    stimulus : process
    begin 
        clear <= '1';
        wait for 20 ns;
        
        clear <= '0';
        wait;
    end process stimulus;
    
    -- test process
    Test : process
        variable output_count : integer := 0;
    begin 
    
        wait until rising_edge(clk);
        
        if OUT_en = '1' then
            wait for 10 ns; 
            case output_count is 
                
                when 0 =>
                    assert data_output = x"0E"
                    report "First output was incorrect"
                    severity error;
               
               when 1 =>
                    assert data_output = x"0C"
                    report "Second output was incorrect"
                    severity error;
               
               when 2 =>
                    assert data_output = x"5B"
                    report "Third output was incorrect"
                    severity error;
                    
               when others =>
                    NULL;
               end case;
               
               output_count := output_count + 1;     
        end if;
        
        if output_count > 2 then
            report "ALL TESTS PASSED";
        end if;
        
    end process Test;

end Behavioral;
