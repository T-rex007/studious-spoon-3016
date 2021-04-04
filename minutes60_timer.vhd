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

entity minute60_timer is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           	ce : in  STD_LOGIC;
		   	minSetEnable: in std_logic;
			  toggle : in STD_LOGIC;
			  tc : out STD_LOGIC;
			  timeout: out  STD_LOGIC_VECTOR (15 downto 0));
end minute60_timer;

architecture Behavioral of minute60_timer is
----------- Component---------


component modulo60_counter
  Port(clk : in std_logic;
       reset : in std_logic;
		 ce : in std_logic;
		 dataout : out std_logic_vector(7 downto 0);
		tc : out std_logic);
end component;

component multiplexer_2to1_min is
  Port(A : in std_logic;
        B : in std_logic;
		sel : in std_logic;
		O : out std_logic);
end component;

signal mod60_1_tc : std_logic;
signal mod60_2_tc : std_logic;
signal mod60_2_clk : std_logic;
signal clk_sig : std_logic;
signal temp : STD_LOGIC_VECTOR (15 downto 0);
signal swreset_sig: std_logic;

begin

tc <= mod60_2_tc and mod60_1_tc;

cop1_secs : modulo60_counter
port map(clk => clk,
		reset => reset,
		ce => ce,
		dataout => timeout(7 downto 0),
		tc => mod60_1_tc);

cop2 : FDC	--from Unisim Library: uncomment lines 29 - 30
  port map(C => clk,
           CLR => reset, 
			  D => mod60_1_tc,
			  Q => mod60_2_clk);

cop3_min : modulo60_counter
port map(clk => clk_sig,
		reset => reset,
		ce => ce,
		dataout => timeout(15 downto 8),
		tc => mod60_2_tc);

cop4 : multiplexer_2to1_min 
  	port map(A => mod60_2_clk, 
        B => toggle, 
		sel => minSetEnable,
		O => clk_sig);
end Behavioral;

