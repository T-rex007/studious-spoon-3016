--------------------------------------------------------------------------------
-- Company: Marcus's Technology Solutions LTD
-- Engineer: Marcus Lloyde George
--
-- Create Date:    02:48:43 04/29/09
-- Design Name:    
-- Module Name:    modulo60_counter - Behavioral
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
library UNISIM;
use UNISIM.VComponents.all;

entity TimeModule is
  Port(clk_1Hz : in std_logic;
       	clk_1kHz: std_logic;
			reset : in std_logic;
			increment : in std_logic;
			AlarmEnable : in std_logic;
			done : std_logic;
			ce : std_logic;
			hrSetEnable: in std_logic;
			minSetEnable: in std_logic;
			AlarmOn : out std_logic;
			timeout : out std_logic_vector(15 downto 0);
			AlarmTime : out std_logic_vector(15 downto 0);
			tc : out std_logic);
end TimeModule;

architecture Behavioral of TimeModule is
----------------------components----------------------

component AlarmSettingModule is
	Port(clk : in std_logic;
		reset : in std_logic;
		done : in std_logic;
		AlarmEnable : std_logic;
        increment : in std_logic;
		AlarmValue : out std_logic_vector(15 downto 0));
end component;

component hour24_timer is
  Port(clk : in std_logic;
       	reset : in std_logic;
			ce : in std_logic;
			increment : in std_logic;
			hrSetEnable: in std_logic;
			minSetEnable: in std_logic;
			timeout : out std_logic_vector(15 downto 0);
			tc : out std_logic);
end component;

component comparator_16bits 
  Port(A : in std_logic_vector(15 downto 0);
       B : in std_logic_vector(15 downto 0);
		 A_equal_B : out std_logic);
end component;
-----------------------signals------------------------

signal alarm_value_sig : std_logic_vector( 15 downto 0);
signal time_value_sig : std_logic_vector(15 downto 0);


begin

cop1_TM : AlarmSettingModule 
	Port map(clk =>clk_1kHz,
			reset => reset,
			done => done,
			AlarmEnable => AlarmEnable,
			increment => increment,
			AlarmValue => alarm_value_sig);

cop2_TM : hour24_timer
  Port map(clk => clk_1Hz,
       		reset  => reset,
			ce =>ce,
			increment => increment,
			hrSetEnable =>	hrSetEnable,
			minSetEnable => minSetEnable,
			timeout =>time_value_sig,
			tc =>tc);

cop3_TM  : comparator_16bits
	Port map(A =>alarm_value_sig,
			B => time_value_sig,
			A_equal_B => AlarmOn);

timeout <=  time_value_sig;
AlarmTime <= alarm_value_sig;
end Behavioral;