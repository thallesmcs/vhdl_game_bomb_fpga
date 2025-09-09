----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:31:21 06/13/2023 
-- Design Name: 
-- Module Name:    full_add - Behavioral 
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

entity full_add is
    Port ( a, b, cin : in  STD_LOGIC;
           cout, sum : out  STD_LOGIC);
end full_add;

architecture Behavioral of full_add is

signal a_x_b, and_a_b, and_cin : STD_LOGIC;



begin

a_x_b <= a xor b;
and_a_b <= a and b;
and_cin <= a_x_b and cin;

sum <= a_x_b xor cin;
cout <= and_a_b or and_cin;


end Behavioral;

