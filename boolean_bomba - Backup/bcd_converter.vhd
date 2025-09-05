----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    02:10:23 06/13/2023 
-- Design Name: 
-- Module Name:    bcd_converter - Behavioral 
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

entity bcd_converter is
    Port ( entrada : in  STD_LOGIC_VECTOR (7 downto 0);
           sum : out  STD_LOGIC_VECTOR (7 downto 0));
end bcd_converter;

architecture Behavioral of bcd_converter is

signal unidade : STD_LOGIC_VECTOR(7 downto 0); 
signal decimal_8 : STD_LOGIC_VECTOR(7 downto 0);
signal decimal_2 : STD_LOGIC_VECTOR(7 downto 0);
signal cout_interno : STD_LOGIC_VECTOR(1 downto 0);
signal acumulador : STD_LOGIC_VECTOR(7 downto 0);

component fa8 is
    Port ( a, b : in  STD_LOGIC_VECTOR (7 downto 0);
           cin : in  STD_LOGIC;
           cout : out  STD_LOGIC;
           sum : out  STD_LOGIC_VECTOR (7 downto 0));
end component;


begin

unidade(3 downto 0) <= entrada(3 downto 0);
unidade(7 downto 4) <= "0000";

decimal_8(2 downto 0) <= "000";
decimal_8(6 downto 3) <= entrada(7 downto 4);
decimal_8(7) <= '0';

decimal_2(0) <= '0';
decimal_2(4 downto 1) <= entrada(7 downto 4);
decimal_2(7 downto 5) <= "000";

	um : component fa8
	port map(
		a => decimal_8,
		b => decimal_2,
		cin => '0',
		cout => cout_interno(0),
		sum => acumulador(7 downto 0));

	dois : component fa8
	port map(
		a => acumulador(7 downto 0),
		b => unidade,
		cin => cout_interno(0),
		cout => cout_interno(1),
		sum => sum);



end Behavioral;

