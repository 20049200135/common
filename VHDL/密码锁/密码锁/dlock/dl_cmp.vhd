library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity dl_cmp is
	port(
	a:in std_logic_vector(3 downto 0);
	b:in std_logic_vector(3 downto 0);
	c:out std_logic
	);
end dl_cmp;

architecture behave of dl_cmp is
begin
	c<='1' when a=b else
	'0';
end behave;