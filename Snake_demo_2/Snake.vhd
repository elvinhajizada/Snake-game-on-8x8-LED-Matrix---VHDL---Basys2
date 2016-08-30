----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:35:01 10/23/2015 
-- Design Name: 
-- Module Name:    Snake - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
USE work.SnakePackage.all;

entity Snake is
	 
    Port ( clock: in STD_LOGIC;
			  SNAKEX : OUT IntArray (0 to 15);
			  SNAKEY : OUT IntArray (0 to 15);
			  ResetButton : in std_logic ;
			  StartButton : in std_logic ;
			  RightButton : in std_logic ;
			  LeftButton : in std_logic ;
			  Apple : out std_logic_vector(5 downto 0);
			  Pause : in bit;
			  Score : out intArray (3 downto 0));
	 
end Snake;

architecture Behavioral of Snake is

	signal mycounter: STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
	SIGNAL mSNAKEX : IntArray (0 to 15) := (4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	SIGNAL mSNAKEY : IntArray (0 to 15) := (7,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
   Signal mDir : std_logic_vector (1 downto 0) := "11";
	Signal mDir0 : std_logic_vector (1 downto 0) := "01";
	Signal mDir1 : std_logic_vector (1 downto 0) := "01";
	signal random_num : std_logic_vector (5 downto 0);
	signal mApple : std_logic_vector (5 downto 0);
	signal AppleX : integer;
	signal AppleY : integer;
	signal mpause : bit := '0';
	signal start : bit := '0';
	signal mScore : intArray (3 downto 0) := (0,0,0,0);
	
	COMPONENT ClockDivider 
				port (clock : in std_logic;
						counter1: out std_logic_vector(2 downto 0));
		 end component;
	
	Component Random
				port (clock : in std_logic;
						random_num : out std_logic_vector (5 downto 0)   --output vector            
						);
	end component;
	
	BEGIN 	
		clockdivider0: clockDivider port map (clock, mycounter);
		generate_random : random port map (clock, random_num);
		
		SNAKEX <= mSNAKEX;
		SNAKEY <= mSNAKEY;
		Apple <= mApple;
		Appley <= (to_integer(unsigned(mApple)) / 8) + 1;
		Applex <= (to_integer(unsigned(mApple)) rem 8) + 1;
		mpause <= pause;
		score <= mScore;
		start <= '1' when StartButton = '1' else
					'0' when resetButton = '1';
		mdir <= mdir1 when LeftButton = '1' else
				  mdir0 when RightButton = '1' else
				  "11" when resetbutton = '1';
		
		move : process (mycounter, mSnakeY)
			Variable lastSnakeX : intArray (0 to 15);
			Variable lastSnakeY : intArray (0 to 15);
			variable temp : bit := '0';
			variable gameisover : bit := '0';
			variable random : std_logic_vector(5 downto 0) := "010110";
			variable x : integer ;
			variable y : integer ;
			begin
				mapple <= random;
				if resetbutton = '1' then
					mSnakeX <= (4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
					mSnakeY <= (7,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
					random := "010110";
					mScore <= (0,0,0,0);
					gameisover := '0';
					
				elsif mpause = '1' then 
						
				elsif rising_edge (mycounter(0)) then
					if gameisover = '1' then
						if temp = '0' then
							mSnakeY <= (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
							mSnakeX <= (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
						else 
							mSnakeY <= lastSnakeY;
							mSnakeX <= lastSnakeX;
						end if;
						temp := not temp;
						
					elsif start = '1' then
								x := mSnakeX(0);
								y := mSnakeY(0);
								if mDir = "11" then
									if y > 1 then
										y := y - 1;
									else
										y := 8;
									end if;
						
								elsif mDir = "01" then
									if y < 8 then
										y := y + 1;
									else
										y := 1;
									end if;
							
								elsif mDir = "10" then
									if x > 1 then
										x := x - 1;
									else
										x := 8;
									end if;
						
								elsif mDir = "00" then
									if x < 8 then
										x := x + 1;
									else
										x:= 1;
									end if;
								end if;
							
							if x = appleX and y=appleY then
								
								for n in 1 to 15 loop
									msnakeY(n) <= mSnakeY(n-1);
									msnakeX(n) <= mSnakeX(n-1);
								end loop;
								
								random := random_num;
								
								if mscore(0) = 9 then
									mscore(1) <= mscore(1) + 1;
									mscore(0) <= 0;
								else
									mscore(0) <= mscore(0) + 1;
								end if;
								
							else 
								for n in 1 to 15 loop
									if msnakeY (n) > 0 then
										msnakeY(n) <= mSnakeY(n-1);
										msnakeX(n) <= mSnakeX(n-1);
									else
										msnakeY(n) <= 0;
										msnakeX(n) <= 0;
									end if;
								end loop;
							end if;
							
							mSnakeX (0) <= x;
							mSnakeY (0) <= y;
			
					end if;
						
						
						for m in 4 to 15 loop
							if msnakeY(0) = msnakeY(m) and msnakeX(0) = mSnakeX (m) then
							gameisOver := '1';
							lastSnakeX := mSnakeX;
							lastSnakeY := mSnakeY;
							end if;
						end loop;	
				end if;						
			end process;
		

		StateOfButton0 : process ( RightButton )
			begin 
				if RightButton'event and RightButton = '1' then
					mDir0 <= mDir + 1;
				end if;
			end process;
				
		StateOfButton1 : process ( LeftButton )
			begin 
				if LeftButton'event and LeftButton = '1' then
					mDir1 <= mDir - 1;
				end if;
			end process;
				

end Behavioral;









