----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:14:34 12/12/2015 
-- Design Name: 
-- Module Name:    SSD - Behavioral 
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
USE work.SnakePackage.all;

entity SSD is
		PORT (clock: in STD_LOGIC;
				anodes  : out STD_LOGIC_VECTOR(3 downto 0);
			   cathodes : out STD_LOGIC_VECTOR(6 downto 0);
				Score : in intArray (3 downto 0)
			   );
			
	TYPE mArray is ARRAY (9 downto 0) of std_logic_vector (6 downto 0);
end SSD;

architecture Behavioral of SSD is

		signal r_anodes: STD_LOGIC_VECTOR(3 downto 0); 
		signal r_cathodes : std_logic_vector (6 downto 0);
		signal ssdConfig : mArray ; 
		signal Digits :  intArray (3 downto 0) := (0,0,0,0);
		signal counter : std_logic_vector(10 downto 0) := (others => '0');
			
		COMPONENT ClockDivider 
				port (clock: in STD_LOGIC;
						counter0 : out std_logic_vector(10 downto 0));
		 end component;
		 

begin
		clockdivider2 : clockdivider port map (clock, counter);
		
		anodes <= r_anodes;
		cathodes <= r_cathodes;
		digits <= score;
		
		ssdConfig <= ("0010000", "0000000", "1111000", "0000010", "0010010", "0011001","0110000", "0100100", "1111001", "1000000");
		 multiplex: process(counter)
    begin
        -- Set anode correctly
        case counter(1 downto 0) is
            when "00" => r_anodes <= "1110"; -- AN 0
            when "01" => r_anodes <= "1101"; -- AN 1
            when "10" => r_anodes <= "1011"; -- AN 2
            when "11" => r_anodes <= "0111"; -- AN 3

            when others => r_anodes <= "1111"; -- nothing
        end case;

        case r_anodes is
            when "1110" => r_cathodes <= ssdConfig(digits(0));

            when "1101" => r_cathodes <= ssdConfig(digits(1));
				
            when "1011" => r_cathodes <= ssdConfig(digits(2));
	
            when "0111" => r_cathodes <= ssdConfig(digits(3));

            when others => r_cathodes <= "1111111"; -- nothing
        end case;
		end process;

end Behavioral;

