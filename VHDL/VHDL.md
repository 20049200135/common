# VHDLVHDL

# 第一章

## 一、 学习方法

1. 不能在综合程序中出现只能用于仿真的VHDL语言或者数据类型
2. 练习基模块的VHDL设计
3. 常用语句，多用多记

# 第二章

## 二、结构

​	外部接口 

​	实体内部功能（结构体式的模块化设计）

```vhdl
--与门设计
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;                        --调用库和程序包

ENTITY AndGate IS
    PORT(a,b:IN STD_LOGIC;
        c:OUT STD_LOGIC);
    END AndGate;                                    --结构体声明
    
    
ARCHITECTURE behave OF AndGate IS
    BEGIN
        c <= a AND b;  --逻辑与操作
    END behave;                                     --结构体
```

​	程序文件名  A.vhd  VHDL规定文件名必须与实体名称相同（AndGate.vhd）。

​	综上，VHDL程序由三部分组成：库和程序包调用，实体声明，结构体。

​	但，一些模块的对外接口相同，但实体内部功能不同，一个实体对应多个结构体，描述实体与结构体的对应关系，可用配置来实现

## 三、实体声明

​	[  ]内为可选项

​	

```vhdl
ENTITY 实体名 IS
[GENERIC(常数名1:常数数据类型[:=常值数]
		常数名2:常数数据类型[:=常数值]
        ...
		);]
    PORT(
    		端口名1: 端口方向 端口数据类型;
    		端口名2: 端口方向 端口数据类型;
    		...
    		);
    END [实体名]；
     1. 类属参数说明
```

​    1. 类属参数说明

​			类属参数说明，可以在调用实体时将参数传递到实体内部，常用来规定实体端口的大小、信号的定时特性、计数器的模值等。

   2. 端口声明

      常用四种端口方向 IN  OUT  INOUT   BUFFER.

## 四、结构体

```VHDL
ARCHITECTURE 结构体名 OF 实体名 IS
    [结构体声明]
    BEGIN
        结构体功能描述语句;
    END [结构体名];
```

1. 结构体声明

   结构体声明用于声明该结构体内用到的   信号(signal),用户自定义数据类型(type),常数(constant),过程(procedure),函数(function),和元件(component)等。

   【注意】：结构体声明语句中声明对象只在该结构体内可见，即有效范围在该结构体内。

2. 结构体功能描述语句

| 语句类型     | 语句说明                                                     |
| ------------ | ------------------------------------------------------------ |
| 信号赋值语句 | 通过赋值符号"<=",将结构体内运算结果赋给内部信号或者输出端口  |
| 进程语句     | 进程(process)用于描述存在先后顺序的事件，其内部为顺序语句，但不同进程之间还是并行的关系，进程只会在敏感信号发生变化时才会触发 |
| 元件例化语句 | 调用底层实体作为本层实体的一个元件使用                       |
| 子程序调用   | 子程序包括过程（procedure）和函数（function），子程序只能通过他们的端口与结构体通信 |
| 块语句       | 块（Block）语句由一系列并行语句构成，对程序划分模块，改善程序可读性 |

``` VHDL
--六进制计数器
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY COUNTER_6 IS
    PORT(CLK:IN STD_LOGIC;
        RST:IN STD_LOGIC
        COUT:OUT INTEGER RANGE 0 TO 5);
    END COUNTER_6;
    ARCHITECTURE BEHAVE OF COUNTER_6 IS
        SIGNAL CNT:INTEGER RANGE 0 TO 5;
	BEGIN
        COUT <= CNT;
		PROCESS(CLK);
		BEGIN
            IF(CLK'EVENT AND CLK ='1')THEN
                IF(RST = '1')THEN
                    CNT <= 0;
                ELSIF(CNT = 5)THEN
                    CNT <= 0;
                ELSE
                    CNT <= CNT+1;
                END IF;
            END IF;
        END PROCESS;
     END BEHAVE;
```

进程中敏感信号为CLK，因此在CLK信号的上升沿和下降沿都将激活进程，其中第一个语句描述了时钟上升沿，表示只有在时钟上升沿处才执行剩余语句所描述的计数操作。

## 五、库和函数包的的调用

