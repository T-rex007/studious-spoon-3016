--------------------------------------------------------------------------------
-- Company: Marcus's Technology Solutions LTD
-- Engineer: Marcus Lloyde George
--
-- Create Date:    02:48:43 04/29/09
-- Design Name:    
-- Module Name:    modulo60_counter - Behavioral
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
library UNISIM;
use UNISIM.VComponents.all;

entity modulo60_counter is
  Port(clk : in std_logic;
       reset : in std_logic;
		 ce : in std_logic;
		 dataout : out std_logic_vector(7 downto 0);
		 tc : out std_logic);
end modulo60_counter;

architecture Behavioral of modulo60_counter is
----------------------components----------------------

component modulo10_counter
  Port(clk : in std_logic;
       reset : in std_logic;
		 ce : in std_logic;
		 dataout : out std_logic_vector(3 downto 0);
		 tc : out std_logic);
end component;

component modulo6_counter
  Port(clk : in std_logic;
       reset : in std_logic;
		 ce : in std_logic;
		 dataout : out std_logic_vector(3 downto 0);
		 tc : out std_logic);
end component;

-----------------------signals------------------------

signal mod10_tc : std_logic;
signal mod6_tc : std_logic;
signal mod6_clk : std_logic;

begin
tc <= mod6_tc and mod10_tc;

cop1 : modulo10_counter
  port map(clk => clk,
           reset => reset,
		     ce => ce,
		     dataout => dataout(3 downto 0),
		     tc => mod10_tc);

cop2 : FDC	--from Unisim Library: uncomment lines 29 - 30
  port map(C => clk,
           CLR => reset, 
			  D => mod10_tc,
			  Q => mod6_clk);

cop3 : modulo6_counter
  port map(clk => mod6_clk,
           reset => reset,
		     ce => ce,
		     dataout => dataout(7 downto 4),
		     tc => mod6_tc);
end Behavioral;