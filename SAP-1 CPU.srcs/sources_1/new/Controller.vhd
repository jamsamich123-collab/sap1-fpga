----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/28/2026 01:40:19 PM
-- Design Name: 
-- Module Name: Controller - Behavioral
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

entity Controller is
Port ( 
    clk : in std_logic;
    clear : in std_logic; -- same as reset
    opcode_in : in std_logic_vector(3 downto 0);
    
    pc_inc : out std_logic;
    A_load : out std_logic;
    B_load : out std_logic;
    add_ALU : out std_logic;
    ALU_loadA : out std_logic;
    ALU_loadB : out std_logic; 
    IR_load : out std_logic;
    OUT_load : out std_logic; 
    MAR_load : out std_logic;
    ADDRESS_load : out std_logic;
    HLT : out std_logic;
    
    bus_sel : out std_logic_vector(2 downto 0)
);
end Controller;

architecture Behavioral of Controller is
    type cycle_states is (F0, F1, F2, F3, E0, E1, E2, E3, E4, E5 , E6, E7, E8, E9, E10, 
    E11, HLT_state);
    signal state: cycle_states; 
    
    constant bus_pc : std_logic_vector(2 downto 0) := "000";
    constant bus_MAR : std_logic_vector(2 downto 0) := "001";
    constant bus_ROM : std_logic_vector(2 downto 0) := "010";
    constant bus_A : std_logic_vector(2 downto 0) := "011";  
    constant bus_B : std_logic_vector(2 downto 0) := "100";
    constant bus_ALU : std_logic_vector(2 downto 0) := "101";
    constant bus_IR : std_logic_vector(2 downto 0) := "110";
 

begin
    process(clk, clear)
    begin 
    -- default control signals 
    if clear = '1' then
        state <= F0;     
    end if;
    
    if clear = '1' then 
        state <= F0;
    elsif rising_edge(clk) then
        pc_inc <= '0';
        A_load <= '0';
        B_load <= '0';
        add_ALU <= '0';
        ALU_loadA <= '0';
        ALU_loadB <= '0';
        IR_load <= '0';
        OUT_load <= '0';
        MAR_load <= '0';
        ADDRESS_load <= '0';
        HLT <= '0';
        bus_sel <= (others => '0'); 
        
        case state is 
        when F0 => -- F0
            MAR_load <= '1';
            bus_sel <= bus_pc;
            
            state <= F1;
        when F1 => -- F1
            pc_inc <= '1';
            ADDRESS_load <= '1';
            bus_sel <= bus_MAR;
            
            state <= F2;
        when F2 => 
            IR_load <= '1';
            bus_sel <= bus_ROM;
       
            state <= F3;
       when F3 => --decode state puts IR on bus then grabs opcode off it 
            bus_sel <= bus_IR;

            if opcode_in = "0000" then
                state <= E0;
            elsif opcode_in = "0001" then
                state <= E3;
            elsif opcode_in = "0010" then
                state <= E7;
            elsif opcode_in = "1110" then
                state <= E11;
            elsif opcode_in = "1111" then
                HLT <= '1';
                state <= HLT_state;
            end if;
        
        when E0 => -- LDA start 
            MAR_load <= '1';
            bus_sel <= bus_IR;
            
            state <= E1;
        when E1 =>
            ADDRESS_load <= '1';
            bus_sel <= bus_MAR;
            
            state <= E2;
        when E2 => 
            A_load <= '1';
            ALU_loadA <= '1';
            bus_sel <= bus_ROM;
            
            state <= F0;
            -- LDA end
        when E3 => -- ADD start
            MAR_load <= '1';
            bus_sel <= bus_IR;
            
            state <= E4;
        when E4 =>
            ADDRESS_load <= '1';
            bus_sel <= bus_MAR;
            
            state <= E5;
        when E5 => 
            B_load <= '1';
            ALU_loadB <= '1';
            bus_sel <= bus_ROM;
            
            state <= E6;
        when E6 => 
            add_ALU <= '1';
            A_load <= '1';
            bus_sel <= bus_ALU;
            
            state <= F0;
            -- end ADD
        when E7 => -- SUB start
            MAR_load <= '1';
            bus_sel <= bus_IR;
            
            state <= E8;
        when E8 =>
            ADDRESS_load <= '1';
            bus_sel <= bus_MAR;
            
            state <= E9;
        when E9 => 
            B_load <= '1';
            ALU_loadB <= '1';
            bus_sel <= bus_ROM;
            
            state <= E10;
        when E10 =>
            add_ALU <= '0';
            A_load <= '1';
            bus_sel <= bus_ALU;
            
            
            state <= F0;
            -- end SUB
        when E11 => -- start OUT 
            OUT_load <= '1';
            bus_sel <= bus_A;
            
            state <= F0;
            -- end OUT
        when others =>
            -- do nothing either hlt or unrecognized
        end case;
    
    end if;
    end process;

end Behavioral;
