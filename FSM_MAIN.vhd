--------------------------------------------------------------------------------
-- Company: Marcus's Technology Solutions LTD
-- Engineer: Tyrel Cadogan
--
-- Create Date:    12:41:30 04/29/09
-- Design Name:    
-- Module Name:    modulo60_counter_main - Behavioral
-- Project Name:   
-- Target Device:  
-- Tool versions:  Xilinx 7.1 ISE
-- Description:
--
-- Dependencies:
-- 
-- Revision:  1
-- Revision 0.01 - File Created
-- Additional Comments:	 This IPcore can be used by anyone as long as 
--								 this Header Comment Block	is retained in this 
--								 position of the .vhd file
-- 
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilin primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM_Module is
        Port(clk : in std_logic;
        reset : in std_logic;
        ce : in std_logic;
        toggle : in  STD_LOGIC;
        done  : in  STD_LOGIC;
		  alarmSettingMode : in STD_LOGIC;
		  minSettingMode : in STD_LOGIC;
		  hrSettingMode : in STD_LOGIC;
        seg : out std_logic_vector(6 downto 0);
        anode : inout std_logic_vector(3 downto 0);
        blink_tc : out std_logic;
        tc : out std_logic);
end FSM_Module;

architecture Behavioral of FSM_Module is
----------------------components----------------------


component FSM_Controller
	Port(alarmSettingMode : in STD_LOGIC;
		  minSettingMode : in STD_LOGIC;
		  hrSettingMode : in STD_LOGIC;
        reset : in STD_LOGIC;
        clk : in STD_LOGIC;
        hrSetEnable : out STD_LOGIC;
        minSetEnable : out STD_LOGIC;
        alarmSetEnable : out STD_LOGIC;
        resetStateEnable: out STD_LOGIC);
end component;

component DataBlock 
        Port(clk : in std_logic;
        reset : in std_logic;
        ce : in std_logic;
        toggle : in  STD_LOGIC;
        done  : in  STD_LOGIC;
        hrSetEnable : in STD_LOGIC;
        minSetEnable : in STD_LOGIC;
        seg : out std_logic_vector(6 downto 0);
        anode : inout std_logic_vector(3 downto 0);
        AlarmEnable : in std_logic;
        blink_tc : out std_logic;
        tc : out std_logic);
end component;

-----------------------signals------------------------
signal controller_to_register :  STD_LOGIC_VECTOR(2 downto 0);
signal register_to_controller :  STD_LOGIC_VECTOR(2 downto 0);
signal param_sig : std_logic_vector(1 downto 0);
signal alarmSetEnable_sig : std_logic;
signal reset_sig : std_logic;
signal hr_sig : std_logic;
signal min_sig : std_logic;
begin

        
cop1_FSM : FSM_Controller
	Port map(alarmSettingMode => alarmSettingMode,
		  minSettingMode => minSettingMode,
		  hrSettingMode => hrSettingMode,
        reset => reset,
        clk => clk, 
        hrSetEnable =>hr_sig,
        minSetEnable => min_sig,
        alarmSetEnable =>alarmSetEnable_sig,
        resetStateEnable => reset_sig);

cop2_FSM : DataBlock
        Port map(clk => clk,
        reset => reset,
        ce => ce,
        toggle  =>toggle,
        done   =>done,
        hrSetEnable => hr_sig,
        minSetEnable =>min_sig ,
        seg => seg,
        anode => anode,
        AlarmEnable =>alarmSetEnable_sig,
        blink_tc  =>blink_tc,
        tc  => tc);

end Behavioral;