library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity dl_counter2 is
port(
	clk:in std_logic;
	clr:in std_logic;
	wro_count:out std_logic
	);
end entity;

architecture behave of dl_counter2 is
signal cnt:std_logic_vector(1 downto 0);
begin 
	process(clk,clr)
	begin
		if clr='1' then
		cnt<="00";
		wro_count<='0';
		elsif rising_edge(clk) then
			if cnt="10" then
				cnt<="11";
				wro_count<='1';
			else
				cnt<=cnt+'1';
			end if;
		end if;
	end process;
end behave;
	