library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity dl_reg is
	port(
	clk:in std_logic;
	reg_wr:in std_logic;
	en:in std_logic;
	addr:in std_logic_vector(1 downto 0);
	data_in:in std_logic_vector(3 downto 0);
	data_out:out std_logic_vector(3 downto 0)
	);
end entity;

architecture behave of dl_reg is
signal m0:std_logic_vector(3 downto 0);
signal m1:std_logic_vector(3 downto 0);
signal m2:std_logic_vector(3 downto 0);
begin
	process(clk)
	begin
		if falling_edge(clk) then
			if en='1' then
				case addr is
					when "01"=>
						if reg_wr='1' then
							m0<=data_in;
						else
							data_out<=m0;
						end if;
					when "10"=>
						if reg_wr='1' then
							m1<=data_in;
						else
							data_out<=m1;
						end if;
					when "11"=>
						if reg_wr='1' then
							m2<=data_in;
						else
							data_out<=m2;
						end if;
					when OTHERS=>
						NULL;
					end case;
				end if;
			end if;
		end process;
	end behave;