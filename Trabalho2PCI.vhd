LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY somador16bits IS
PORT ( a, b : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
       s : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END somador16bits;

ARCHITECTURE dataflow OF somador16bits IS

BEGIN 

s <= a + b;

END dataflow;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY mult8bits IS
PORT ( a, b : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
       s : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END mult8bits;

ARCHITECTURE dataflow1 OF mult8bits IS

BEGIN 

s <= a * b;

END dataflow1;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY reg16b IS
PORT ( clk : IN STD_LOGIC;
		D : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		Q : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END reg16b;

ARCHITECTURE comportamento OF reg16b IS
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

ENTITY mux4para2 IS
PORT ( sel: IN STD_LOGIC_VECTOR (1 downto 0);
       a, b, c, d: IN STD_LOGIC_VECTOR (7 downto 0);
       Y : OUT STD_LOGIC_VECTOR (7 downto 0)
       );
END mux4para2;

ARCHITECTURE dataflow OF mux4para2 IS
BEGIN
PROCESS (sel) -- lista de sensibiliza��o
BEGIN
CASE sel IS
WHEN "00" => Y <= a;
WHEN "01" => Y <= b;
WHEN "10" => Y <= c;
WHEN "11" => Y <= d;
END CASE;
END PROCESS;
END dataflow;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY regdes8b IS
PORT ( clk, ld : IN STD_LOGIC;
D : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
Q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END regdes8b;

ARCHITECTURE comportamento OF regdes8b IS
BEGIN
PROCESS (ld, clk)
BEGIN

IF clk'EVENT AND clk = '1' THEN

  IF ld = '1' THEN

Q <= D;

 END IF;

END IF;

END PROCESS;

END comportamento;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY rom IS
GENERIC ( bits: INTEGER := 8; -- # of bits per word
          words: INTEGER := 4); -- # of words in the memory
PORT ( addr: IN INTEGER RANGE 0 TO words-1;
       data: OUT STD_LOGIC_VECTOR (bits-1 DOWNTO 0));
END rom;

ARCHITECTURE rom OF rom IS
 TYPE vector_array IS ARRAY (0 TO words-1) OF
 STD_LOGIC_VECTOR (bits-1 DOWNTO 0);
CONSTANT memory: vector_array := (  "00000001",
												"00000010",
												"00000100",
												"00001000");
BEGIN
  data <= memory(addr);

END rom;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY rom1 IS
GENERIC ( bits: INTEGER := 8; -- # of bits per word
          words: INTEGER := 4); -- # of words in the memory
PORT ( addr: IN INTEGER RANGE 0 TO words-1;
       data: OUT STD_LOGIC_VECTOR (bits-1 DOWNTO 0));
END rom1;

ARCHITECTURE rom1 OF rom1 IS
 TYPE vector_array IS ARRAY (0 TO words-1) OF
 STD_LOGIC_VECTOR (bits-1 DOWNTO 0);
CONSTANT memory: vector_array := (  "00010000",
												"00100000",
												"01000000",
												"10000000");
BEGIN
  data <= memory(addr);

END rom1;

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mef IS
PORT (clk,clr: IN STD_LOGIC;
      ld: OUT STD_LOGIC;
      C: OUT STD_LOGIC_VECTOR (1 downto 0); -- selecao
      app: OUT INTEGER RANGE 0 TO 3 -- Apontador
      );
END mef;

ARCHITECTURE Behave OF mef IS
TYPE estados is (n0, n1, n2, n3);
SIGNAL estado:estados;

BEGIN

PROCESS(clk,clr)
BEGIN

IF clr ='0'then
estado <= n0;

ELSE
IF (clk 'EVENT AND clk = '1') then

CASE estado is
  WHEN n0 =>
       estado<=n1;
       ld <= '1';
       C<= ("00");
       app <= 0;
  WHEN n1 =>
       estado<=n2;
       ld <= '0';
       C<= ("01");
       app <= 1;
  WHEN n2 =>
       estado<=n3;
       ld <= '0';
       C<= ("10");
       app <= 2;
  WHEN n3 =>
       estado<=n0;
       ld <= '0';
       C<= ("11");
       app <= 3;

END CASE;
END IF;
END IF;
END PROCESS;
END Behave;


----- File my_components.vhd: ---------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;

PACKAGE my_components IS

COMPONENT somador16bits IS
PORT ( a, b : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
s : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END  COMPONENT;

COMPONENT mult8bits IS
PORT ( a, b : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
       s : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END COMPONENT;

COMPONENT reg16b IS
PORT ( clk : IN STD_LOGIC;
D : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
Q : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END COMPONENT;

COMPONENT mux4para2 IS
PORT ( sel: IN STD_LOGIC_VECTOR (1 downto 0);
       a, b, c, d : IN STD_LOGIC_VECTOR (7 downto 0);
       Y : OUT STD_LOGIC_VECTOR (7 downto 0)
       );
END COMPONENT;

COMPONENT regdes8b IS
PORT ( clk, ld : IN STD_LOGIC;
D : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
Q : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END COMPONENT;

COMPONENT rom IS
 GENERIC ( bits: INTEGER := 8; -- # of bits per word
 words: INTEGER := 4); -- # of words in the memory
 PORT ( addr: IN INTEGER RANGE 0 TO words-1;
 data: OUT STD_LOGIC_VECTOR (bits-1 DOWNTO 0));
END COMPONENT;

COMPONENT rom1 IS
 GENERIC ( bits: INTEGER := 8; -- # of bits per word
 words: INTEGER := 4); -- # of words in the memory
 PORT ( addr: IN INTEGER RANGE 0 TO words-1;
 data: OUT STD_LOGIC_VECTOR (bits-1 DOWNTO 0));
END COMPONENT;

COMPONENT mef IS
PORT (clk, clr: IN STD_LOGIC;
      ld: OUT STD_LOGIC;
      C: OUT STD_LOGIC_VECTOR (1 downto 0);
      app: OUT INTEGER RANGE 0 TO 3
      );
END COMPONENT;

END my_components;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components.all;

ENTITY registradordeslocamento IS
	PORT (clk, load: IN STD_LOGIC;
	     X: STD_LOGIC_VECTOR (7 downto 0);
		  Sa, Sb, Sc, Sd, Se, Sf, Sg, Sh: OUT STD_LOGIC_VECTOR (7 downto 0) 
	);
END registradordeslocamento;

ARCHITECTURE comportamento OF registradordeslocamento IS


SIGNAL Ta, Tb, Tc, Td, Te, Tf, Tg: STD_LOGIC_VECTOR (7 downto 0);   

BEGIN

	stage_0: regdes8b port map (clk, load, X, Ta);
	stage_1: regdes8b port map (clk, load, Ta, Tb);
	stage_2: regdes8b port map (clk, load, Tb, Tc);
	stage_3: regdes8b port map (clk, load, Tc, Td);
	stage_4: regdes8b port map (clk, load, Td, Te);
	stage_5: regdes8b port map (clk, load, Te, Tf);
	stage_6: regdes8b port map (clk, load, Tf, Tg);
	stage_7: regdes8b port map (clk, load, Tg, Sh);

Sa <= Ta;
Sb <= Tb;
Sc <= Tc;
Sd <= Td;
Se <= Te;
Sf <= Tf;
Sg <= Tg;

END comportamento;


----- File my_components.vhd: ---------------
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 PACKAGE my_components1 IS

COMPONENT registradordeslocamento IS
	PORT (clk, load: IN STD_LOGIC;
	      X: STD_LOGIC_VECTOR (7 downto 0);
		  Sa, Sb, Sc, Sd, Se, Sf, Sg, Sh: OUT STD_LOGIC_VECTOR (7 downto 0) 
	);
END COMPONENT;

end my_components1;


LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.my_components.all;
USE work.my_components1.all;

ENTITY Trabalho2PCI IS
	PORT (clk, limpa: IN STD_LOGIC;
	      X: IN STD_LOGIC_VECTOR (7 downto 0);
	      S: OUT STD_LOGIC_VECTOR (15 downto 0);
	      S1: OUT STD_LOGIC 
	);
END Trabalho2PCI;

ARCHITECTURE comportamento OF Trabalho2PCI IS

SIGNAL RP00, RP01, RP02, RP08, RP09: STD_LOGIC_VECTOR (15 downto 0); 
SIGNAL RP03, RP04, RP06, RP07, A, B, C, D ,E, F, G, H: STD_LOGIC_VECTOR (7 downto 0); 
SIGNAL apontador: INTEGER RANGE 0 TO 3;
SIGNAL selecao: STD_LOGIC_VECTOR (1 downto 0);
SIGNAL carga: STD_LOGIC;

BEGIN
	stage_0: registradordeslocamento port map (clk, carga, X, A, B, C, D, E, F, G, H);
   
	stage_1: mux4para2 port map (selecao, A, B, C, D,RP04);
	stage_2: mux4para2 port map (selecao, E, F, G, H,RP06);
	
	stage_3: rom port map (apontador, RP03);
	stage_4: rom1 port map (apontador, RP07);
    
	stage_5: mult8bits port map (RP04, RP03, RP00);
	stage_6: mult8bits port map (RP06, RP07, RP08);
	
	stage_7: somador16bits port map (RP00, RP08, RP09);
	stage_8: somador16bits port map (RP09, RP01, RP02);
	
	stage_9: reg16b port map (clk, RP02, RP01);
	stage_10: mef port map (clk, limpa, carga, selecao, apontador);
    
S1 <= carga;

S <= RP02;

END comportamento;
