----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:19:53 06/13/2023 
-- Design Name: 
-- Module Name:    rand_gen - Behavioral 
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

entity rand_gen is
    Port ( clock, clock_2, btn3 : in  STD_LOGIC;
           q_n, q : out  STD_LOGIC_VECTOR (7 downto 0));
end rand_gen;

architecture Behavioral of rand_gen is

signal reset_dec : STD_LOGIC;
signal reset_un : STD_LOGIC;
signal q_ns, qs : STD_LOGIC_VECTOR(7 downto 0);
signal switch1, btn_s : STD_LOGIC;
signal verify1 : STD_LOGIC := '1';

component ffjk4 is
    Port (clock, reset : in  STD_LOGIC;
           verify : in  STD_LOGIC;
           q, q_n : out  STD_LOGIC_VECTOR (3 downto 0));
end component;




begin


process(btn3)
begin
	if (btn3 = '1') then
		verify1 <= '0';
	end if;
end process;


	decimal : component ffjk4
	port map(
		clock => clock_2,
		reset => reset_dec,
		q_n => q_ns(7 downto 4),
		verify => verify1,
		q => qs(7 downto 4));
		

	unidade : component ffjk4
	port map(
		clock => clock,
		reset => reset_un,
		q_n => q_ns(3 downto 0),
		verify => verify1,
		q => qs(3 downto 0));
		

q_n <= q_ns;
q <= qs;
reset_un <= switch1 or (qs(3) and qs(1));
reset_dec <= switch1 or (qs(7) and qs(5));





end Behavioral;

