library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity dl_control is
	port(
	clk:in std_logic;
	lock:in std_logic;
	start:in std_logic;
	off_al:in std_logic;
	ps_ch:in std_logic;
	enter:in std_logic;
	wro_count:in std_logic;
	ps_i:in std_logic;
	cmp_r:in std_logic;
	cin:in std_logic;
	code_en:out std_logic;
	cnt_clr:out std_logic;
	cnt_clr2:out std_logic;
	cnt_clk2:out std_logic;
	reg_wr:out std_logic;
	key:out std_logic;
	warn:out std_logic
	);
end dl_control;

architecture behave of dl_control is
CONSTANT KEY_ACTIVE:STD_LOGIC:='1';
type state_type is (OUTLOCK,INLOCK,PS_INPUT,PS_RIGHT,PS_WRONG,ALARM,PS_CHANGE);
signal state:state_type;

begin
	
	process(clk)
	begin
		if rising_edge(clk) then
			case state is
				when OUTLOCK=>
					key<='0';
					if lock=KEY_ACTIVE then
					state<=INLOCK;
					ELSIF ps_ch=KEY_ACTIVE then
					state<=PS_CHANGE;
					ELSE
					state<=OUTLOCK;
					end if;
				when INLOCK=>
					key<='1';
					code_en<='0';
					cnt_clr<='1';
					reg_wr<='0';
					warn<='0';
					if start=KEY_ACTIVE then
						state<=PS_INPUT;
					else
						state<=INLOCK;
					end if;
				when PS_INPUT=>
					code_en<='1';
					cnt_clr<='0';
					reg_wr<='0';
					if cin='1' and ps_i='1' and cmp_r='1' then
						code_en<='0';
						cnt_clr<='1';
						cnt_clr2<='1';
						state<=PS_RIGHT;
					elsif ps_i='1' and cmp_r='0' then
						code_en<='0';
						cnt_clr<='1';
						cnt_clr2<='0';
						cnt_clk2<='1';
						state<=PS_WRONG;
					elsif enter=KEY_ACTIVE and cin='0' then
						code_en<='0';
						cnt_clr<='1';
						cnt_clr2<='0';
						cnt_clk2<='1';
						state<=ALARM;
					else
						state<=PS_INPUT;
					end if;
				when PS_RIGHT=>
					if enter=KEY_ACTIVE then
						state<=OUTLOCK;
					else
						state<=PS_RIGHT;
					end if;
				when PS_WRONG=>
					if enter=KEY_ACTIVE and wro_count='1' then
						cnt_clk2<='0';
						state<=ALARM;
					elsif enter=KEY_ACTIVE then
						cnt_clk2<='0';
						state<=INLOCK;
					else
						state<=PS_WRONG;
					end if;
				when ALARM=>
					if off_al=KEY_ACTIVE then
						warn<='0';
						state<=INLOCK;
					else
						cnt_clk2<='0';
						warn<='1';
						state<=ALARM;
					end if;
				when PS_CHANGE=>
					code_en<='1';
					cnt_clr<='0';
					reg_wr<='1';
					if cin='1' then 
						code_en<='0';
						cnt_clr<='1';
						state<=OUTLOCK;
					end if;
				WHEN OTHERS=>
					state<=INLOCK;
			end case;
		end if;
	end process;
end behave;