```VHDL
LIBRARY 库名
******** * * *************************
USE 库名.程序包名.项目名;
广泛使用的STD库中的standard程序包以及IEEE库中的std_logic_1164,std_arith
```

```VHDL
--使用此代码时，要自制元件ADD1BIT;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL; 

ENTITY FULL_ADD IS
	PORT(CI:IN STD_LOGIC;     --低位向本位进位
		A:IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		B: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		S: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		CO: OUT STD_LOGIC);   --本位向高位的进位
END FULL_ADD;

ARCHITECTURE BEHAVE OF FULL_ADD IS
	SINGAL C STD_LOGIC_VECTOR(0 TO 8);
	COMPONENT ADD1BIT 
		PORT(A,B,CI: IN STD_LOGIC;
			S,CO: OUT STD_LOGIC );
	END ADD1BIT;                   --元件声明                                               
	BEGIN
		C(0) <= CI;
		U1: ADD1BIT PORT MAP (C(0),A(0),B(0),S(0),C(1));
		U2: ADD1BIT PORT MAP (C(1),A(1),B(1),S(1),C(2));
		U3: ADD1BIT PORT MAP (C(2),A(2),B(2),S(2),C(3));
		U4: ADD1BIT PORT MAP (C(3),A(3),B(3),S(3),C(4));
		U5: ADD1BIT PORT MAP (C(4),A(4),B(4),S(4),C(5));
		U6: ADD1BIT PORT MAP (C(5),A(5),B(5),S(5),C(6));
		U7: ADD1BIT PORT MAP (C(6),A(6),B(6),S(6),C(7));
		U8: ADD1BIT PORT MAP (C(7),A(7),B(7),S(7),C(8));
		CO <= C(8);                                                  --元件例化
END BEHAVE;
--可改进方式：for循环
```

Y由此，可使用如下改进方式


​		

```vhdl
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY FULL_ADDER IS
    PORT(CI:IN STD_LOGIC;
         A:IN STD_LOGIC_VECTOR(7 DOWNTO 0);
         B:IN STD_LOGIC_VECTOR(7 DOWNTO 0);
         S:OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
         CO:OUT STD_LOGIC);
END FULL_ADDER;
ARCHITECTURE BEHAVE OF FULL_ADDER IS
    SIGNAL COUT,AA,BB:STD_LOGIC_VECTOR(8 DOWNTO 0);
		BEGIN
            AA <= '0'& A;                 -- ‘&’在VHDL中作为连接符使用
			BB <= '0'& B;
			COUT <= AA + BB +CI;
			S <= COUT(7 DOWNTO 0);
			CO <= COUT(8);

END BEHAVE;
```

​    

1. Standard程序包
2. 主要定义了一些基本的数据类型，包括boolean,bit,character,integer,real,string,boolean_vector,bit_vector,另外包括，出错级别类型，时间类型，文件类型。

# 第三章

一、关键字

二、标志符

​	用户自定义的名称，如实体名称，结构名称，元件名称等

​	命名规则：略

三、数字

 1. 默认十进制，科学计数法用‘e’，或者 ‘E’ 表示

 2. 使用非十进制数，格式 ：进制#数字#

 3. 数字可读性：2#010110101110#  =   2#0101_1010_1110#       等价

 4. 字符和字符串：字符使用单引号，字符串使用双引号    '1', 'd', "00101".

 5. 位串：表示一串0 1比特，可用二进制，八进制，十六进制来表示,

    ```
    二进制  B"1100_1011"
    十六进制 X"C9";
    八进制  O"113".
    ```

6. 注释

   ​	--来表示



```VHDL
LIBRARY LEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL
ENTITY BCD_FULL_ADDER IS
    PORT(A,B,C,D:IN STD_LOGIC_VECTOR(3 DOWNTO 0);
         CI1:IN STD_LOGIC;
         CO2:OUT STD_LOGIC
        );
END BCD_FULL_ADDER;

ARCHITECTURE BEHAVE OF BCD_FULL_ADDER IS
    SIGNAL (AA,BB,CC,DD:STD_LOGIC_VECTOR(4 DOWNTO 0);
           		CO1:STD_LOGIC;
           		CI2:STD_LOGIC);
	BEGIN 
        AA<='0' & A;
		BB<='0' & B;
		CC<='0' & C;
		DD<='0' & D;
		S1<= AA+ BB+CI1;
		IF(S1>="01001")THEN
            CO1<='1';
			CI2<=CO1;
		END IF;
        S2<= CC+DD+CI2;
		IF(S2>="01001")THEN
            CO2<='1';
		END IF;
		COUT<=S2(3 DOWNTO 0)&S1(3 DOWN TO 0);
END BEHAVE;
		

        
 
```

