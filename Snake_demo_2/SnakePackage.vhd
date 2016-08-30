--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package SnakePackage is

		TYPE SnakeArray IS ARRAY (INTEGER range <>) OF STD_LOGIC_VECTOR (7 DOWNTO 0);
		TYPE IntArray IS ARRAY (INTEGER range <>) OF INTEGER RANGE 0 TO 15;
		
end SnakePackage;

package body SnakePackage is

end SnakePackage;
