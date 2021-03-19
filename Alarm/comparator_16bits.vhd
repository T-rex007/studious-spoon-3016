--------------------------------------------------------------------------------
-- Company: Marcus's Technology Solutions LTD
-- Engineer: Marcus Lloyde George
--
-- Create Date:    00:50:35 07/12/09
-- Design Name:    
-- Module Name:    comparator_3bits - Behavioral
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

entity comparator_16bits is
  Port(A : in std_logic_vector(15 downto 0);
       B : in std_logic_vector(15 downto 0);
		 A_equal_B : out std_logic);
end comparator_3bits;

architecture Behavioral of comparator_16bits is
begin
  A_equal_B <= '1' when (A = B) else '0';	--A equal to B
end Behavioral;
