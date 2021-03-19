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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity modulo3_counter_alarm is
  Port(clk : in std_logic;
       reset : in std_logic;
		 ce : in std_logic;
		 swreset : in std_logic;
		 dataout : out std_logic_vector(3 downto 0);
		 tc : out std_logic);
end modulo3_counter_alarm;

architecture Behavioral of modulo3_counter_alarm is
signal cnt : std_logic_vector(3 downto 0);

begin
  process(clk,reset,ce,cnt)
    begin
	   if(reset = '1' or swreset = '1')then
		  cnt <= "0000";
      elsif(clk'event and clk = '1') then
        if(ce = '1')then
		    if(cnt = "0100")then
		      cnt <= "0000";
		    else
			   cnt <= cnt + 1;
		    end if;
		  end if;
	   end if;
    end process;

dataout <= cnt;
tc <= (not cnt(3)) and  cnt(2) and  (not cnt(1)) and  (not cnt(0)); 
end Behavioral;