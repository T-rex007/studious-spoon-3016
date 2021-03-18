----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:19:58 03/25/2019 
-- Design Name: 
-- Module Name:    Shift_Register_With_24x1_bits - Behavioral 
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

entity Register_With_16x16_bits_alarm is
    Port(D : in  STD_LOGIC_VECTOR(15 downto 0);
           clk : in  STD_LOGIC;
           load : in  STD_LOGIC;
           clr : in  STD_LOGIC;
           outputs : out  STD_LOGIC_VECTOR (15 downto 0));
end Register_With_16x16_bits_alarm;

architecture Behavioral of Register_With_16x16_bits_alarm is
signal reg : STD_LOGIC_VECTOR(15 downto 0) := X'00';
begin
	process(clk, clr, load)
	begin
		if(clr='1') then
			reg <= (others => '0');
		else
			if(clk'event and clk = '1' and load = '1') then
				reg <= D;
			end if;
		end if;
	end process;
	outputs <= reg;
end Behavioral;