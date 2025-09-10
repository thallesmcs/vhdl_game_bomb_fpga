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
    Port ( a, b : in  STD_LOGIC_VECTOR (15 downto 0);
           btn1 : in STD_LOGIC;
           reset : in STD_LOGIC;
		--    led : out STD_LOGIC;
           comp : out  STD_LOGIC);
end comparator;

architecture Behavioral of comparator is

signal final, comp_s : STD_LOGIC;
signal jogo : STD_LOGIC := '0';

begin

comp_s <= (not(a(0) xor b(0)) and not(a(1) xor b(1)) and not(a(2) xor b(2)) and not(a(3) xor b(3)) and not(a(4) xor b(4)) and not(a(5) xor b(5)) and not(a(6) xor b(6)) and not(a(7) xor b(7)) and not(a(8) xor b(8)) and not(a(9) xor b(9)) and not(a(10) xor b(10)) and not(a(11) xor b(11)) and not(a(12) xor b(12)) and not(a(13) xor b(13)) and not(a(14) xor b(14)) and not(a(15) xor b(15)));

process(btn1, reset)
begin
	if (reset = '1') then
		comp <= '0';
		jogo <= '0';
	elsif (btn1 = '1') then
		if (jogo = '0') then -- Só executa se ainda não confirmou o jogo
			comp <= comp_s;
			jogo <= '1';
		end if;
	end if;
end process;

-- led <= jogo;

end Behavioral;

