LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY somador8bits IS
PORT ( a, b : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
       s : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END somador8bits;

ARCHITECTURE dataflow OF somador8bits IS

BEGIN 

s <= a + b;

END dataflow;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY deslocaSoma7 IS

PORT (E: IN STD_LOGIC_VECTOR (3 downto 0);
	   S: OUT STD_LOGIC_VECTOR (7 downto 0));
END deslocaSoma7;

ARCHITECTURE comportamento OF deslocaSoma7 IS 
SIGNAL negativo: std_logic_vector(7 downto 0);

BEGIN
	negativo <= '0' & E & "000";
	S <= negativo - E;
END comportamento;

------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY deslocaSomaN3 IS

PORT (E: IN STD_LOGIC_VECTOR (3 downto 0);
	   S: OUT STD_LOGIC_VECTOR (7 downto 0));
END deslocaSomaN3;

ARCHITECTURE comportamento OF deslocaSomaN3 IS 
SIGNAL negativo: std_logic_vector(7 downto 0);

BEGIN
	negativo <= "00" & E & "00";
	S <= E - negativo;
END comportamento;

------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY deslocaSomaN1 IS
PORT (E: IN STD_LOGIC_VECTOR (3 downto 0);
	   S: OUT STD_LOGIC_VECTOR (7 downto 0)   
	);
END deslocaSomaN1;

ARCHITECTURE comportamento OF deslocaSomaN1 IS 
SIGNAL negativo: std_logic_vector(7 downto 0);

BEGIN
	negativo <= "000" & E & '0';
	S <= E - negativo;
END comportamento;

--------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY deslocaSomaN7 IS

PORT (E: IN STD_LOGIC_VECTOR (3 downto 0);
		S: OUT STD_LOGIC_VECTOR (7 downto 0));
END deslocaSomaN7;

ARCHITECTURE comportamento OF deslocaSomaN7 IS 
SIGNAL negativo: std_logic_vector(7 downto 0);

BEGIN
	
	negativo <= '0' & E & "000";
	S <= E - negativo;
END comportamento;


LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY reg8b IS
PORT ( clk : IN STD_LOGIC;
		D : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		Q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END reg8b;

ARCHITECTURE comportamento OF reg8b IS
BEGIN
PROCESS (clk)
BEGIN
IF clk'EVENT AND clk = '1' THEN
Q <= D;
END IF;
END PROCESS;
END comportamento;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY reg4b IS
PORT ( clk : IN STD_LOGIC;
		D : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		Q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END reg4b;

ARCHITECTURE comportamento OF reg4b IS
BEGIN
PROCESS (clk)
BEGIN
IF clk'EVENT AND clk = '1' THEN
Q <= D;
END IF;
END PROCESS;
END comportamento;

----- File my_components.vhd: ---------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE my_components IS

COMPONENT somador8bits IS
PORT ( a, b : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
s : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END  COMPONENT;

COMPONENT deslocaSoma7 IS

PORT ( E: IN STD_LOGIC_VECTOR (3 downto 0);
	    S: OUT STD_LOGIC_VECTOR (7 downto 0)
	      
	);
END COMPONENT;

COMPONENT deslocaSomaN1 IS

PORT ( E: IN STD_LOGIC_VECTOR (3 downto 0);
	    S: OUT STD_LOGIC_VECTOR (7 downto 0)
	      
	);
END COMPONENT;

COMPONENT deslocaSomaN3 IS

PORT ( E: IN STD_LOGIC_VECTOR (3 downto 0);
	    S: OUT STD_LOGIC_VECTOR (7 downto 0)
	      
	);
END COMPONENT;

COMPONENT deslocaSomaN7 IS

PORT ( E: IN STD_LOGIC_VECTOR (3 downto 0);
	    S: OUT STD_LOGIC_VECTOR (7 downto 0)
	      
	);
END COMPONENT;

COMPONENT reg8b IS
PORT ( clk : IN STD_LOGIC;
D : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
Q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END COMPONENT;

COMPONENT reg4b IS
PORT ( clk : IN STD_LOGIC;
D : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
Q : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END COMPONENT;


END my_components;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components.all;

ENTITY Trabalho1PCICpipeline IS
	PORT (clk: IN STD_LOGIC;
	      X: IN STD_LOGIC_VECTOR (3 downto 0);
	      S: OUT STD_LOGIC_VECTOR (7 downto 0)
	   	);
END Trabalho1PCICpipeline;

ARCHITECTURE comportamento OF Trabalho1PCICpipeline	IS
SIGNAL RR00, RR01, RR02: STD_LOGIC_VECTOR (3 downto 0); 
SIGNAL RR03,RR04,RR05,RR06, RM00, RM01, RM02, RM03, RM04: STD_LOGIC_VECTOR (7 downto 0); 
SIGNAL RS00, RS01, RS02, RS03: STD_LOGIC_VECTOR (7 downto 0); 


BEGIN
	    
   stage_1: deslocaSoma7 port map (X, RM00);
	stage_2: reg4b port map (clk, X, RR00);
	stage_3: reg8b port map (clk, RM00, RR03);
	stage_4: deslocaSomaN3 port map (RR00, RM01);
	stage_5: reg8b port map (clk, RM01, RR04);
   stage_6: somador8bits port map (RR03, RR04, RS00);
    
    
   stage_7: reg4b port map (clk, RR00, RR01);
	stage_8: deslocaSomaN1 port map (RR01,RM02);
	stage_9: reg8b port map (clk, RM02, RR05);
   stage_10: somador8bits port map (RS00, RR05, RS01);
    
    
   stage_11: reg4b port map (clk, RR01, RR02);
   stage_12: deslocaSomaN7 port map (RR02, RM03);
	stage_13: reg8b port map (clk, RM03, RR06);
	stage_14: somador8bits port map (RS01, RR06, RS02);
    
S <= RS02;

END comportamento;