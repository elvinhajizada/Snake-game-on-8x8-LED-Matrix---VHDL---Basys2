

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity random is
port (
      clock : in std_logic;
      random_num : out std_logic_vector (5 downto 0)   --output vector            
    );
end random;

architecture Behavioral of random is
	
	begin
		process(clock)
			variable rand_temp : std_logic_vector(5 downto 0):= "100000";
			variable temp : std_logic := '0';
			begin
				if rising_edge(clock)  then
					rand_temp := rand_temp + 1;
				end if;
				
				random_num <= rand_temp;
	end process;
end behavioral;