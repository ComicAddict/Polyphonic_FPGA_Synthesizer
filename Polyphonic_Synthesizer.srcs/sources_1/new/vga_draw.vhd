library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity vga_draw is
  Port (vidon : in std_logic;
        clk : in std_logic;
        notes : in std_logic_vector(11 downto 0);
        octaves : in std_logic_vector(2 downto 0);
        hc :  in std_logic_vector(10 downto 0);
        vc :  in std_logic_vector(10 downto 0);
        red :  out std_logic_vector(3 downto 0);
        blue :  out std_logic_vector(3 downto 0);
        green :  out std_logic_vector(3 downto 0));
end vga_draw;

architecture Behavioral of vga_draw is
constant width: integer := 23;
constant height: integer := 256;
constant line_interval : integer := 19;
constant line_number : integer := 8;
constant line_thickness : integer := 1;
constant hbp : integer := 248;
constant hfp : integer := 48;
constant hsp : integer := 112;  
constant vbp : integer := 38;
constant vfp : integer := 1;
constant vsp : integer := 3;

begin

process(vidon, hc, vc, notes, octaves)
begin
    red <= "0000";
    blue <= "0000";
    green <= "0000";
    
    if vidon = '1' then  
        for i in 0 to 55 loop
            if (i mod 7 = 0 or i mod 7 = 1 or i mod 7 = 3 or i mod 7 = 4 or i mod 7 = 5) and hc - hbp - hsp < (i + 1) * width + line_number and hc - hbp - hsp > (i + 1) * width - line_number and (vc - vsp - vbp) < 512 and (vc - vsp - vbp)  > 256 then
                if ((notes((i - 7 * to_integer(unsigned(octaves))) * 2 + 1) = '1' and i mod 7 < 2 ) or (notes((i - 7 * to_integer(unsigned(octaves))) * 2) = '1' and i mod 7 > 2)) and  i / 7 = to_integer(unsigned(octaves)) then
                    red <= "1100";  
                    blue <= "0000";
                    green <= "0000";
                else
                    red <= "0000";
                    blue <= "0000";
                    green <= "0000";
                end if;
            elsif (hc - hbp - hsp) < (i + 1) * width - line_thickness and (hc - hbp - hsp) > i * width and (vc - vsp - vbp) < 768 and (vc - vsp - vbp)  > 256 then
                if ((notes((i - 7 * to_integer(unsigned(octaves))) * 2) = '1' and i mod 7 < 3) or (notes((i - 7 * to_integer(unsigned(octaves))) * 2 - 1) = '1' and i mod 7 > 2)) and i / 7 = to_integer(unsigned(octaves)) then
                    red <= "1100";  
                    blue <= "0000";
                    green <= "0000";
                else
                    red <= "1111";
                    blue <= "1111";
                    green <= "1111";
                end if;
            end if;
        end loop;
    end if;
end process; 
end Behavioral;