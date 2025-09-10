----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:51:11 06/14/2023 
-- Design Name: 
-- Module Name:    imp - Behavioral 
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

entity imp is
    Port ( clock, btn3, btn1, system_reset : in  STD_LOGIC;
           switch : in  STD_LOGIC_VECTOR (15 downto 0);
           led : out  STD_LOGIC_VECTOR (15 downto 0);
           cx : out  STD_LOGIC_VECTOR (7 downto 0);
           an : out  STD_LOGIC_VECTOR (3 downto 0);
		   cx1 : out  STD_LOGIC_VECTOR (7 downto 0);
		   an1 : out  STD_LOGIC_VECTOR (3 downto 0));
end imp;

architecture Behavioral of imp is

signal clk_1, clk_250, clk_3, clk_4, clk_5 : STD_LOGIC;

signal q_nr, qr, binario_aleatorio : STD_LOGIC_VECTOR(15 downto 0);
signal qc, q_nc : STD_LOGIC_VECTOR(7 downto 0);
signal sw_s : STD_LOGIC_VECTOR(15 downto 0);
signal led_s : STD_LOGIC_VECTOR(15 downto 0);
signal an_s1 : STD_LOGIC_VECTOR(3 downto 0);
signal cx_s1 : STD_LOGIC_VECTOR(7 downto 0);
signal an_s2 : STD_LOGIC_VECTOR(3 downto 0);
signal cx_s2 : STD_LOGIC_VECTOR(7 downto 0);
signal disp5, disp6, disp7, disp8 : STD_LOGIC_VECTOR(7 downto 0);
signal disp0, disp1, disp2, disp3 : STD_LOGIC_VECTOR(7 downto 0);
signal confirmador : STD_LOGIC := '0';
signal btn_s: STD_LOGIC;
signal chave: STD_LOGIC := '1';
-- signal led_s1 : STD_LOGIC;

component div_f is
    Port (clk_d, reset : in STD_LOGIC;
			clk_1, clk_250, clk_3, clk_4, clk_5 : out STD_LOGIC);
end component;


component countdowni is
	port(clock : in STD_LOGIC;
			q_n, q : out STD_LOGIC_VECTOR(7 downto 0);
			btn3, system_reset : in STD_LOGIC);
end component;


component bin_bcd is
    Port ( bin : in  STD_LOGIC_VECTOR (15 downto 0);
           bcd : out  STD_LOGIC_VECTOR (15 downto 0));
end component;


component rand_gen is
    Port ( clk, clock, clock_2, clock_3, clock_4, btn3, system_reset : in  STD_LOGIC;
           q_n, q : out  STD_LOGIC_VECTOR (15 downto 0));
end component;


component comparator is
    Port ( a, b : in  STD_LOGIC_VECTOR (15 downto 0);
			btn1 : in STD_LOGIC;
		   	reset : in STD_LOGIC;     
		   	-- led : out  STD_LOGIC;      
			comp : out  STD_LOGIC); 
end component;


component swf is
    Port ( switch : in  STD_LOGIC_VECTOR (15 downto 0);
           led : out  STD_LOGIC_VECTOR (15 downto 0));
end component;


begin

conversor : component bin_bcd
	port map(
		bin => qr(15 downto 0),
		bcd => binario_aleatorio(15 downto 0));



comparador : component comparator 
    Port map(
		a => qr,
		b => sw_s,
		btn1 => btn1,
		reset => system_reset,
		-- led => led_s1,
		comp => confirmador);

switch_map : component swf 
	port map(
		switch => sw_s,
		led => led_s);

divisor : component div_f
	port map(
		clk_d => clock,
		reset => system_reset,
		clk_1 => clk_1,
		clk_3 => clk_3,
		clk_4 => clk_4,
		clk_5 => clk_5,
		clk_250 => clk_250);

countdown : component countdowni
	port map(
		clock => clk_1,
		q_n => q_nc,
		q => qc,
		btn3 => btn3,
		system_reset => system_reset);
				
