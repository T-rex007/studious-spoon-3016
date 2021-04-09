library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM_Controller is
Port(clk : in STD_LOGIC;
		alarmSettingMode : in STD_LOGIC;
		minSettingMode : in STD_LOGIC;
		hrSettingMode : in STD_LOGIC;
		reset : in STD_LOGIC;
		hrSetEnable : out STD_LOGIC;
		minSetEnable : out STD_LOGIC;
		alarmSetEnable : out STD_LOGIC;
		resetStateEnable: out STD_LOGIC);
end FSM_Controller;

architecture Behavioral of FSM_Controller is
signal inputs : STD_LOGIC_VECTOR(2 DOWNTO 0);
type stateMealy_type is (hrSetState,minSetState,alarmSetState,resetState,currentTimeState ); -- 2 states are required for Mealy
signal stateMealy_reg : stateMealy_type;
signal stateMealy_next : stateMealy_type;

begin   
    SYNC_PROC : process(clk, reset)
    begin
        if (reset = '1') then -- go to state zero if reset
            stateMealy_reg <= resetState;
        elsif (clk'event and clk = '1') then -- otherwise update the states
            stateMealy_reg <= stateMealy_next;
        else
            null;
        end if; 
    end process;

    ENCODE_OUTPUT : process(stateMealy_reg, inputs,clk)
    begin 
		  inputs <= hrSettingMode  & minSettingMode & alarmSettingMode ;
        -- store current state as next
        stateMealy_next <= stateMealy_reg; --required: when no case statement is satisfied
		  
        case (stateMealy_reg) is 
            when minSetState =>  
                if inputs  = "000" then -- if level is 1, then go to state one,
                   stateMealy_next <= CurrentTimeState; -- otherwise remain in same state.
                   hrSetEnable <= '0';
                   minSetEnable <= '0';
                   alarmSetEnable <= '0';
                else 
                    stateMealy_next <= minSetState;
                    hrSetEnable <= '0';
                    minSetEnable <= '1';
                    alarmSetEnable <= '0';
               end if;
            when hrSetState =>
               if inputs  = "000" then -- if level is 1, then go to state one,
                   stateMealy_next <= CurrentTimeState; -- otherwise remain in same state.
                   hrSetEnable <= '0';
                   minSetEnable <= '0';
                   alarmSetEnable <= '0';
               else
                    stateMealy_next <= hrSetState;
                    hrSetEnable <= '1';
                    minSetEnable <= '0';
                    alarmSetEnable <= '0';
               end if;
            when alarmSetState => 
               if inputs  = "000" then -- if level is 1, then go to state one,
                   stateMealy_next <= CurrentTimeState; -- otherwise remain in same state.
                   hrSetEnable <= '0';
                   minSetEnable <= '0';
                   alarmSetEnable <= '0';
                else
                    stateMealy_next <= alarmSetState;
                    hrSetEnable <= '0';
                    minSetEnable <= '0';
                    alarmSetEnable <= '1';
               end if;
            when CurrentTimeState =>
               if inputs  = "000" then -- if level is 1, then go to state one,
                   stateMealy_next <= CurrentTimeState; -- otherwise remain in same state.
                   hrSetEnable <= '0';
                   minSetEnable <= '0';
                   alarmSetEnable <= '0';
               elsif(inputs = "100") then
                   stateMealy_next <= hrSetState;
                   hrSetEnable <= '1';
                   minSetEnable <= '0';
                   alarmSetEnable <= '0';
               elsif (inputs ="010") then 
                   stateMealy_next <= minSetState;
                   hrSetEnable <= '0';
                   minSetEnable <= '1';
                   alarmSetEnable <= '0';
               elsif (inputs ="001") then 
                   stateMealy_next <= alarmSetState;
                   hrSetEnable <= '0';
                   minSetEnable <= '0';
                   alarmSetEnable <= '1';
               end if; 
			when others =>
                stateMealy_next <= CurrentTimeState;
                hrSetEnable <= '0';
                minSetEnable <= '0';
                alarmSetEnable <= '0';
            end case;
    end process;
end Behavioral;