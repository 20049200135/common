library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity dlock is
	port(
	clk:in std_logic;
	lock:in std_logic;
	start:in std_logic;
	off_al:in std_logic;
	ps_ch:in std_logic;
	enter:in std_logic;
	key_in:in std_logic_vector(9 downto 0);
	key:out std_logic;
	warn:out std_logic
	);
end dlock;

architecture behave of dlock is

component dl_control
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
end component;

component dl_counter
	port(
	clr:in std_logic;
	clk:in std_logic;
	cout:out std_logic;
	addr:out std_logic_vector(1 downto 0)
	);
end component;

component dl_counter2
port(
	clk:in std_logic;
	clr:in std_logic;
	wro_count:out std_logic
	);
end component;

component dl_reg
	port(
	clk:in std_logic;
	reg_wr:in std_logic;
	en:in std_logic;
	addr:in std_logic_vector(1 downto 0);
	data_in:in std_logic_vector(3 downto 0);
	data_out:out std_logic_vector(3 downto 0)
	);
end component;

component dl_cmp
	port(
	a:in std_logic_vector(3 downto 0);
	b:in std_logic_vector(3 downto 0);
	c:out std_logic
	);
end component;
	
component dl_coder
	port(
	clk:in std_logic;
	en:in std_logic;
	key_in:in std_logic_vector(9 downto 0);
	ps_i:out std_logic;
	code_out:out std_logic_vector(3 downto 0)
	);
end component;

signal code_en:std_logic;
signal cnt_clr:std_logic;
signal cnt_clr2:std_logic;
signal cnt_clk2:std_logic;
signal reg_wr:std_logic;
signal wro_count:std_logic;
signal cin:std_logic;
signal ps_i:std_logic;
signal cmp_r:std_logic;
signal addr:std_logic_vector(1 downto 0);
signal data_out:std_logic_vector(3 downto 0);
signal code_out:std_logic_vector(3 downto 0);

begin
	CONTROL:dl_control
	port map(clk=>clk,lock=>lock,start=>start,off_al=>off_al,ps_ch=>ps_ch,enter=>enter,wro_count=>wro_count,
			ps_i=>ps_i,
			cmp_r=>cmp_r,cin=>cin,code_en=>code_en,cnt_clr=>cnt_clr,cnt_clr2=>cnt_clr2,cnt_clk2=>cnt_clk2,
			reg_wr=>reg_wr,key=>key,warn=>warn
			);
			
	CONUTER:dl_counter
	port map(clr=>cnt_clr,clk=>ps_i,cout=>cin,addr=>addr);
	
	COUNTER2:dl_counter2
	port map(clr=>cnt_clr2,clk=>cnt_clk2,wro_count=>wro_count);
	
	REG:dl_reg
	port map(clk=>clk,reg_wr=>reg_wr,en=>ps_i,addr=>addr,data_in=>code_out,data_out=>data_out);
	
	COMPARATOR:dl_cmp
	port map(a=>code_out,b=>data_out,c=>cmp_r);
	
	CODER:dl_coder
	port map(clk=>clk,en=>code_en,key_in=>key_in,ps_i=>ps_i,code_out=>code_out);
	
end behave;

	
	
