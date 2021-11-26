library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity dl_counter is
	port(
	clr:in std_logic;
	clk:in std_logic;
	cout:out std_logic;
	addr:out std_logic_vector(1 downto 0)
	);
end dl_counter;
	
architecture behave of dl_counter is
constant RESET_ACTIVE:std_logic:='1';
signal cnt:std_logic_vector(1 downto 0);
begin
	addr<=cnt;
	process(clk,clr)
	begin
		if clr=RESET_ACTIVE then
			cnt<="00";
			cout<='0';
		elsif rising_edge(clk) then
			if cnt="10" then
				cnt<="11";
				cout<='1';
			else
				cnt<=cnt+'1';
			end if;
		end if;
	end process;
end behave;