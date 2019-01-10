library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Segment_Decoder is
    Port ( Input : in std_logic_vector(4 downto 0);
           segment_A : out STD_LOGIC;
           segment_B : out STD_LOGIC;
           segment_C : out STD_LOGIC;
           segment_D : out STD_LOGIC;
           segment_E : out STD_LOGIC;
           segment_F : out STD_LOGIC;
           segment_G : out STD_LOGIC);
end Segment_Decoder;

architecture Behavioral of Segment_Decoder is
signal decodedData : std_logic_vector (6 downto 0);
begin 
    
    with Input select decodedData <=
        "1111101" when "00000", -- a
        "0011111" when "00001", -- b
        "0001101" when "00010", -- c
        "0111101" when "00011", -- d
        "1001111" when "00100", -- e
        "1000111" when "00101", -- f
        "1111011" when "00110", -- g
        "0110000" when "00111", -- 1
        "1101101" when "01000", -- 2
        "1111001" when "01001", -- 3
        "0110011" when "01010", -- 4
        "1011011" when "01011", -- 5
        "1011111" when "01100", -- 6
        "1110000" when "01101", -- 7
        "1111111" when "01110", -- 8
        "0110111" when "01111",
        "0000000" when others;
            
    segment_A <= not decodedData(6);
    segment_B <= not decodedData(5);
    segment_C <= not decodedData(4);
    segment_D <= not decodedData(3);
    segment_E <= not decodedData(2);
    segment_F <= not decodedData(1);
    segment_G <= not decodedData(0);
    
end Behavioral;