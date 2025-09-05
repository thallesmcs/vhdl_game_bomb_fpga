----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:50:00 04/25/2023 
-- Design Name: 
-- Module Name:    div_f - Behavioral 
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

entity div_f is
    Port (clk_d, reset : in STD_LOGIC;
			clk_1, clk_250, clk_3, clk_4, clk_5 : out STD_LOGIC);
end div_f;

architecture Behavioral of div_f is
signal count_1 : integer range 0 to 100_000_000;
signal count_2 : integer range 0 to 100_000_000;
signal count_3 : integer range 0 to 100_000_000;
signal count_4 : integer range 0 to 100_000_000;
signal count_5 : integer range 0 to 100_000_000;
signal clock_1 : std_logic := '0';
signal clock_2 : std_logic := '0';
constant total_1 : integer := 50_000_000;
constant total_2 : integer := 200_000;
signal clock_3 : std_logic := '0';
signal clock_4 : std_logic := '0';
signal clock_5 : std_logic := '0';
constant total_4 : integer := 2;
constant total_5 : integer := 25_000_000;
constant total_3 : integer := 4;


begin

clk_1 <= clock_1;
clk_250 <= clock_2;
clk_3 <= clock_3;
clk_4 <= clock_4;
clk_5 <= clock_5;

	process(clk_d, reset) 
	
	begin
		
		--if (reset =  '0')then
			--count_1 <= 0;
			--count_2 <= 0;
			--clock_1 <= '0';
			--clock_2 <= '0';

		
		if (rising_edge(clk_d))then
			count_1  <= count_1 + 1;
			count_2  <= count_2 + 1;
			count_3 <= count_3 + 1;
			count_4 <= count_4 + 1;
			count_5 <= count_5 + 1;
			
			if ( count_1 = total_1)then 
				count_1 <= 0;
				clock_1 <= not clock_1;
			end if;
			
			if ( count_2 = total_2)then
				count_2 <= 0;
				clock_2 <= not clock_2;
			end if;
			
			if ( count_3 = total_3)then
				count_3 <= 0;
				clock_3 <= not clock_3;
			end if;
			if ( count_4 = total_4)then
				count_4 <= 0;
				clock_4 <= not clock_4;
			end if;
			if ( count_5 = total_5)then
				count_5 <= 0;
				clock_5 <= not clock_5;
			end if;
		end if;	
	end process;
	
end Behavioral;

