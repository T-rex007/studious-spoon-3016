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

entity hour24_timer is
  Port(clk : in std_logic;
       reset : in std_logic;
		 ce : in std_logic;
         toggle : in std_logic;
         set_flag_params : in  STD_LOGIC_VECTOR(1 downto 0);
		 timeout : out std_logic_vector(15 downto 0);
		 tc : out std_logic);
end hour24_timer;

architecture Behavioral of hour24_timer is
----------------------components----------------------

component minute60_timer is
    Port( clk : in  STD_LOGIC;
            reset : in  STD_LOGIC;
            ce : in  STD_LOGIC;
			toggle : in  STD_LOGIC;
			set_flag_params : in  STD_LOGIC_VECTOR(1 downto 0);
			tc : out STD_LOGIC;
			timeout: out  STD_LOGIC_VECTOR (15 downto 0));
end component;

component modulo24_counter
    Port( clk : in  STD_LOGIC;
            reset : in  STD_LOGIC;
            ce : in  STD_LOGIC;
			toggle : in STD_LOGIC;
			set_flag_params : in  STD_LOGIC_VECTOR(1 downto 0);
			tc : out STD_LOGIC;
			timeout: out  STD_LOGIC_VECTOR (7 downto 0));
end component;

-----------------------signals------------------------

signal mod60_tc : std_logic;
signal mod24_tc : std_logic;
signal mod24_clk : std_logic;

signal minutes60_sig : std_logic_vector( 15 downto 0);

begin
tc <= mod60_tc and mod24_tc;

timeout(7 downto 0) <= minutes60_sig(15 downto 8);
cop1 : minute60_timer
    Port map( clk => clk,
            reset => reset,
            ce => ce,
			toggle => toggle,
			set_flag_params => set_flag_params,
			tc => mod60_tc,
			timeout => minutes60_sig);

cop2 : FDC	--from Unisim Library: uncomment lines 29 - 30
    port map(C => clk,
           CLR => reset, 
			  D => mod60_tc,
			  Q => mod24_clk);

cop3 : modulo24_counter
    Port map( clk => mod24_clk,
            reset => reset,
            ce => ce,
			toggle => toggle,
			set_flag_params => set_flag_params,
			tc => mod24_tc,
			timeout => timeout(15 downto 8));
end Behavioral;