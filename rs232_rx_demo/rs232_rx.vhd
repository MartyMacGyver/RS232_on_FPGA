library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
 
entity rs232_rx is
    GENERIC (
        frequency : natural;
        baud : natural );
    PORT (
        clk : in STD_LOGIC;
        rx : in STD_LOGIC;
        data : out STD_LOGIC_VECTOR (7 downto 0);
        data_strobe : out STD_LOGIC;  -- For sim only?
        led_brd: out STD_LOGIC );
end rs232_rx;
 
architecture RTL of rs232_rx is
    signal oversampled_bits : std_logic_vector(39 downto 0);
    signal baud_x4 : unsigned(11 downto 0) := (others => '0');
    signal led_state: Std_logic := '0';
begin
 
process(clk, led_state)
    begin
        if rising_edge(clk) then
            data_strobe <= '0';

            if baud_x4 = 0 then
                if led_state = '1' then
                    led_state <= '0';
                else
                    led_state <= '1';
                end if;
                led_brd <= led_state; 

                -- Process a frame if detected
                if oversampled_bits(39 downto 37) = "000" then
                    -- If a start bit is seen then capture the data and reset the shift registers
                    data_strobe <= '1';
                    data(0) <= oversampled_bits(34);
                    data(1) <= oversampled_bits(30);
                    data(2) <= oversampled_bits(26);
                    data(3) <= oversampled_bits(22);
                    data(4) <= oversampled_bits(18);
                    data(5) <= oversampled_bits(14);
                    data(6) <= oversampled_bits(10);
                    data(7) <= oversampled_bits( 6);
                    -- stop <= oversampled_bits( 2);
                    oversampled_bits(39 downto 0) <= (0 => rx, others => '1');
                else
                    -- Capture another bit and concatenate it to the end of the shift register
                    oversampled_bits <= oversampled_bits(38 downto 0) & rx;
                end if;
            end if;

            -- process the interval counter
            if baud_x4 = frequency / (baud*4) - 1 then
                baud_x4 <= (others => '0');
            else
                baud_x4 <= baud_x4+1;
            end if;
        end if;
    end process;
end RTL;

