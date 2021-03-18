--------------------------------------------------------------------------------
-- Company: Marcus's Technology Solutions LTD
-- Engineer: Marcus Lloyde George
--
-- Create Date:    02:32:26 04/29/09
-- Design Name:    
-- Module Name:    modulo10_counter - Behavioral
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

entity modulo10_counter_MOD24_alarm is
  Port(clk : in std_logic;
       reset : in std_logic;
		 swreset : in std_logic;
		 ce : in std_logic;
		 dataout : out std_logic_vector(3 downto 0);
		 tc : out std_logic);
end modulo10_counter_MOD24_alarm;

architecture Behavioral of modulo10_counter_MOD24_alarm is
signal cnt : std_logic_vector(3 downto 0);

begin
  process(clk,reset,ce,cnt,swreset)
    begin
	   if(reset = '1'or swreset = '1' )then
		  cnt <= "0000";
      elsif(clk'event and clk = '1') then
        if(ce = '1')then
		    if(cnt = "1001")then
		      cnt <= "0000";
		    else
			   cnt <= cnt + 1;
		    end if;
		  end if;
	   end if;
    end process;

dataout <= cnt;

tc <= cnt(3) and (not cnt(2)) and (not cnt(1)) and cnt(0);
end Behavioral;