gerador : component rand_gen
	port map(
		clk => clock,
		clock => clk_250,
		clock_2 => clk_3,
		clock_3 => clk_4,
		clock_4 => clk_5,
		q_n => q_nr,
		q => qr,
		btn3 => btn3,
		system_reset => system_reset);

-- led (14 downto 0) <= qr (14 downto 0);
-- led (15) <= led_s1;
led <= led_s;
an <= an_s1;
sw_s <= switch;
cx <= cx_s1;
an1 <= an_s2;
cx1 <= cx_s2;

-- qr <= "0001101110001011"; -- Decimal: 7051 -- BCD: 0111 0000 0101 0001 Binario: 0001101110001011
-- qr <= "0000001000100110";
-- qr <= "0000000000000001";

binario_aleatorio(15) <= '0'; -- Bit mais significativo zerado

process(clk_250, system_reset)
variable conta4 : integer := 1 ;
begin
	if (system_reset = '1') then
		conta4 := 1;
		cx_s1 <= "11111111";
		an_s1 <= "1111";
	elsif rising_edge(clk_250) then
	
		if(conta4 = 1) then
			cx_s1 <= disp6; 	--3
			an_s1 <= "0111";
			conta4 := conta4 + 1;

		elsif(conta4 = 2) then
			cx_s1 <= disp5; 	--2
			an_s1 <= "1011";
			conta4 := conta4 + 1;


		elsif(conta4 = 3) then
			cx_s1 <= disp1; 	--1
			an_s1 <= "1101";
			conta4 := conta4 + 1;

		elsif(conta4 = 4) then
			cx_s1 <= disp0; 	--0
			an_s1 <= "1110";
			conta4 := 1;

		end if;	
	end if;
end process;

process(clk_250, system_reset)
variable conta8 : integer := 1 ;
begin
	if (system_reset = '1') then
		conta8 := 1;
		cx_s2 <= "11111111";
		an_s2 <= "1111";
	elsif rising_edge(clk_250) then
	
		if(conta8 = 1) then
			cx_s2 <= disp7;		--8
			an_s2 <= "0111";
			conta8 := conta8 + 1;

		elsif(conta8 = 2) then
			cx_s2 <= disp8; 	--7
			an_s2 <= "1011";
			conta8 := conta8 + 1;

		elsif(conta8 = 3) then
			cx_s2 <= disp3;		--6
			an_s2 <= "1101";
			conta8 := conta8 + 1;

		elsif(conta8 = 4) then
			cx_s2 <= disp2;		--5
			an_s2 <= "1110";
			conta8 := 1;

		end if;
	end if;
end process;


