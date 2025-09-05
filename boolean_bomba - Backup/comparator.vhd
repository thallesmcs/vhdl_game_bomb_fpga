----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:27:03 06/16/2023 
-- Design Name: 
-- Module Name:    comparator - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comparator is
    Port ( a, b : in  STD_LOGIC_VECTOR (7 downto 0);
           btn1 : in STD_LOGIC;
			  comp : out  STD_LOGIC);
end comparator;

architecture Behavioral of comparator is

signal final, comp_s : STD_LOGIC;

begin


comp_s <= (not(a(0) xor b(0)) and not(a(1) xor b(1)) and not(a(2) xor b(2)) and not(a(3) xor b(3)) and not(a(4) xor b(4)) and not(a(5) xor b(5)) and not(a(6) xor b(6)) and not(a(7) xor b(7)));



process(btn1)
begin
	if (btn1 = '1') then
		comp <= comp_s;
	end if;
end process;


end Behavioral;

