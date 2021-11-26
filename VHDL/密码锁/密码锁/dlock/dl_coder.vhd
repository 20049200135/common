library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity dl_coder is
	port(
	clk:in std_logic;
	en:in std_logic;
	key_in:in std_logic_vector(9 downto 0);
	ps_i:out std_logic;
	code_out: out std_logic_vector(3 downto 0)
	);
end dl_coder;

architecture behave of dl_coder is
signal key_in_1:std_logic_vector(9 downto 0);
signal key_in_2:std_logic_vector(9 downto 0);
begin
	U1:process(clk)
	begin
		if rising_edge(clk) then
			if en='1' then
				if key_in="0000000000" then
				key_in_1<=key_in;
				key_in_2<=key_in;
				ELSE
				key_in_2<=key_in_1;
				key_in_1<=key_in;
				end if;
			end if;
		end if;
	end process;
	
	ps_i<='1' when key_in_2/=key_in_1 else '0';
	
	U2:process(clk)
	begin
		if rising_edge(clk) then
			if en='1' and key_in/="000000000" then
				case key_in is
				when "0000000001"=>code_out<="0000";
				when "0000000010"=>code_out<="0001";
				when "0000000100"=>code_out<="0010";
				when "0000001000"=>code_out<="0011";
				when "0000010000"=>code_out<="0100";
				when "0000100000"=>code_out<="0101";
				when "0001000000"=>code_out<="0110";
				when "0010000000"=>code_out<="0111";
				when "0100000000"=>code_out<="1000";
				when "1000000000"=>code_out<="1001";
				when OTHERS=>code_out<="0000";
				end case;
			end if;
		end if;
	end process;
end behave;
	