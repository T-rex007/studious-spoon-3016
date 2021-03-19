--------------------------------------------------------------------------------
-- Engineer: Tyrel Caodgan
--
-- Create Date:    03/18/2021
-- Design Name:    
-- Module Name:   AlarmSettingModule
-- Project Name:   24hour clock
-- Target Device:  Spartan 6
-- Tool versions:  Xilinx 7.1 ISE
-- Description: Alarm Setting Module
-- Dependencies:
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity AlarmSettingModule is
	Port(clk : in std_logic;
		reset : in std_logic;
		done : in std_logic;
		AlarmEnable : std_logic;
        toggle : in std_logic;
		AlarmValue : out std_logic_vector(15 downto 0));
end AlarmSettingModule;

architecture Behavioral of AlarmSettingModule is
----------------------components----------------------

component modulo24_counter_alarm
    Port(reset : in  STD_LOGIC;
        ce : in  STD_LOGIC;
		toggle : in STD_LOGIC;
		dout: out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component modulo60_counter_alarm
  Port(clk : in std_logic;
        reset : in std_logic;
		swreset : in std_logic;
		ce : in std_logic;
		dout : out std_logic_vector(7 downto 0));
end component;

component modulo2_counter_alarm 
  Port(clk : in std_logic;
        reset : in std_logic;
		ce : in std_logic;
		dataout : out std_logic;
		tc : out std_logic);
end component;

component debounce_1bit
	Port(clock: in STD_LOGIC;
		RESET: in STD_LOGIC;
		D_IN: in STD_LOGIC;   
		Q_OUT: out STD_LOGIC);
end component;

component Register_With_16x16_bits_alarm is
    Port(D : in  STD_LOGIC_VECTOR(15 downto 0);
           clk : in  STD_LOGIC;
           load : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           outputs : out  STD_LOGIC_VECTOR (15 downto 0));
end component;
-----------------------signals------------------------

signal mod60_tc : std_logic;
signal mod24_tc : std_logic;

signal clk_dummy : std_logic;
signal swreset_sig : std_logic;
signal sigdummy1 : std_logic;

signal mod24_sel_enable : std_logic;
signal mod60_sel_enable : std_logic;

signal mod3_to_option_select : std_logic;
signal done_sig : std_logic;
signal ce_sel_sig : std_logic;
signal ce_sel_sig_60 : std_logic;
signal alarm_value_sig : std_logic_vector( 15 downto 0);
 
begin
-- tc <= mod60_tc and mod24_tc;
-- Used Disable counter
clk_dummy <= '0';
swreset <= '0';
ce_sel_sig_60 <= not(ce_sel_sig);
cop1_A : modulo60_counter
    port map(clk => toggle,
        reset => reset,
		swreset => swreset_sig,
		ce => ce_sel_sig_60,
		dataout => alarm_value_sig(7 downto 0),
		tc => mod60_tc);

cop2_A : AlarmModulo24_counter
    Port map(reset => reset,
        ce => ce_sel_sig,
        toggle => toggle,
        tc => mod24_tc,
        dout => alarm_value_sig(15 downto 8));

cop3_A : modulo2_counter_alarm 
  	Port map(clk => done_sig;
        reset => reset;
		dataout => ce_sel_sig);

cop4_A : debounce_1bit
	Port map(clock => clk,
		RESET => reset,
		D_IN => done,   
		Q_OUT => done_sig);

cop5_A : Register_With_16x16_bits_alarm
    Port map(D => alarm_value_sig,
        	clk => clk,
           	load => AlarmEnable,
           	clr => '0',
           	outputs  => AlarmValue ;
end component;

end Behavioral;