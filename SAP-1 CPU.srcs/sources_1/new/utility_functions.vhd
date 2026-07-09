----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/04/2026 02:50:28 PM
-- Design Name: 
-- Module Name: utility_functions - Behavioral
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
package Utility_Pkg is
    -- takes a bit width n and finds the width for equivalent BCD
    function Bitwidth_BDCWidth(n : integer) return integer;
end package; 

package body Utility_Pkg is 

    function Bitwidth_BDCWidth(n : integer) return integer is 
        variable max_value : integer := 2**n - 1;
        variable bcd_width : integer := 1;
    begin
        while max_value >= 10 loop
            max_value := max_value /10;
            bcd_width := bcd_width + 1;
        end loop;
        bcd_width := bcd_width * 4;
        return bcd_width;
    end function Bitwidth_BDCWidth;

end package body;

