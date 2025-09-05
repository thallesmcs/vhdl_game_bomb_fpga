----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:39:07 06/13/2023 
-- Design Name: 
-- Module Name:    fa8 - Behavioral 
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

entity fa8 is
    Port ( a, b : in  STD_LOGIC_VECTOR (7 downto 0);
           cin : in  STD_LOGIC;
           cout : out  STD_LOGIC;
           sum : out  STD_LOGIC_VECTOR (7 downto 0));
end fa8;

architecture Behavioral of fa8 is

signal cout_interno : STD_LOGIC_VECTOR(6 downto 0);

component full_add is
    Port ( a, b, cin : in  STD_LOGIC;
           cout, sum : out  STD_LOGIC);
end component;


begin

	fa1 : component full_add
	port map(
		a => a(0),
		b => b(0),
		cin => cin,
		cout => cout_interno(0),
		sum => sum(0));
		
	fa2 : component full_add
	port map(
		a => a(1),
		b => b(1),
		cin => cout_interno(0),
		cout => cout_interno(1),
		sum => sum(1));

	fa3 : component full_add
	port map(
		a => a(2),
		b => b(2),
		cin => cout_interno(1),
		cout => cout_interno(2),
		sum => sum(2));

	fa4 : component full_add
	port map(
		a => a(3),
		b => b(3),
		cin => cout_interno(2),
		cout => cout_interno(3),
		sum => sum(3));

	fa5 : component full_add
	port map(
		a => a(4),
		b => b(4),
		cin => cout_interno(3),
		cout => cout_interno(4),
		sum => sum(4));

	fa6 : component full_add
	port map(
		a => a(5),
		b => b(5),
		cin => cout_interno(4),
		cout => cout_interno(5),
		sum => sum(5));

	fa7 : component full_add
	port map(
		a => a(6),
		b => b(6),
		cin => cout_interno(5),
		cout => cout_interno(6),
		sum => sum(6));

	fa8 : component full_add
	port map(
		a => a(7),
		b => b(7),
		cin => cout_interno(6),
		cout => cout,
		sum => sum(7));

		
end Behavioral;

