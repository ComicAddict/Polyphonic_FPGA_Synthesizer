library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Wave_Generator_tb is
end;

architecture bench of Wave_Generator_tb is

  component Wave_Generator
      Port ( Trigger : in STD_LOGIC;
             Mode : in STD_LOGIC_VECTOR(2 downto 0); 
             Freq_Count : in STD_LOGIC_VECTOR (15 downto 0);
             Wave_Gen_Clock : in STD_LOGIC;
             Wave : out STD_LOGIC_VECTOR (9 downto 0));
  end component;

  signal Trigger: STD_LOGIC;
  signal Mode: STD_LOGIC_VECTOR(2 downto 0);
  signal Freq_Count: STD_LOGIC_VECTOR (15 downto 0);
  signal Wave_Gen_Clock: STD_LOGIC;
  signal Wave: STD_LOGIC_VECTOR (9 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: Wave_Generator port map ( Trigger        => Trigger,
                                 Mode           => Mode,
                                 Freq_Count     => Freq_Count,
                                 Wave_Gen_Clock => Wave_Gen_Clock,
                                 Wave           => Wave );

  stimulus: process
  begin
  
    -- Put initialisation code here
    Trigger <= '0';
    Mode <= "000"; -- Sine
    Freq_Count <= "0010111010101001"; --c3
    
    wait for 5ns;
    
    -- Put test bench stimulus code here
    Trigger <= '1';
    Mode <= "000"; -- Sine
    Freq_Count <= "0010111010101001"; --c3
        
    wait for 7.7ms; -- 1/frequency of c3
        
    Trigger <= '1';
    Mode <= "010"; -- Triangle
    Freq_Count <= "0010111010101001"; --c3
    
    wait for 7.7ms; -- 1/frequency of c3
            
    Trigger <= '1';
    Mode <= "001"; -- Sawtooth
    Freq_Count <= "0001011101010100"; --c4
    
    wait for 3.9ms; -- 1/frequency of c4
    
    Trigger <= '0';
    Mode <= "001"; -- Sawtooth
    Freq_Count <= "0001011101010100"; --c4
    
    stop_the_clock <= false;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      Wave_Gen_Clock <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;