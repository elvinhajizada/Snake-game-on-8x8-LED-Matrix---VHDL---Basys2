----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:51:14 10/24/2015 
-- Design Name: 
-- Module Name:    Display - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

entity Display is
    Port ( clock : in STD_LOGIC;
			  CATHODES : out STD_LOGIC_VECTOR(7 downto 0);
			  ANODES : out STD_LOGIC_VECTOR(7 downto 0);
			  SSDanodes  : out STD_LOGIC_VECTOR(3 downto 0);
			  SSDcathodes : out STD_LOGIC_VECTOR(6 downto 0);
			  ResetButton : in std_logic ;
			  StartButton : in std_logic ;
			  RightButton : in std_logic ;
			  LeftButton : in std_logic ;
			  Pause : in bit);
end Display;

architecture Behavioral of Display is

		 signal counter: STD_LOGIC_VECTOR(10 downto 0) := (others => '0');
		 signal counter2: STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
		 signal R_CATHODES : STD_LOGIC_VECTOR(7 downto 0);
		 signal R_ANODES : STD_LOGIC_VECTOR(7 downto 0);
       signal DISPLAY : STD_LOGIC_VECTOR (63 downto 0);
		 signal SNAKEX : IntArray (0 to 15) ;
		 signal SNAKEY : IntArray (0 to 15) ;
		 signal Apple : std_logic_vector(5 downto 0);
		 signal mScore : intArray (3 downto 0) := (0,0,0,0);

		 COMPONENT Snake 
				PORT (clock : in STD_LOGIC;
						SNAKEX : OUT IntArray (0 to 15);
						SNAKEY : OUT IntArray (0 to 15);
						ResetButton : in std_logic ;
						StartButton : in std_logic ;
						RightButton : in std_logic ;
						LeftButton : in std_logic; 
						Apple : out std_logic_vector(5 downto 0);
						Pause : in bit;
						Score : out intArray (3 downto 0)); 
		 END COMPONENT;
		 
		 COMPONENT SSD
				PORT (clock: in STD_LOGIC;
						anodes  : out STD_LOGIC_VECTOR(3 downto 0);
						cathodes : out STD_LOGIC_VECTOR(6 downto 0);
						Score : in intArray (3 downto 0)
						);
		 end component;
		 
		 COMPONENT ClockDivider 
				port (clock : in std_logic;
						counter0: out std_logic_vector(10 downto 0);
						counter2: out std_logic_vector(3 downto 0));
		 end component;
