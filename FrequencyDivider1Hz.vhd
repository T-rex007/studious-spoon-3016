----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:23:05 01/19/2021 
-- Design Name: 
-- Module Name:    FrequencyDivider1Hz - Behavioral 
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
--library UNISIM;
--use UNISIM.VComponents.all;

entity FrequencyDivider1Hz is
	Port (RESET : in STD_LOGIC; 
			clk : in  STD_LOGIC;
		   clk_1Hz : out  STD_LOGIC);
end FrequencyDivider1Hz;

architecture Behavioral of FrequencyDivider1Hz is

signal temp: std_logic := '0';
constant divider: integer := 50000000;
signal count: integer range 1 to divider := 1;

begin
	process(clk, RESET, temp)
	begin
		if(RESET = '1') then
			count <= 1;
			temp <= '0';
		elsif(clk' event and clk = '1') then
			count <= count + 1;
			if(count = divider) then
				temp <= NOT temp;
				count <= 1;
			end if;
		end if;
		clk_1Hz <= temp;
	end process;	

end Behavioral;

