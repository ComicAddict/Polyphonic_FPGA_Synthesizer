library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity Wave_Summation_tb is
end;

architecture bench of Wave_Summation_tb is

  component Wave_Summation
  Port (  CLK: in std_logic;
          Notes: in std_logic_vector(11 downto 0);
          Octaves: in std_logic_vector(2 downto 0);
          Modes: in std_logic_vector(4 downto 0);
          output: out std_logic
          );
  end component;

  signal CLK: std_logic;
  signal Notes: std_logic_vector(11 downto 0);
  signal Octaves: std_logic_vector(2 downto 0);
  signal Modes: std_logic_vector(4 downto 0);
  signal output: std_logic ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: Wave_Summation port map ( CLK     => CLK,
                                 Notes   => Notes,
                                 Octaves => Octaves,
                                 Modes   => Modes,
                                 output  => output );

  stimulus: process
  begin
  
    -- Put initialisation code here
    Notes <= "000000000000"; -- no notes
    Octaves <= "000"; -- octave 1
    Modes <= "00000"; -- mode sine

    wait for 5ns;
    -- Put test bench stimulus code here

    Notes <= "100000000000"; -- c3
    Octaves <= "010"; -- octave 3
    Modes <= "00000"; -- mode sine

    wait for 7.4ms;
    
    Notes <= "000000000001"; -- b3
    Octaves <= "011"; -- octave 3
    Modes <= "00000"; -- mode sine

    wait for 4.1ms;
        
    Notes <= "100000000000"; -- c4
    Octaves <= "011"; -- octave 4
    Modes <= "01000"; -- mode tri

    wait for 3.9ms;
    
    Notes <= "100000000100"; -- c5 and a5
    Octaves <= "100"; -- octave 5
    Modes <= "00000"; -- mode sine

    wait for 2ms;
    
    Notes <= "000000000000"; -- no notes
    Octaves <= "000"; -- octave 1
    Modes <= "00000"; -- mode sine   
     
    stop_the_clock <= false;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      CLK <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;