----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07/04/2026 12:20:30 PM
-- Design Name: 
-- Module Name: double_dabble - Behavioral
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
use work.Utility_Pkg.Bitwidth_BDCWidth;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity double_dabble is
generic(
    INPUT_WIDTH : integer := 8
);

Port (   
    binary_input : in std_logic_vector(INPUT_WIDTH - 1 downto 0);
    bcd_output : out std_logic_vector(Bitwidth_BDCWidth(INPUT_WIDTH) - 1 downto 0)
    
 );
end double_dabble;

architecture Behavioral of double_dabble is
    signal BCD : std_logic_vector(Bitwidth_BDCWidth(INPUT_WIDTH) - 1 downto 0) := (others => '0');
begin

    process(binary_input)
    variable binary : unsigned(INPUT_WIDTH - 1 downto 0) := (others => '0');
    variable BCD_num : unsigned(Bitwidth_BDCWidth(INPUT_WIDTH) - 1 downto 0) := (others => '0');
    
    variable bcd_width : integer := Bitwidth_BDCWidth(INPUT_WIDTH);
    variable shifts : integer := 0;
    
    variable top_bound : integer := 0;
    variable bottom_bound : integer := 0;
   
    begin
    binary := unsigned(binary_input);
    BCD_num := (others => '0');
    shifts := 0;
    top_bound := 0;
    bottom_bound := 0;
    
    while shifts < INPUT_WIDTH loop
    shifts := shifts + 1;
           
        --check each BCD digit to see if its 5 or greater
        for i in 0 to (bcd_width/4 - 1) loop
            top_bound := (bcd_width - 1) -(4 * i);
            bottom_bound := (bcd_width - 4) - (4 * i);
            
            if BCD_num(top_bound downto bottom_bound) >= "0101" then 
                BCD_num(top_bound downto bottom_bound) := BCD_num(top_bound downto bottom_bound) + "0011";
            end if;
        end loop;
        
        --shift BCD_num left 1
        BCD_num := shift_left(BCD_num, 1);
        --move MSB of binary to LSB of BCD_num
        BCD_num(0):=  binary(INPUT_WIDTH -1);
        --shift binary left 
        binary := shift_left(binary, 1);
    end loop;
    
    BCD <= std_logic_vector(BCD_num);
    end process;
    
    bcd_output <= BCD;
end Behavioral;
