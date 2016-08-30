----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:09:40 11/12/2015 
-- Design Name: 
-- Module Name:    ClockDivider - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClockDivider is
    Port ( clock : in  STD_LOGIC;
           counter0 : out  STD_LOGIC_vector(10 downto 0);
			  counter2 : out std_logic_vector(3 downto 0);
			  counter1 : out std_logic_vector(2 downto 0));
end ClockDivider;

architecture Behavioral of ClockDivider is
		 signal prescaler: STD_LOGIC_VECTOR(11 downto 0) := "110000110101";
       signal prescaler_counter: STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
		 signal mcounter0: STD_LOGIC_VECTOR(10 downto 0) := (others => '0');
		 signal mcounter1: STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
		 signal mcounter2: STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
  	 
begin
	counter0 <= mcounter0;
	counter1 <= mcounter1;
	counter2 <= mcounter2;
	
	countClock: process(clock, mcounter0, mcounter1, mcounter2)
    begin
        if rising_edge(clock) then
            prescaler_counter <= prescaler_counter + 1;
            if(prescaler_counter = prescaler) then
                -- Iterate
                mcounter2 <= mcounter2 + 1;
					 if mcounter2 = "1000" then
							mcounter0 <= mcounter0 + 1; 							
						 if (mcounter0 = "111110100") then
								mcounter1 <= mcounter1 + 1;
								mcounter0<= (others => '0');
						 end if;
					 mcounter2 <= (others => '0');
					 end if;
                prescaler_counter <= (others => '0');
            end if;
        end if;
    end process;

end Behavioral;

