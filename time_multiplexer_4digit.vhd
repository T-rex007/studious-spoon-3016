--------------------------------------------------------------------------------
-- Company: Marcus's Technology Solutions LTD
-- Engineer: Marcus Lloyde George
--
-- Create Date:    02:23:20 04/29/09
-- Design Name:    
-- Module Name:    time_multiplexer_4digit - Behavioral
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

entity time_multiplexer_4digit is
  Port(clk : in std_logic; --multiplexing clock(1 kHz)      
       reset : in std_logic; -- reset signal 
		 display_value : in std_logic_vector(15 downto 0); --BCD digits to be displayed
       seg : out std_logic_vector(6 downto 0); --7 cathodes
       anode : inout std_logic_vector(3 downto 0));--selection of the 4 7-segnment displays
end time_multiplexer_4digit;

architecture Behavioral of time_multiplexer_4digit is
begin
   SelectLED: process(clk,reset)   -- selection of the 7-seg_alr: Multiplexing in time
	   begin
		   if reset = '1' then 
			   anode <= "1110";
		   elsif clk 'event and clk  = '1' then
		      anode <= (anode(0) & anode(3 downto 1));
		   end if; 
	end process;

   display: process(clk,reset)
   variable dispLED: std_logic_vector(3 downto 0);
	   begin
	      case anode is
		      when "1110" => dispLED := display_value(3 downto 0);
		      when "1101" => dispLED := display_value(7 downto 4);
		      when "1011" => dispLED := display_value(11 downto 8);
		      when "0111" => dispLED := display_value(15 downto 12);
		      when others => dispLED := "0000";
		   end case;

		   case  dispLED is		  
	         when "0000"=>
		         seg <= "1000000";	--key 0
		      when "0001"=>
		   	   seg <= "1111001";	--key 1
		      when "0010"=>
		   	   seg <= "0100100";	--key 2
		      when "0011"=>
		   	   seg <= "0110000";	--key 3
		      when "0100"=>
		   	   seg <= "0011001";	--key 4
		      when "0101"=>
		   	   seg <= "0010010"; --key 5
		      when "0110"=>
			      seg <= "0000010";	--key 6
		      when "0111"=>
			      seg <= "1111000";	--key 7
		      when "1000"=>
			      seg <= "0000000";	--key 8
		      when "1001"=>
			      seg <= "0010000";	--key 9
		      when "1010"=>
			      seg <= "0001001";	--key * (H)
		      when "1011"=>
			      seg <= "1001001";	--key # (||)
		      when "1100"=>
			      seg <= "0001000";	--key A
		      when "1101"=>
			      seg <= "0000000";	--key B
		      when "1110"=>
			      seg <= "1000110";	--key C
		      when "1111"=>
			      seg <= "1111111";	--Blank
		      when others =>
        		   seg <= "0000110";
	      end case;
	   end process;
end Behavioral;