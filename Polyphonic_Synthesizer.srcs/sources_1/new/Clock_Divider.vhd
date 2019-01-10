library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Clock_Divider is
    Port ( clock : in STD_LOGIC;
           enable : in STD_LOGIC;
           reset : in STD_LOGIC;
           dataClock : out STD_LOGIC_VECTOR (15 downto 0));
end Clock_Divider;

architecture Behavioral of Clock_Divider is

begin 

    process(clock, reset, enable)
    variable counter : std_logic_vector (15 downto 0):=(others =>'0');
    begin
        if reset = '1' then 
            counter := (others => '0');
        elsif enable = '1' and clock' event and clock = '1' then
            counter := counter + 1;
        end if;
    
    dataClock <= counter;
    
    end process;     
end Behavioral;