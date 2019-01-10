library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Wave_Summation is
Port (  CLK: in std_logic;
        Notes: in std_logic_vector(11 downto 0);
        Octaves: in std_logic_vector(2 downto 0);
        Modes: in std_logic_vector(4 downto 0);
        output: out std_logic
        );
end Wave_Summation;

architecture Behavioral of Wave_Summation is
    component Wave_Generator is
      Port (Trigger : in STD_LOGIC;
            Mode : in STD_LOGIC_VECTOR(2 downto 0); 
            Freq_Count : in STD_LOGIC_VECTOR (15 downto 0);
            Wave_Gen_Clock : in STD_LOGIC;
            Wave : out STD_LOGIC_VECTOR (9 downto 0));
    end component;
    
    -- For notes
    signal  WaveC, WaveCs, WaveD, WaveDs, WaveE, WaveF, WaveFs, WaveG, WaveGs, WaveA, WaveAs, WaveB : signed(9 downto 0);
    signal c, cs, d, ds, e, f, fs, g, gs, a, as, b, tmp : unsigned(15 downto 0);
    signal Mode : std_logic_vector(2 downto 0);
    
    -- For Wave Summation
    signal Wave_Sum : STD_LOGIC_VECTOR(9 downto 0); --signal for summed sine waves (2's compliment -512 to 511)
    signal Positive_Wave_Sum : STD_LOGIC_VECTOR(9 downto 0); --unsigned 0 to 1023, for use in PWM generator
    
    -- For PWM
    signal ping_length : unsigned (9 downto 0);
    signal PWM : unsigned (9 downto 0) := to_unsigned(0, 10);
    
begin
    
    NoteC   : Wave_Generator port map (  Trigger => Notes(0), Mode => Mode, Freq_Count => std_logic_vector(c), Wave_Gen_Clock => CLK, signed(Wave) => WaveC); 
    NoteCs  : Wave_Generator port map (  Trigger => Notes(1), Mode => Mode, Freq_Count => std_logic_vector(cs), Wave_Gen_Clock => CLK, signed(Wave) => WaveCs);
    NoteD   : Wave_Generator port map (  Trigger => Notes(2), Mode => Mode, Freq_Count => std_logic_vector(d), Wave_Gen_Clock => CLK, signed(Wave) => WaveD); 
    NoteDs  : Wave_Generator port map (  Trigger => Notes(3), Mode => Mode, Freq_Count => std_logic_vector(ds), Wave_Gen_Clock => CLK, signed(Wave) => WaveDs);
    NoteE   : Wave_Generator port map (  Trigger => Notes(4), Mode => Mode, Freq_Count => std_logic_vector(e), Wave_Gen_Clock => CLK, signed(Wave) => WaveE); 
    NoteF   : Wave_Generator port map (  Trigger => Notes(5), Mode => Mode, Freq_Count => std_logic_vector(f), Wave_Gen_Clock => CLK, signed(Wave) => WaveF); 
    NoteFs  : Wave_Generator port map (  Trigger => Notes(6), Mode => Mode, Freq_Count => std_logic_vector(fs), Wave_Gen_Clock => CLK, signed(Wave) => WaveFs);
    NoteG   : Wave_Generator port map (  Trigger => Notes(7), Mode => Mode, Freq_Count => std_logic_vector(g), Wave_Gen_Clock => CLK, signed(Wave) => WaveG); 
    NoteGs  : Wave_Generator port map (  Trigger => Notes(8), Mode => Mode, Freq_Count => std_logic_vector(gs), Wave_Gen_Clock => CLK, signed(Wave) => WaveGs);
    NoteA   : Wave_Generator port map (  Trigger => Notes(9), Mode => Mode, Freq_Count => std_logic_vector(a), Wave_Gen_Clock => CLK, signed(Wave) => WaveA); 
    NoteAs  : Wave_Generator port map (  Trigger => Notes(10), Mode => Mode, Freq_Count => std_logic_vector(as), Wave_Gen_Clock => CLK, signed(Wave) => WaveAs);
    NoteB   : Wave_Generator port map (  Trigger => Notes(11), Mode => Mode, Freq_Count => std_logic_vector(b), Wave_Gen_Clock => CLK, signed(Wave) => WaveB); 
  
    c <= "1011101010100110" srl to_integer(unsigned(Octaves));
    cs <= "1011000000100101" srl to_integer(unsigned(Octaves));
    d <= "1010011001000011" srl to_integer(unsigned(Octaves));
    ds <= "1001110011110001" srl to_integer(unsigned(Octaves));
    e <= "1001010000100100" srl to_integer(unsigned(Octaves));
    f <= "1000101111010100" srl to_integer(unsigned(Octaves));
    fs <= "1000001111110111" srl to_integer(unsigned(Octaves));
    g <= "0111110010010000" srl to_integer(unsigned(Octaves));
    gs <= "0111010110010100" srl to_integer(unsigned(Octaves));
    a <= "0110111011111001" srl to_integer(unsigned(Octaves));
    as <= "0110100010111110" srl to_integer(unsigned(Octaves));
    b <= "0110001011011011" srl to_integer(unsigned(Octaves));
    
    with Modes select Mode <=   
        "001" when "10000",
        "010" when "01000",
        "011" when "00100",
        "100" when "00010",
        "101" when "00001",
        "000" when others;
        
    Wave_Sum <= std_logic_vector((WaveC + WaveCs + WaveD + WaveDs + WaveE + WaveF + WaveFs + WaveG + WaveGs + WaveA + WaveAs + WaveB));
    
    Positive_Wave_Sum <= not Wave_Sum(9) & Wave_Sum(8 downto 0);
    
    process(CLK)
        begin
        if (rising_edge(CLK)) then
            if (PWM < ping_length) then
                output <= '1';
            else
                output <= '0';
            end if;
            PWM <= PWM + 1;
            ping_length <= unsigned(Positive_Wave_Sum);
        end if;
    end process;
end Behavioral;