process(clk_250, qc, qr, chave, binario_aleatorio, sw_s, confirmador, system_reset)
	begin
		
	if (system_reset = '1') then
		chave <= '1';
	elsif (btn1 = '1' ) then
		chave <= '0';
	end if;

	-- Quando o tempo chega a 00 (zero), mostra FF
	if(qc = "00000000" and confirmador = '0') then
		disp0 <= "10001110"; --FF
		disp1 <= "10001110"; --FF
		disp5 <= "10001110"; --FF
		disp6 <= "10001110"; --FF

	elsif(chave = '1') then
		-- Durante a contagem, disp5 e disp6 ficam apagados
		disp5 <= "11111111"; --APAGADO
		disp6 <= "11111111"; --APAGADO
		
		case qc(3 downto 0) is
			when "0000" => disp0 <= "11000000"; --0
			when "0001" => disp0 <= "11111001"; --1
			when "0010" => disp0 <= "10100100"; --2
			when "0011" => disp0 <= "10110000"; --3
			when "0100" => disp0 <= "10011001"; --4
			when "0101" => disp0 <= "10010010"; --5
			when "0110" => disp0 <= "10000010"; --6
			when "0111" => disp0 <= "11111000"; --7
			when "1000" => disp0 <= "10000000"; --8
			when "1001" => disp0 <= "10010000"; --9
			when others => disp0 <= "11111111"; --APAGADO
		end case;
			
		case qc(7 downto 4) is
			when "0000" => disp1 <= "11000000"; --0
			when "0001" => disp1 <= "11111001"; --1
			when "0010" => disp1 <= "10100100"; --2
			when "0011" => disp1 <= "10110000"; --3
			when "0100" => disp1 <= "10011001"; --4
			when others => disp1 <= "11111111"; --APAGADO
		end case;
	elsif(chave = '0') then
		case confirmador is
			when '0' => disp0 <= "10001110"; --FF
						disp1 <= "10001110"; --FF
						disp5 <= "10001110"; --FF
						disp6 <= "10001110"; --FF

			when '1' => disp0 <= "10000010"; --GG
						disp1 <= "10000010"; --GG
						disp5 <= "10000010"; --GG
						disp6 <= "10000010"; --GG

			when others => 	disp1 <= "11111111";	--APAGADO
							disp0 <= "11111111"; 	--APAGADO
							disp5 <= "11111111"; 	--APAGADO
							disp6 <= "11111111"; 	--APAGADO
		end case;
	end if;



	case binario_aleatorio(3 downto 0) is
		when "0000" => disp2 <= "11000000"; --0
		when "0001" => disp2 <= "11111001"; --1
		when "0010" => disp2 <= "10100100"; --2
		when "0011" => disp2 <= "10110000"; --3
		when "0100" => disp2 <= "10011001"; --4
		when "0101" => disp2 <= "10010010"; --5
		when "0110" => disp2 <= "10000010"; --6
		when "0111" => disp2 <= "11111000"; --7
		when "1000" => disp2 <= "10000000"; --8
		when "1001" => disp2 <= "10010000"; --9
		when others => disp2 <= "11111111"; --APAGADO
	end case;
	
	case binario_aleatorio(7 downto 4) is
		when "0000" => disp3 <= "11000000"; --0
		when "0001" => disp3 <= "11111001"; --1
		when "0010" => disp3 <= "10100100"; --2
		when "0011" => disp3 <= "10110000"; --3
		when "0100" => disp3 <= "10011001"; --4
		when "0101" => disp3 <= "10010010"; --5
		when "0110" => disp3 <= "10000010"; --6
		when "0111" => disp3 <= "11111000"; --7
		when "1000" => disp3 <= "10000000"; --8
		when "1001" => disp3 <= "10010000"; --9
		when others => disp3 <= "11111111"; --APAGADO
	end case;

		case binario_aleatorio(11 downto 8) is
		when "0000" => disp8 <= "11000000"; --0
		when "0001" => disp8 <= "11111001"; --1
		when "0010" => disp8 <= "10100100"; --2
		when "0011" => disp8 <= "10110000"; --3
		when "0100" => disp8 <= "10011001"; --4
		when "0101" => disp8 <= "10010010"; --5
		when "0110" => disp8 <= "10000010"; --6
		when "0111" => disp8 <= "11111000"; --7
		when "1000" => disp8 <= "10000000"; --8
		when "1001" => disp8 <= "10010000"; --9
		when others => disp8 <= "11111111"; --APAGADO
	end case;

		case binario_aleatorio(15 downto 12) is
		when "0000" => disp7 <= "11000000"; --0
		when "0001" => disp7 <= "11111001"; --1
		when "0010" => disp7 <= "10100100"; --2
		when "0011" => disp7 <= "10110000"; --3
		when "0100" => disp7 <= "10011001"; --4
		when "0101" => disp7 <= "10010010"; --5
		when "0110" => disp7 <= "10000010"; --6
		when "0111" => disp7 <= "11111000"; --7
		when "1000" => disp7 <= "10000000"; --8
		when "1001" => disp7 <= "10010000"; --9
		when others => disp7 <= "11111111"; --APAGADO
	end case;
	
end process;

end Behavioral;