```VHDL
LIBRARY IEEE;                                                             --结构描述方式实现BCD码加法器
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY	homework8 IS
	PORT(
	AA,BB:IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	FF:OUT STD_LOGIC_VECTOR(3 DOWNTO 0);      --FF为最终输出
	CIN:IN STD_LOGIC;
	COUT:OUT STD_LOGIC
	);
END homework8;
ARCHITECTURE yejiayu OF homework8 IS
COMPONENT homework6						
	PORT(
	A,B:IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	F:OUT STD_LOGIC_VECTOR(3 DOWNTO 0);       --四位全加器的输出   
	CI:IN STD_LOGIC;                          --低位
	CO:OUT STD_LOGIC						  --高位
	);
END COMPONENT homework6;
											  --修正判别过渡
	SIGNAL Q1:STD_LOGIC_VECTOR(3 DOWNTO 0);   --Q1接手四位全加器的输出
	SIGNAL Q2:STD_LOGIC_VECTOR(3 DOWNTO 0);   --Q2为修正被加数
	SIGNAL COU1:STD_LOGIC;					  
	SIGNAL COU2:STD_LOGIC;					 
BEGIN
	U1:homework6 PORT MAP(A=>AA,B=>BB,CI=>CIN,F=>Q1,CO=>COU1);--修正判别
	COU2<=NOT((NOT COU1)AND(NOT(Q1(3) AND Q1(2)))AND(NOT(Q1(3) AND Q1(1))));
    Q2<=(2=>COU2,3=>COU2,OTHERS =>'0');       --被加数的2，3位与COU2相连，其余接地
    U2:homework6 PORT MAP(A=>Q2,B=>Q1,CI=>'0',F=>FF,CO=>COU1);--修正
END yejiayu;
```

