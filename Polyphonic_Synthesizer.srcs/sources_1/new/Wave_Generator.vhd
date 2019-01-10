library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Wave_Generator is
    Port ( Trigger : in STD_LOGIC;
           Mode : in STD_LOGIC_VECTOR(2 downto 0); 
           Freq_Count : in STD_LOGIC_VECTOR (15 downto 0);
           Wave_Gen_Clock : in STD_LOGIC;
           Wave : out STD_LOGIC_VECTOR (9 downto 0));
end Wave_Generator;

architecture Behavioral of Wave_Generator is

    signal index : integer range 0 to 64 := 0;
    type wave_memory is array (0 to 63) of integer range -63 to 64;
    signal amplitudeSin : wave_memory := (  0, 7, 13, 19, 25, 30, 35, 40, 45, 49, 52, 55, 58, 60, 62, 63, 
                                            63, 63, 62, 60, 58, 55, 52, 49, 45, 40, 35, 30, 25, 19, 13, 7, 
                                            0, -7,-13,-19,-25,-30,-35,-40,-45,-49,-52,-55,-58,-60,-62,-63,  
                                            -63,-63,-62,-60,-58,-55,-52,-49,-45,-40,-35,-30,-25,-19,-13,-7);
    signal amplitudeSaw : wave_memory := (  64, 62, 60, 58, 56, 54, 52, 50, 48, 46, 44, 42, 40, 38, 36, 34, 
                                            32, 30, 28, 26, 24, 22, 20, 18, 16, 14, 12, 10, 8, 6, 4, 2, 
                                            0, -2, -4, -6, -8, -10, -12, -14, -16, -18, -20, -22, -24, -26, -28, -30, 
                                            -32, -34, -36, -38, -40, -42, -44, -46, -48, -50, -52, -54, -56, -58, -60, -62);   
    signal amplitudeTri : wave_memory := (  0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 
                                            64, 60, 56, 52, 48, 44, 40, 36, 32, 28, 24, 20, 16, 12, 8, 4, 
                                            0, -4,-8,-12,-16,-20,-24,-28,-32,-36,-40,-44,-48,-52,-56,-60,  
                                            -63,-60,-56,-52,-48,-44,-40,-36,-32,-28,-24,-20,-16,-12,-8,-4);
    signal amplitudeViolin : wave_memory := (   -58, -55, -51,  -48, -45, -43, -41, -41, -41, -42,-43, -44,  -44,  -44, -42, -39,
                                                -34, -27, -19, -10,0,  11, 22,  32, 41, 49, 56, 60, 63, 64,63, 61,
                                                58, 55, 51, 48, 45, 43, 41, 41,41, 42, 43, 44,  44, 44, 42,  39,
                                                34, 27,  19,  10,  0,  -11, -22, -32, -41,  -49, -58, -62,-63, -63,-62,  -60);
    signal amplitudeSax : wave_memory := (60,  57,  52,  48,  42,  36,  28,  21,  10,   2,  -7, -19, -27, -30, -32, -33,
                                          -33, -31, -27, -21, -15,  -6,   5,  10,  16,  25,  28,  29,  29,  26,  23,  17,
                                           12,   5,  -2,  -9, -17, -26, -33, -42, -48, -53, -57, -61, -62, -63, -62, -61,
                                          -58, -50, -42, -34, -25, -17, -10,   5,  14,  21,  31,  42,  46,  54,  58, 60);
    signal amplitudeFlute : wave_memory := (-62, -61, -56, -48, -40, -32, -23, -14,  -5,   4,  12,  20,  27,  32,  38,  42,
                                            44,  40,  34,  26,  17,  10,   6,   5,   5,   6,   8,  12,  18,  22,  28,  33,
                                            39,  44,  49,  54,  58,  60,  62,  62,  60,  55,  50,  42,  32,  21,  13,   8,
                                             4,   2,   0,  -1,  -1,  -1,  -1,   0,   1,   2,   2,   1,  -2, -35, -51, -62);
                                             
begin

    process(Wave_Gen_Clock, Trigger)
        variable counter : unsigned(15 downto 0) := to_unsigned(0, 16);
        
    begin
        if rising_edge(Wave_Gen_Clock) then
            if Trigger = '1' then
                counter := counter + 1;
                if counter = unsigned(Freq_Count) then
                    counter := to_unsigned(0, 16);
                    if Mode = "000" then
                        Wave <= std_logic_vector(to_signed(amplitudeSin(index), 10));
                    elsif Mode = "001" then
                        Wave <= std_logic_vector(to_signed(amplitudeSaw(index), 10));
                    elsif Mode = "010" then
                        Wave <= std_logic_vector(to_signed(amplitudeTri(index), 10));
                    elsif Mode = "011" then
                        Wave <= std_logic_vector(to_signed(amplitudeViolin(index), 10));
                    elsif Mode = "100" then
                        Wave <= std_logic_vector(to_signed(amplitudeSax(index), 10));
                    elsif Mode = "101" then
                        Wave <= std_logic_vector(to_signed(amplitudeFlute(index), 10));
                    end if;
                    index <= index + 1;                    
                    if index = 63 then
                        index <= 0;
                    end if;
                end if;
            else
                Wave <= "0000000000";
                index <= 0;
                counter := to_unsigned(0, 16);
            end if;
        end if;
    end process;
end Behavioral;