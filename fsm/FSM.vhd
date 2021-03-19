library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM_Controller is
Port(inputs : in STD_LOGIC_VECTOR(3 downto 0);
    reset : in STD_LOGIC;
    clk : in STD_LOGIC;
    hrSetEnable : out STD_LOGIC;
    minSetEnable : out STD_LOGIC;
    alarmSetEnable : out STD_LOGIC;
    resetStateEnable: out STD_LOGIC);
end FSM_Controller;



architecture Behavioral of FSM_Controller is


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

    ENCODE_OUTPUT : process(stateMealy_reg, inputs)
    begin 
        -- store current state as next
        stateMealy_next <= stateMealy_reg; --required: when no case statement is satisfied
        case (stateMealy_reg) is 
            when resetState =>  -- set 'tick = 1' if state = zero and level = '1'
                if(inputs  = "0000") then -- if level is 1, then go to state one,
                    stateMealy_next <= CurrentTimeState; -- otherwise remain in same state.
                    hrSetEnable <= '0';
                    minSetEnable <= '0';
                    alarmSetEnable <= '0';
                    resetStateEnable <= '0';
                elsif(inputs = "1000") then
                    stateMealy_next <= hrSetState;
                    hrSetEnable <= '0';
                    minSetEnable <= '0';
                    alarmSetEnable <= '0';
                    resetStateEnable <= '0';
                elsif (inputs ="0100") then 
                    stateMealy_next <= minSetState;
                    hrSetEnable <= '0';
                    minSetEnable <= '0';
                    alarmSetEnable <= '0';
                    resetStateEnable <= '0';
                elsif (inputs ="0010") then 
                    stateMealy_next <= alarmSetState;
                    hrSetEnable <= '0';
                    minSetEnable <= '0';
                    alarmSetEnable <= '0';
                    resetStateEnable <= '0';
                elsif (inputs ="0001") then 
                    stateMealy_next <= resetState;
                    hrSetEnable <= '0';
                    minSetEnable <= '0';
                    alarmSetEnable <= '0';
                    resetStateEnable <= '0';
                end if; 
            when minSetState =>  
               if inputs  = "0000" then -- if level is 1, then go to state one,
                   stateMealy_next <= CurrentTimeState; -- otherwise remain in same state.
                   hrSetEnable <= '0';
                   minSetEnable <= '0';
                   alarmSetEnable <= '0';
                   resetStateEnable <= '0';
               elsif (inputs ="0001") then 
                   stateMealy_next <= resetState;
                   hrSetEnable <= '0';
                   minSetEnable <= '0';
                   alarmSetEnable <= '0';
                   resetStateEnable <= '0';
               end if;
            when hrSetState =>
               if inputs  = "0000" then -- if level is 1, then go to state one,
                   stateMealy_next <= CurrentTimeState; -- otherwise remain in same state.
                   hrSetEnable <= '0';
                   minSetEnable <= '0';
                   alarmSetEnable <= '0';
                   resetStateEnable <= '0';
               elsif (inputs ="0001") then 
                   stateMealy_next <= resetState;
                   hrSetEnable <= '0';
                   minSetEnable <= '0';
                   alarmSetEnable <= '0';
                   resetStateEnable <= '0';
               end if;
            when alarmSetState => 
               if inputs  = "0000" then -- if level is 1, then go to state one,
                   stateMealy_next <= CurrentTimeState; -- otherwise remain in same state.
                   hrSetEnable <= '0';
                   minSetEnable <= '0';
                   alarmSetEnable <= '0';
                   resetStateEnable <= '0';
               elsif (inputs ="0001") then 
                   stateMealy_next <= resetState;
                   hrSetEnable <= '0';
                   minSetEnable <= '0';
                   alarmSetEnable <= '0';
                   resetStateEnable <= '0';
               end if;
            when CurrentTimeState =>
               if inputs  = "0000" then -- if level is 1, then go to state one,
                   stateMealy_next <= CurrentTimeState; -- otherwise remain in same state.
                   hrSetEnable <= '0';
                   minSetEnable <= '0';
                   alarmSetEnable <= '0';
                   resetStateEnable <= '0';
               elsif(inputs = "1000") then
                   stateMealy_next <= hrSetState;
                   hrSetEnable <= '0';
                   minSetEnable <= '0';
                   alarmSetEnable <= '0';
						 resetStateEnable <= '0';
               elsif (inputs ="0100") then 
                   stateMealy_next <= minSetState;
                   hrSetEnable <= '0';
                   minSetEnable <= '0';
                   alarmSetEnable <= '0';
                   resetStateEnable <= '0';
               elsif (inputs ="0010") then 
                   stateMealy_next <= alarmSetState;
                   hrSetEnable <= '0';
                   minSetEnable <= '0';
                   alarmSetEnable <= '0';
                   resetStateEnable <= '0';
               elsif (inputs ="0001") then 
                   stateMealy_next <= resetState;
                   hrSetEnable <= '0';
                   minSetEnable <= '0';
                   alarmSetEnable <= '0';
                   resetStateEnable <= '0';
               end if; 
			when others =>
                stateMealy_next <= resetState;
                hrSetEnable <= '0';
                minSetEnable <= '0';
                alarmSetEnable <= '0';
                resetStateEnable <= '0';

            end case;
    end process;
end Behavioral;