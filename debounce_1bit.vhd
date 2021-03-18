library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debounce_1bit is
Port(clock: in STD_LOGIC;
     RESET: in STD_LOGIC;
     D_IN: in STD_LOGIC;   
     Q_OUT: out STD_LOGIC);
end debounce_1bit;

architecture Behavioral of debounce_1bit is
signal Q1, Q2, Q3 : std_logic;
begin
  process(clock, RESET)
    begin
      if(RESET = '1') then
        Q1 <= '0';
        Q2 <= '0';
        Q3 <= '0';
      elsif (clock'event and clock = '1') then
        Q1 <= D_IN;
        Q2 <= Q1;
        Q3 <= Q2;
      end if;
  end process;

Q_OUT <= Q1 and Q2 and (not Q3);
end Behavioral;