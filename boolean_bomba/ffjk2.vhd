----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:15:04 05/28/2023 
-- Design Name: 
-- Module Name:    ffjk - Behavioral 
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

entity ffjk2 is
    Port ( j, k : in  STD_LOGIC;
           reset, clock : in  STD_LOGIC;
           q, q_n : out  STD_LOGIC);
end ffjk2;

architecture Behavioral of ffjk2 is

signal s1, s2 : STD_LOGIC;
signal t : STD_LOGIC_VECTOR(1 downto 0);

begin

t <= j & k;

process(clock, reset) is
begin
	
	if (reset = '1') then
		s1 <= '0';

	elsif (rising_edge(clock)) then
		case(t) is
        when "10" => s1 <= '1';
        when "01" => s1 <= '0';
        when "00" => s1 <= s2;
        when "11" => s1 <= not s2;
		when others => null;
		end case;
	end if;
end process;

q <= s1;
q_n <= not s1;
s2 <= s1;
		

end Behavioral;

