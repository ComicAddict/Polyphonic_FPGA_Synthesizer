library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Segment_Driver is
    Port ( displayA : in STD_LOGIC_VECTOR (4 downto 0);
           displayB : in STD_LOGIC_VECTOR (4 downto 0);
           displayC : in STD_LOGIC_VECTOR (4 downto 0);
           displayD : in STD_LOGIC_VECTOR (4 downto 0);
           clock : in STD_LOGIC;
           segA : out STD_LOGIC;
           segB : out STD_LOGIC;
           segC : out STD_LOGIC;
           segD : out STD_LOGIC;
           segE : out STD_LOGIC;
           segF : out STD_LOGIC;
           segG : out STD_LOGIC;
           selectDisplayA : out STD_LOGIC;
           selectDisplayB : out STD_LOGIC;
           selectDisplayC : out STD_LOGIC;
           selectDisplayD : out STD_LOGIC);
end Segment_Driver;

architecture Behavioral of Segment_Driver is
    component Segment_Decoder
        Port ( Input : in STD_LOGIC_VECTOR (4 downto 0);
               segment_A : out STD_LOGIC;
               segment_B : out STD_LOGIC;
               segment_C : out STD_LOGIC;
               segment_D : out STD_LOGIC;
               segment_E : out STD_LOGIC;
               segment_F : out STD_LOGIC;
               segment_G : out STD_LOGIC);
    end component;
    
    component Clock_Divider
        Port ( clock : in STD_LOGIC;
               enable : in STD_LOGIC;
               reset : in STD_LOGIC;
               dataClock : out STD_LOGIC_VECTOR (15 downto 0));
    end component;
    
    Signal temporaryData : std_logic_vector (4 downto 0);
    Signal clockWord : std_logic_vector (15 downto 0);
    Signal slowClock : std_logic;
begin

    uut: Segment_Decoder PORT MAP(
        Input => temporaryData,
        segment_A => segA,
        segment_B => segB,
        segment_C => segC,
        segment_D => segD,
        segment_E => segE,
        segment_F => segF,
        segment_G => segG
    );
    
    uut1: Clock_Divider PORT MAP(
        clock => clock,
        enable => '1',
        reset => '0',
        dataClock => clockWord
    );
    
slowClock <= clockWord(15);

process(slowClock)
    variable displaySelection : std_logic_vector(1 downto 0);
    begin
    if slowClock'event and slowClock = '1' then
        case displaySelection is 
            when "00" => temporaryData <= displayA;
                selectDisplayA <= '0';
                selectDisplayB <= '1';
                selectDisplayC <= '1';
                selectDisplayD <= '1';  
                displaySelection := displaySelection + 1;
            when "01" => temporaryData <= displayB;
                selectDisplayA <= '1';
                selectDisplayB <= '0';
                selectDisplayC <= '1';
                selectDisplayD <= '1';  
                displaySelection := displaySelection + 1;
            when "10" => temporaryData <= displayC;
                selectDisplayA <= '1';
                selectDisplayB <= '1';
                selectDisplayC <= '0';
                selectDisplayD <= '1';  
                displaySelection := displaySelection + 1;
            when others => temporaryData <= displayD;
                selectDisplayA <= '1';
                selectDisplayB <= '1';
                selectDisplayC <= '1';
                selectDisplayD <= '0';  
                displaySelection := displaySelection + 1;
        end case;
    end if;
end process;
end Behavioral;
