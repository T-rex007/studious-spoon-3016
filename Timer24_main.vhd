--------------------------------------------------------------------------------
-- Company: Marcus's Technology Solutions LTD
-- Engineer: Marcus Lloyde George
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
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity hour24_timer_main is
  Port(clk : in std_logic;
        reset : in std_logic;
		ce : in std_logic;
		toggle : in  STD_LOGIC;
		set_flag_params : in  STD_LOGIC_VECTOR( 1 downto 0);
		seg : out std_logic_vector(6 downto 0);
		anode : inout std_logic_vector(3 downto 0);
		blink_tc : out std_logic;
		tc : out std_logic);
end hour24_timer_main;

architecture Behavioral of hour24_timer_main is
----------------------components----------------------
component FrequencyDivider1kHz
	Port (RESET : in STD_LOGIC; 
		clk : in  STD_LOGIC;
		clk_1kHz : out  STD_LOGIC);
end component;

component FrequencyDivider1Hz
	Port (RESET : in STD_LOGIC; 
		clk : in  STD_LOGIC;
		clk_1Hz : out  STD_LOGIC);
end component;


component TimeModule is
  	Port(clk_1Hz : in std_logic;
       	clk_1kHz: std_logic;
		reset : in std_logic;
        toggle : in std_logic;
		done : std_logic;
        set_flag_params : in  STD_LOGIC_VECTOR(1 downto 0);
		AlarmOn : in std_logic;
		timeout : out std_logic_vector(15 downto 0);
		tc : out std_logic);
end component;;

component time_multiplexer_4digit
  Port(clk : in std_logic; --multiplexing clock(1 kHz)      
       	reset : in std_logic; -- reset signal 
		display_value : in std_logic_vector(15 downto 0); --BCD digits to be displayed
       	seg : out std_logic_vector(6 downto 0); --7 cathodes
      	anode : inout std_logic_vector(3 downto 0));--selection of the 4 7-segnment displays
end component;

component debounce_1bit
	Port(clock: in STD_LOGIC;
		RESET: in STD_LOGIC;
		D_IN: in STD_LOGIC;   
		Q_OUT: out STD_LOGIC);
end component;

component multiplexer16bit_2to1 is
  Port(A : in std_logic_vector( 15 downto 0);
        B : in std_logic_vector(15 downto 0);
		sel : in std_logic;
		O : out std_logic_vector(15 downto 0));
end component;

component modulo2_counter
  Port(clk : in std_logic;
       	reset : in std_logic;
		ce : in std_logic;
		dataout : out std_logic;
		tc : out std_logic);
end component;

-----------------------signals------------------------
------------------frequency_divider
signal clk_1kHz : std_logic; --1kHz clock signal
signal clk_1Hz : std_logic; --1Hz clock signal

------------------modulo60_counter
signal data_out_sig0 : std_logic_vector(7 downto 0);
signal data_out_sig1 : std_logic_vector(7 downto 0);
signal display_value_sig : std_logic_vector(15 downto 0);
signal display_value_sig1 : std_logic_vector(15 downto 0);
signal set_flag_params_sig : std_logic;

signal display_blank_val : std_logic_vector(15 downto 0);
signal blank_sel_sig : std_logic;
signal blank_reset : std_logic;
signal toggle_sig : std_logic;

begin
display_blank_val <= "1111111111111111";
blank_reset <= not (set_flag_params(0) or set_flag_params(1));

cop1 : FrequencyDivider1kHz
	Port map(RESET => reset, 
		clk => clk,
		clk_1kHz => clk_1kHz);
			  
cop2 : FrequencyDivider1Hz
	Port map(RESET => reset, 
		clk => clk,
		clk_1Hz => clk_1Hz);
		
cop3 : TimeModule is
  	Port map(clk_1Hz => clk_1Hz;
       	clk_1kHz => clk_1kHz;
		reset => reset;
        toggle => toggle_sig;
		done => done;
        set_flag_params => set_flag_params;
		AlarmOn  => alarm_flag_sig;
		timeout =>display_value_sig ;
		tc => tc);

cop4 : time_multiplexer_4digit
  	port map(clk =>clk_1kHz ,      
		reset => reset, 
		display_value => display_value_sig1,
		seg => seg,
		anode => anode);

cop5 : debounce_1bit
	Port map(clock => clk,
		RESET => reset,
		D_IN => toggle,   
		Q_OUT => toggle_sig);

cop6 : multiplexer16bit_2to1 
  	port map(A =>display_value_sig, 
        B => display_blank_val, 
		sel => blank_sel_sig,
		O => display_value_sig1);

cop7 : modulo2_counter
  port map(clk => clk_1Hz,
		reset => blank_reset,
		ce => ce,
		dataout => blank_sel_sig,
		tc => blink_tc);

end Behavioral;