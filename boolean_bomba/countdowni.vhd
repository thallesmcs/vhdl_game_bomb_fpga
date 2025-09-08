----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:04:16 05/28/2023 
-- Design Name: 
-- Module Name:    countdown - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity countdowni is
	port(clock : in STD_LOGIC;
			q_n, q : out STD_LOGIC_VECTOR(7 downto 0);
			btn3, system_reset : in STD_LOGIC);
end countdowni;

architecture Behavioral of countdowni is

signal reset_dez : STD_LOGIC;
signal reset_seg : STD_LOGIC;
signal q_ns, qs : STD_LOGIC_VECTOR(7 downto 0);
signal switch1, btn_s : STD_LOGIC;
signal verify_seg, verify_dez : STD_LOGIC;



component ffjk4 is
    Port (clock, reset : in  STD_LOGIC;
           verify : in  STD_LOGIC;
           q, q_n : out  STD_LOGIC_VECTOR (3 downto 0));
end component;


begin



process(btn3)
begin
	if (btn3 = '1') then
		switch1 <= '1';
	else
		switch1 <= '0';
	end if;
end process;


verify_dez <= ((not qs(0)) and (not qs(1)) and (not qs(2)) and (not qs(3))) and (not qs(6));
verify_seg <= not(qs(6) and  qs(0) and (not qs(1)) and (not qs(2)) and (not qs(3)));


	dez_segundos : component ffjk4
	port map(
		clock => clock,
		reset => reset_dez,
		q_n => q_ns(7 downto 4),
		verify => verify_dez,
		q => qs(7 downto 4));
		

	segundos : component ffjk4
	port map(
		clock => clock,
		reset => reset_seg,
		q_n => q_ns(3 downto 0),
		verify => verify_seg,
		q => qs(3 downto 0));
		

q_n <= q_ns;
q <= qs;
reset_seg <= switch1 or (qs(3) and qs(1)) or system_reset;
reset_dez <= switch1 or (qs(7) and qs(6)) or system_reset;


end Behavioral;

