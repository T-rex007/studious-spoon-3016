----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:17:08 01/22/2021 
-- Design Name: 
-- Module Name:    cop4-modulo60x60 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity modulo24_counter_alarm is
    Port (reset : in  STD_LOGIC;
            ce : in  STD_LOGIC;
			increment : in  STD_LOGIC;
			tc : out STD_LOGIC;
			dout: out  STD_LOGIC_VECTOR (7 downto 0));
end modulo24_counter_alarm;

architecture Behavioral of modulo24_counter_alarm is
----------- Component---------

component modulo10_counter_MOD24_alarm
  Port(clk : in std_logic;
        reset : in std_logic;
		swreset : in std_logic;
		ce : in std_logic;
		dataout : out std_logic_vector(3 downto 0);
		tc : out std_logic);
end component;


component modulo3_counter_alarm
  Port(clk : in std_logic;
       	reset : in std_logic;
		swreset : in std_logic;
		ce : in std_logic;
		dataout : out std_logic_vector( 3 downto 0);
		tc : out std_logic);
end component;


--------------- Signals --------------------------------
signal mod10_1_tc : std_logic;
signal mod3_2_tc : std_logic;
signal mod3_2_clk : std_logic;
signal swreset_sig: std_logic;
signal osig : std_logic_vector(7 downto 0);
signal temp : std_logic;
signal clk_sig : std_logic;

begin
tc <= mod3_2_tc and mod10_1_tc;
--reset Modulo 24 counter the instant it reaches 24 with software Reset sreset
temp <=  (not osig(7)) and (not osig(6)) and osig(5) and (not osig(4));
swreset_sig <=  temp and  (not osig(3))  and osig(2) and not (osig(1)) and (not osig(0));

dout  <= osig;

cop1 : modulo10_counter_MOD24_alarm
  port map(clk => increment,
		reset => reset,
		swreset => swreset_sig,
		ce => ce,
		dataout => osig(3 downto 0),
		tc => mod10_1_tc);

cop2 : FDC	--from Unisim Library: uncomment lines 29 - 30
  port map(C =>increment,
		CLR => reset, 
		D => mod10_1_tc,
		Q => mod3_2_clk);

cop3 : modulo3_counter_alarm
  port map(clk => mod3_2_clk,
		reset => reset,
		swreset => swreset_sig,
		ce => ce,
		dataout => osig(7 downto 4),
		tc => mod3_2_tc);

end Behavioral;