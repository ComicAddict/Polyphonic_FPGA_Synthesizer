library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Top_Module is
  Port ( CLK: in std_logic;
         Notes : in STD_LOGIC_VECTOR(11 downto 0);
         Octaves : in STD_LOGIC_VECTOR(2 downto 0);
         Modes : in STD_LOGIC_VECTOR(4 DOWNTO 0);
         seven_segment_display : out std_logic_vector(10 downto 0);
         output : out std_logic;
         hsync : out std_logic;
         vsync : out std_logic;
         red : out std_logic_vector(3 downto 0);
         green : out std_logic_vector(3 downto 0);
         blue : out std_logic_vector(3 downto 0));
end Top_Module;

architecture Behavioral of Top_Module is
    component Wave_Summation is
    Port (  CLK: in std_logic;
            Notes: in std_logic_vector(11 downto 0);
            Octaves: in std_logic_vector(2 downto 0);
            Modes : in std_logic_vector(4 downto 0);
            output: out std_logic);
    end component;
    
    component Segment_Driver is
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
    end component;
    
    component vga_controller is
        Port (  clk : in std_logic;
                notes: in std_logic_vector(11 downto 0);
                octaves : in std_logic_vector(2 downto 0);
                hsync : out std_logic;
                vsync : out std_logic;
                red : out std_logic_vector(3 downto 0);
                green : out std_logic_vector(3 downto 0);
                blue : out std_logic_vector(3 downto 0));
    end component;
    
    component clk_wiz_0 is
        Port ( clk_out1 : out std_logic;
               reset : in std_logic;
               locked : out std_logic;
               clk_in1 : in std_logic);
    end component;
    
    signal seven_seg_oct : std_logic_vector(4 downto 0);
    signal koutput : std_logic_vector(10 downto 0);
    signal seven_seg_input : std_logic_vector(19 downto 0);
    signal clk108Mhz : std_logic;
    signal locked : std_logic;
    
begin
    
    uut1 : wave_summation port map(
        CLK => CLK, 
        Notes => Notes, 
        Octaves => Octaves, 
        Modes => Modes, 
        output => output
    );
    
    uut2 : segment_driver port map(
        displayA => std_logic_vector(seven_seg_input(19 downto 15)),
        displayB => std_logic_vector(seven_seg_input(14 downto 10)),
        displayC => std_logic_vector(seven_seg_input(9 downto 5)),
        displayD => std_logic_vector(seven_seg_input(4 downto 0)),
        clock => CLK,
        segA =>  seven_segment_display(0),
        segB =>  seven_segment_display(1),
        segC =>  seven_segment_display(2),
        segD =>  seven_segment_display(3),
        segE =>  seven_segment_display(4),
        segF =>  seven_segment_display(5),
        segG =>  seven_segment_display(6),
        selectDisplayA =>  seven_segment_display(7),
        selectDisplayB =>  seven_segment_display(8),
        selectDisplayC =>  seven_segment_display(9),
        selectDisplayD =>  seven_segment_display(10)
    );
    
    uut3 : vga_controller Port Map(
        clk => CLK108Mhz,
        notes => Notes,
        octaves => Octaves,
        hsync => hsync,
        vsync => vsync,
        red => red,
        green => green,
        blue => blue
    );
    
    uut4 : clk_wiz_0 Port Map(
        clk_out1 => clk108Mhz,
        reset => '0',
        locked => locked,
        clk_in1 => clk 
    );
    
    with Octaves  select seven_seg_oct <=
        "00111" when "000",
        "01000" when "001",
        "01001" when "010",
        "01010" when "011",
        "01011" when "100",
        "01100" when "101",
        "01101" when "110",
        "01110" when "111",
        "11111" when others;
    
    with Notes select seven_seg_input <=
        seven_seg_oct & "10000" & "00010" & "11111" when "000000000001",
        seven_seg_oct & "01111" & "00010" & "11111" when "000000000010",
        seven_seg_oct & "10000" & "00011" & "11111" when "000000000100",
        seven_seg_oct & "01111" & "00011" & "11111" when "000000001000",
        seven_seg_oct & "10000" & "00100" & "11111" when "000000010000",
        seven_seg_oct & "10000" & "00101" & "11111" when "000000100000",
        seven_seg_oct & "01111" & "00101" & "11111" when "000001000000",
        seven_seg_oct & "10000" & "00110" & "11111" when "000010000000",
        seven_seg_oct & "01111" & "00110" & "11111" when "000100000000",
        seven_seg_oct & "10000" & "00000" & "11111" when "001000000000",
        seven_seg_oct & "01111" & "00000" & "11111" when "010000000000",
        seven_seg_oct & "10000" & "00001" & "11111" when "100000000000",
        seven_seg_oct & "111111111111111" when others;
              
end Behavioral;