```VHDL
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
PACKAGE disppack IS
		FUNCTION ADDT(addrr: IN INTEGER RANGE 0 TO 15)
		RETURN STD_LOGIC_VECTOR;
		FUNCTION DIGIT(addrr: IN INTEGER RANGE 0 TO 15)
		RETURN STD_LOGIC_VECTOR;
		FUNCTION DOTSEL(addrr: IN INTEGER RANGE 0 TO 15)
		RETURN STD_LOGIC_VECTOR;
END disppack;
	
PACKAGE BODY disppack IS
      FUNCTION ADDT(addrr: IN INTEGER RANGE 0 TO 15)
		RETURN STD_LOGIC_VECTOR IS
          BEGIN
				CASE addrr IS 
						WHEN 0 =>  RETURN "0000";
						WHEN 1 =>  RETURN "0001";
						WHEN 2 =>  RETURN "0010";
						WHEN 3 =>  RETURN "0011";
						WHEN 4 =>  RETURN "0100";
						WHEN 5 =>  RETURN "0101";
						WHEN 6 =>  RETURN "0110";
						WHEN 7 =>  RETURN "0111";
						WHEN 8 =>  RETURN "1000";
						WHEN 9 =>  RETURN "1001";
						WHEN 10 => RETURN "1010";
						WHEN 11 => RETURN "1011";
						WHEN 12 => RETURN "1100";
						WHEN 13 => RETURN "1101";
						WHEN 14 => RETURN "1110";
						WHEN 15 => RETURN "1111";
						WHEN OTHERS =>  RETURN "XXXX";
				END CASE;
		END ADDT;


		FUNCTION DIGIT(addrr: IN INTEGER RANGE 0 TO 15 )
		RETURN STD_LOGIC_VECTOR IS
			BEGIN
				CASE addrr IS 
						WHEN 0 =>  RETURN "11111111";
						WHEN 1 =>  RETURN "11111111";
						WHEN 2 =>  RETURN "01111111";
						WHEN 3 =>  RETURN "01111111";
						WHEN 4 =>  RETURN "01111111";
						WHEN 5 =>  RETURN "11111111";
						WHEN 6 =>  RETURN "11111111";
						WHEN 7 =>  RETURN "01111111";
						WHEN 8 =>  RETURN "01111111";
						WHEN 9 =>  RETURN "01111111";
						WHEN 10 => RETURN "11111111";
						WHEN 11 => RETURN "11111111";
						WHEN 12 => RETURN "01111111";
						WHEN 13 => RETURN "01111111";
						WHEN 14 => RETURN "01111111";
						WHEN 15 => RETURN "01111111";
						WHEN OTHERS =>  RETURN "XXXXXXXX";
				END CASE;
		END DIGIT;
		
		FUNCTION DOTSEL(addrr: IN INTEGER RANGE 0 TO 15 )
		RETURN STD_LOGIC_VECTOR IS
			BEGIN
				CASE addrr IS 
						WHEN 0 =>  RETURN  "0000000000000000";
						WHEN 1 =>  RETURN  "0000000000000000";
						WHEN 2 =>  RETURN  "0001111111111000";
						WHEN 3 =>  RETURN  "0000000110000000";
						WHEN 4 =>  RETURN  "0000000110000000";
						WHEN 5 =>  RETURN  "0000000110000000";
						WHEN 6 =>  RETURN  "0000000110000000";
						WHEN 7 =>  RETURN  "0000000110000000";
						WHEN 8 =>  RETURN  "0000000110000000";
						WHEN 9 =>  RETURN  "0000000000000000";
						WHEN 10 =>  RETURN "0000000110000000";
						WHEN 11 =>  RETURN "0000000110000000";
						WHEN 12 =>  RETURN "0000000110000000";
						WHEN 13 =>  RETURN "0000000110000000";
						WHEN 14 =>  RETURN "0000000000000000";
						WHEN 15 =>  RETURN "0000000000000000";
						WHEN OTHERS =>  RETURN "XXXXXXXXXXXXXXXX";
				END CASE;
		END DOTSEL;
END ;


LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.disppack.all;

ENTITY displays IS
    PORT( clk: IN STD_LOGIC; 
			DOTOUT: OUT STD_LOGIC_VECTOR(0 TO 19); -- DOTOUT(0 to 3) is address
			--LEDOUT: OUT STD_LOGIC_VECTOR(0 TO 11);  -- LEDOUT(0 to 3) is address
			VGA: OUT STD_LOGIC_VECTOR(0 TO 3)
			
			);
END displays;

ARCHITECTURE one OF displays IS
CONSTANT FP: INTEGER:= 800000; 
SIGNAL qb: INTEGER RANGE 0 TO FP ; 
SIGNAL clock: STD_LOGIC;
SIGNAL add: INTEGER RANGE 0 TO 15;

BEGIN
    PROCESS(clk)
    BEGIN 
        IF clk'EVENT AND clk = '1' THEN
                qb <= qb + 1;
                IF qb = FP THEN clock <= NOT clock; qb <= 0; END IF;
        END IF;
   END PROCESS;
	
	PROCESS(clock)   -- around >=30 times a sencond doing refreshing 
	BEGIN
	     IF clock'EVENT AND clock = '1' THEN
				 VGA <= "1010";   -- device select:dot matrix screen;
	             DOTOUT(0 to 3) <= ADDT(add);  DOTOUT(4 to 19) <= DOTSEL(add);    
				  --VGA <= "1011"; -- device select: 16 LED lights;
				  --LEDOUT(0 to 3) <= ADDT(add);  LEDOUT(4 to 11) <= DIGIT(add); 
		       add <= add + 1;
		  END IF;  
	END PROCESS;
	END one;

```

```
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE WORK.CPU8PAC.ALL;
USE WORK.BV_MATH.ALL;

ENTITY COUNT IS

	PORT(CLK,RST:IN STD_LOGIC;
		CI:IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		CO:BUFFER STD_LOGIC_VECTOR(3 DOWNTO 0));
END COUNT;
ARCHITECTURE BEHAVE OF COUNT IS
	BEGIN
	PROCESS(RST,CLK)
	BEGIN
		IF(RST = '0')THEN
			CO <= "0000";
		ELSIF(CLK'EVENT AND CLK = '1')THEN
			

```

