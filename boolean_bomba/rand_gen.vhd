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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rand_gen is
    Port ( clk, clock, clock_2, clock_3, clock_4, btn3, system_reset : in  STD_LOGIC;
           q_n, q : out  STD_LOGIC_VECTOR (15 downto 0));
end rand_gen;

architecture Behavioral of rand_gen is

signal reset_dec : STD_LOGIC;
signal reset_un : STD_LOGIC;
signal reset_cen : STD_LOGIC;
signal reset_mil : STD_LOGIC;
signal q_ns, qs : STD_LOGIC_VECTOR(15 downto 0);
signal switch1, btn_s : STD_LOGIC;
signal verify1 : STD_LOGIC := '1';
signal reset1_10000 : STD_LOGIC;
signal reset2_10000 : STD_LOGIC;

component ffjk4 is
    Port (clock, reset : in  STD_LOGIC;
           verify : in  STD_LOGIC;
           q, q_n : out  STD_LOGIC_VECTOR (3 downto 0));
end component;

begin

-- Detecta especificamente quando chegar a 10000 (binário: 10011100010000)
-- Ou quando qualquer valor >= 10000

reset1_10000 <= '1' when (unsigned(qs) >= 10000) else '0';

-- Outra Abordagem que poderia ser usada:
-- Detecta quando milhar = 9 (1001) E centena = 9 (1001) E dezena = 9 (1001) E unidade = 9 (1001)
-- reset_10000 <= '1' when (qs(15) = '1' and qs(14) = '0' and qs(13) = '0' and qs(12) = '1' and  -- milhar = 9
--                          qs(11) = '1' and qs(10) = '0' and qs(9) = '0' and qs(8) = '1' and    -- centena = 9
--                          qs(7) = '1' and qs(6) = '0' and qs(5) = '0' and qs(4) = '1' and      -- dezena = 9
--                          qs(3) = '1' and qs(2) = '0' and qs(1) = '0' and qs(0) = '1') else '0'; -- unidade = 9

-- Detecta especificamente quando chegar a 10000 decimal (binário: 0010011100010000)
-- Bit por bit: 15=0, 14=0, 13=1, 12=0, 11=0, 10=1, 9=1, 8=1, 7=0, 6=0, 5=0, 4=1, 3=0, 2=0, 1=0, 0=0
reset2_10000 <= '1' when (qs(15) = '0' and qs(14) = '0' and qs(13) = '1' and qs(12) = '0' and  -- bits 15-12
                         qs(11) = '0' and qs(10) = '0' and qs(9) = '1' and qs(8) = '1' and     -- bits 11-8
                         qs(7) = '0' and qs(6) = '0' and qs(5) = '1' and qs(4) = '0' and       -- bits 7-4
                         qs(3) = '1' and qs(2) = '0' and qs(1) = '0' and qs(0) = '0') else '0'; -- bits 3-0


process(btn3, clk, system_reset)
begin
	if (system_reset = '1') then
		verify1 <= '1';
	elsif (btn3 = '1') then
		verify1 <= '0';
	end if;
end process;

-- switch1 não é usado neste componente, mantido para compatibilidade
switch1 <= '0';

	milhar : component ffjk4
	port map(
		clock => clock_4,
		reset => reset_mil,
		q_n => q_ns(15 downto 12),
		verify => verify1,
		q => qs(15 downto 12));

	centena : component ffjk4
	port map(
		clock => clock_3,
		reset => reset_cen,
		q_n => q_ns(11 downto 8),
		verify => verify1,
		q => qs(11 downto 8));

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
reset_un <= switch1 or reset1_10000 or reset2_10000 or system_reset;
reset_dec <= switch1 or reset1_10000 or reset2_10000 or system_reset;
reset_cen <= switch1 or reset1_10000 or reset2_10000 or system_reset;
reset_mil <= switch1 or reset1_10000 or reset2_10000 or system_reset;





end Behavioral;

