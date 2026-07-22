----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/28/2026 03:42:52 PM
-- Design Name: 
-- Module Name: CPU - Behavioral
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

entity CPU is
Port (
    clk : in std_logic;
    clear: in std_logic;
    
    OUT_en : out std_logic; --for testing purposes
    data_output : out std_logic_vector(7 downto 0);
    bus_value : out std_logic_vector(7 downto 0)
 );
end CPU;

architecture Behavioral of CPU is

signal W_bus : std_logic_vector(7 downto 0);
-- Control signals
signal pc_inc : std_logic;
signal A_load : std_logic;
signal B_load : std_logic;
signal ALU_add : std_logic;
signal ALU_loadA : std_logic;
signal ALU_loadB : std_logic; 
signal IR_load : std_logic;
signal OUT_load : std_logic;
signal MAR_load : std_logic;
signal ADDRESS_load : std_logic;
signal HLT : std_logic;
signal bus_sel : std_logic_vector(2 downto 0);

-- bus signals
signal pc_out : std_logic_vector(3 downto 0);
signal MAR_out : std_logic_vector(3 downto 0);
signal ROM_out : std_logic_vector(7 downto 0);
signal A_out : std_logic_vector(7 downto 0);
signal B_out : std_logic_vector(7 downto 0);
signal ALU_out : std_logic_vector(7 downto 0);
signal IR_out : std_logic_vector(7 downto 0);

begin

    Controller_inst : entity work.Controller
    port map(
        clk => clk,
        clear => clear,
    
        opcode_in => W_bus(7 downto 4),
    
        pc_inc => pc_inc,
        A_load => A_load,
        B_load => B_load,
        add_ALU => ALU_add,
        ALU_loadA => ALU_loadA,
        ALU_loadB => ALU_loadB,
        IR_load => IR_load,
        OUT_load => OUT_load,
        MAR_load => MAR_load,
        ADDRESS_load => ADDRESS_load,
        HLT => HLT,
    
        bus_sel => bus_sel
    );

    ProgramCounterSource : entity work.ProgramCounterSource
        port map(
        clk => clk,
        reset => clear,
        pc_inc => pc_inc,
    
        pc_out => pc_out
    );
    
    MAR : entity work.MAR
    port map(
        clk => clk,
        load => MAR_load,
        input => W_bus(3 downto 0),
    
        address_out => MAR_out
    );
    
    ROM16x8 : entity work.ROM16x8
    port map(
        clk => clk,
        address_in => W_bus(3 downto 0),
        ADDRESS_load => ADDRESS_load,
       
        data_out => ROM_out
    );
    
    InstructionRegister : entity work.InstructionRegister
    port map(
        clk => clk,
        clear => clear,
        load => IR_load,
        data_in => W_bus,
        
        bus_out => IR_out
    );
    
    Accumulator : entity work.Accumulator
    port map (
        clk => clk,
        reset => clear,
        load => A_load,
        input => W_bus,
        
        output => A_out
    );
    
    BufferRegister : entity work.BufferRegister
    port map (
        clk => clk,
        reset => clear,
        load => B_load,
        input => W_bus,
        
        output => B_out
    );
    
    OutputRegister : entity work.OutputRegister
    port map (
        clk => clk,
        reset => clear,
        load => OUT_load,
        input => W_bus,
        
        output => data_output 
    );
    
    AdderSubtractor : entity work.AdderSubtractor
    port map(
        ADD => ALU_add,
        load_A => A_load,
        load_B => B_load,
        input_A => A_out,
        input_B => B_out,
        
        output => ALU_out
    );

    bus_mux : process(all)
    begin 
        case bus_sel is
            when "000" => 
                W_bus <= "0000" & pc_out;
            when "001" => 
                W_bus <= "0000" & MAR_out;
            when "010" =>
                W_bus <= ROM_out;
            when "011" =>
                W_bus <= A_out;
            when "100" =>
                W_bus <= B_out;
            when "101" =>
                W_bus <= ALU_out;
            when "110" =>
                W_bus <= IR_out;
            when others =>
                W_bus <= "00000000";
        end case;
        
        
        OUT_en <= OUT_load; --for testing purposes
        bus_value <= W_bus;
    end process bus_mux;
end Behavioral;