begin
	CATHODES <= R_CATHODES;
	ANODES <= R_ANODES;
	
	ShowScore : SSD port map (clock, SSDanodes, SSDcathodes, mscore);
	clockdivider1: clockDivider port map (clock, counter, counter2);
	displaySnake : snake port map (clock, SNAKEX, SNAKEY, ResetButton,StartButton, RightButton, LeftButton, Apple, Pause, mScore);
	matrix : process (SNAKEX, SNAKEY)
	begin			
		 for i in 0 to 63 loop 
				if i = 8 * SNAKEY(0) + SNAKEX(0) - 9 or i = 8 * SNAKEY(1) + SNAKEX(1) - 9 or i = 8 * SNAKEY(2) + SNAKEX(2) - 9 or i = 8 * SNAKEY(3) + SNAKEX(3) - 9 or i = 8 * SNAKEY(4) + SNAKEX(4) - 9 or i = 8 * SNAKEY(5) + SNAKEX(5) - 9 or i = 8 * SNAKEY(6) + SNAKEX(6) - 9 or i = 8 * SNAKEY(7) + SNAKEX(7) - 9  or i = to_integer(unsigned(apple)) or 
					i = 8 * SNAKEY(8) + SNAKEX(8) - 9 or i = 8 * SNAKEY(9) + SNAKEX(9) - 9 or i = 8 * SNAKEY(10) + SNAKEX(10) - 9 or i = 8 * SNAKEY(11) + SNAKEX(11) - 9 or i = 8 * SNAKEY(12) + SNAKEX(12) - 9 or i = 8 * SNAKEY(13) + SNAKEX(13) - 9 or i = 8 * SNAKEY(14) + SNAKEX(14) - 9	or i = 8 * SNAKEY(15) + SNAKEX(15) - 9 then
					DISPLAY(i) <= '1';
				else
					DISPLAy(i) <= '0';
				end if;
		 end loop;
	end process;
	 
	multiplex: process(counter)
    begin
        -- Set anode correctly
        case counter(2 downto 0) is
            when "000" => R_CATHODES <= "11111110"; -- CATHODE 0
            when "001" => R_CATHODES <= "11111101"; -- CATHODE 1
            when "010" => R_CATHODES <= "11111011"; -- CATHODE 2
            when "011" => R_CATHODES <= "11110111"; -- CATHODE 3
				when "100" => R_CATHODES <= "11101111"; -- CATHODE 4
				when "101" => R_CATHODES <= "11011111"; -- CATHODE 5
				when "110" => R_CATHODES <= "10111111"; -- CATHODE 6
				when "111" => R_CATHODES <= "01111111"; -- CATHODE 7

            when others => R_CATHODES <= "11111111"; -- nothing
        end case;
		  
		  CASE R_CATHODES IS 
				WHEN "11111110" => 
						case counter2(2 downto 0) is
						when "000" => R_ANODES <= "0000000" & Display(0);
						when "001" => R_ANODES <= "000000" & Display(1) & '0';
						when "010" => R_ANODES <= "00000" & Display(2) & "00";
						when "011" => R_ANODES <= "0000" & Display(3) & "000";
						when "100" => R_ANODES <= "000" & Display(4) & "0000";
						when "101" => R_ANODES <= "00" & Display(5) & "00000";
						when "110" => R_ANODES <= '0' & Display(6) & "000000";
						when "111" => R_ANODES <= Display(7) & "0000000";
						when others => R_ANODES <= "00000000" ;
						end case;
				WHEN "11111101" => 
						case counter2(2 downto 0) is
						when "000" => R_ANODES <= "0000000" & Display(8);
						when "001" => R_ANODES <= "000000" & Display(9) & '0';
						when "010" => R_ANODES <= "00000" & Display(10) & "00";
						when "011" => R_ANODES <= "0000" & Display(11) & "000";
						when "100" => R_ANODES <= "000" & Display(12) & "0000";
						when "101" => R_ANODES <= "00" & Display(13) & "00000";
						when "110" => R_ANODES <= '0' & Display(14) & "000000";
						when "111" => R_ANODES <= Display(15) & "0000000";
						when others => R_ANODES <= "00000000" ;
						end case;
				WHEN "11111011" => 
						case counter2(2 downto 0) is
						when "000" => R_ANODES <= "0000000" & Display(16);
						when "001" => R_ANODES <= "000000" & Display(17) & '0';
						when "010" => R_ANODES <= "00000" & Display(18) & "00";
						when "011" => R_ANODES <= "0000" & Display(19) & "000";
						when "100" => R_ANODES <= "000" & Display(20) & "0000";
						when "101" => R_ANODES <= "00" & Display(21) & "00000";
						when "110" => R_ANODES <= '0' & Display(22) & "000000";
						when "111" => R_ANODES <= Display(23) & "0000000";
						when others => R_ANODES <= "00000000" ;
						end case;
				WHEN "11110111" => 
						case counter2(2 downto 0) is
						when "000" => R_ANODES <= "0000000" & Display(24);
						when "001" => R_ANODES <= "000000" & Display(25) & '0';
						when "010" => R_ANODES <= "00000" & Display(26) & "00";
						when "011" => R_ANODES <= "0000" & Display(27) & "000";
						when "100" => R_ANODES <= "000" & Display(28) & "0000";
						when "101" => R_ANODES <= "00" & Display(29) & "00000";
						when "110" => R_ANODES <= '0' & Display(30) & "000000";
						when "111" => R_ANODES <= Display(31) & "0000000";
						when others => R_ANODES <= "00000000" ;
						end case;
				WHEN "11101111" => 
						case counter2(2 downto 0) is
						when "000" => R_ANODES <= "0000000" & Display(32);
						when "001" => R_ANODES <= "000000" & Display(33) & '0';
						when "010" => R_ANODES <= "00000" & Display(34) & "00";
						when "011" => R_ANODES <= "0000" & Display(35) & "000";
						when "100" => R_ANODES <= "000" & Display(36) & "0000";
						when "101" => R_ANODES <= "00" & Display(37) & "00000";
						when "110" => R_ANODES <= '0' & Display(38) & "000000";
						when "111" => R_ANODES <= Display(39) & "0000000";
						when others => R_ANODES <= "00000000" ;
						end case;
				WHEN "11011111" => 
						case counter2(2 downto 0) is
						when "000" => R_ANODES <= "0000000" & Display(40);
						when "001" => R_ANODES <= "000000" & Display(41) & '0';
						when "010" => R_ANODES <= "00000" & Display(42) & "00";
						when "011" => R_ANODES <= "0000" & Display(43) & "000";
						when "100" => R_ANODES <= "000" & Display(44) & "0000";
						when "101" => R_ANODES <= "00" & Display(45) & "00000";
						when "110" => R_ANODES <= '0' & Display(46) & "000000";
						when "111" => R_ANODES <= Display(47) & "0000000";
						when others => R_ANODES <= "00000000" ;
						end case;
				WHEN "10111111" => 
						case counter2(2 downto 0) is
						when "000" => R_ANODES <= "0000000" & Display(48);
						when "001" => R_ANODES <= "000000" & Display(49) & '0';
						when "010" => R_ANODES <= "00000" & Display(50) & "00";
						when "011" => R_ANODES <= "0000" & Display(51) & "000";
						when "100" => R_ANODES <= "000" & Display(52) & "0000";
						when "101" => R_ANODES <= "00" & Display(53) & "00000";
						when "110" => R_ANODES <= '0' & Display(54) & "000000";
						when "111" => R_ANODES <= Display(55) & "0000000";
						when others => R_ANODES <= "00000000" ;
						end case;
				WHEN "01111111" => 
						case counter2(2 downto 0) is
						when "000" => R_ANODES <= "0000000" & Display(56);
						when "001" => R_ANODES <= "000000" & Display(57) & '0';
						when "010" => R_ANODES <= "00000" & Display(58) & "00";
						when "011" => R_ANODES <= "0000" & Display(59) & "000";
						when "100" => R_ANODES <= "000" & Display(60) & "0000";
						when "101" => R_ANODES <= "00" & Display(61) & "00000";
						when "110" => R_ANODES <= '0' & Display(62) & "000000";
						when "111" => R_ANODES <= Display(63) & "0000000";
						when others => R_ANODES <= "00000000" ;
						end case;
				WHEN OTHERS => R_ANODES <= "00000000" ;
			END CASE;
		end process;		
end Behavioral;

