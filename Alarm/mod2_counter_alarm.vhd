--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:    02:32:02 04/29/09
-- Design Name:    
-- Module Name:    modulo6_counter - Behavioral
-- Project Name:   
-- Target Device:  
-- Tool versions:  
-- Description:
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity modulo2_counter_alarm is
  Port(clk : in std_logic;
        reset : in std_logic;
		dataout : out std_logic);
end modulo2_counter_alarm;

architecture Behavioral of modulo2_counter_alarm is
signal cnt : std_logic;

begin
  process(clk,reset,cnt)
    begin
	   if(reset = '1')then
		  cnt <= '0';
      elsif(clk'event and clk = '1') then
		    if(cnt = '1')then
		      cnt <= '0';
		    else
			   cnt <= '1';
		    end if;
	   end if;
  end process;

dataout <= cnt;
end Behavioral;