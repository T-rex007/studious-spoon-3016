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

entity modulo60_counter_main is
  Port(clk : in std_logic;
       reset : in std_logic;
		 ce : in std_logic;
		 seg : out std_logic_vector(6 downto 0);
		 anode : inout std_logic_vector(3 downto 0);
		 tc : out std_logic);
end modulo60_counter_main;

architecture Behavioral of modulo60_counter_main is
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

component cop4_modulo60x60
  Port(clk : in std_logic;
       reset : in std_logic;
		 ce : in std_logic;
		 timeout : out std_logic_vector(15 downto 0);
		 tc : out std_logic);
end component;

component time_multiplexer_4digit
  Port(clk : in std_logic; --multiplexing clock(1 kHz)      
       reset : in std_logic; -- reset signal 
		 display_value : in std_logic_vector(15 downto 0); --BCD digits to be displayed
       seg : out std_logic_vector(6 downto 0); --7 cathodes
       anode : inout std_logic_vector(3 downto 0));--selection of the 4 7-segnment displays
end component;

-----------------------signals------------------------
------------------frequency_divider
signal clk_1kHz : std_logic; --1kHz clock signal
signal clk_1Hz : std_logic; --1Hz clock signal

------------------modulo60_counter
-- signal data_out_sig : std_logic_vector(7 downto 0);
signal display_value_sig : std_logic_vector(15 downto 0);
signal temp : std_logic_vector(15 downto 0);

begin
-- temp <= X"1234";

cop1 : FrequencyDivider1kHz
	Port map(RESET => reset, 
			clk => clk,
		   clk_1kHz => clk_1kHz);
			  
cop2 : FrequencyDivider1Hz
	Port map(RESET => reset, 
			clk => clk,
		   clk_1Hz => clk_1Hz);

cop3 : cop4_modulo60x60
  port map(clk => clk_1Hz,
           reset => reset,
		     ce => ce,
		     timeout => display_value_sig,
		     tc => tc);

cop4 : time_multiplexer_4digit
  port map(clk =>clk_1kHz ,      
           reset => reset, 
		     display_value => display_value_sig,
           seg => seg,
           anode => anode); 
end Behavioral;