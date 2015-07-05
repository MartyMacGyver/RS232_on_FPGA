library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity rs232_rx_demo is
   Port ( clk : in STD_LOGIC;
   tx : in STD_LOGIC;
   led : out STD_LOGIC_VECTOR (7 downto 0);
   led1 : out std_logic);
end rs232_rx_demo;
 
architecture RTL of rs232_rx_demo is
   COMPONENT rs232_rx
      GENERIC ( frequency : natural;
                baud : natural);
      PORT ( clk : IN std_logic;
             rx : IN std_logic;
             data : OUT std_logic_vector(7 downto 0);
             data_strobe : OUT std_logic;
			 led_brd : OUT std_logic);
   END COMPONENT;
begin
 
Inst_rs232_rx: rs232_rx 
   GENERIC MAP (frequency => 32000000, baud => 9600)
   PORT MAP(clk => clk, rx => tx, data => led, data_strobe => open,  led_brd => led1);
 
end RTL;

