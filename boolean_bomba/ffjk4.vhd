----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:32:56 05/28/2023 
-- Design Name: 
-- Module Name:    ffjk4 - Behavioral 
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

entity ffjk4 is
    Port (clock, reset : in  STD_LOGIC;
           verify : in  STD_LOGIC;
           q, q_n : out  STD_LOGIC_VECTOR (3 downto 0));
end ffjk4;

architecture Behavioral of ffjk4 is

signal ab, abc, junta1, junta2, junta3 : STD_LOGIC;
signal qs, q_ns : STD_LOGIC_VECTOR(3 downto 0) ;



component ffjk2 is
    Port ( j, k : in  STD_LOGIC;
           reset, clock : in  STD_LOGIC;
           q, q_n : out  STD_LOGIC);
end component;

begin

ab <= qs(0) and qs(1);
abc <= ab and qs(2);
junta1 <= qs(0)and verify;
junta2 <= ab and verify;
junta3 <= abc and verify;
	





	a : component ffjk2 
	port map(
		j => verify,
		k => verify,
		clock => clock,
		reset => reset,
		q => qs(0),
		q_n => q_ns(0));

	b : component ffjk2 
	port map(
		j => junta1,
		k => junta1,
		clock => clock,
		reset => reset,
		q => qs(1),
		q_n => q_ns(1));
		
	c : component ffjk2 
	port map(
		j => junta2,
		k => junta2,
		clock => clock,
		reset => reset,
		q => qs(2),
		q_n => q_ns(2));
		
	d : component ffjk2 
	port map(
		j => junta3,
		k => junta3,
		clock => clock,
		reset => reset,
		q => qs(3),
		q_n => q_ns(3));




q <= qs;
q_n <= q_ns;

end Behavioral;

