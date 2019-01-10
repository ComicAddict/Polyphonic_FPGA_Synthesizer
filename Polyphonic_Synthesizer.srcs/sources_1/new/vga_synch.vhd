library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity vga_synch is
  Port ( clock : in std_logic;
         clear : in std_logic;
         hsync : out std_logic;
         vsync : out std_logic;
         vidon : out std_logic;
         hc :  out std_logic_vector(10 downto 0);
         vc :  out std_logic_vector(10 downto 0));
end vga_synch;

architecture Behavioral of vga_synch is

constant hpixels : std_logic_vector (10 downto 0) := "11010011000"; --1688
constant vpixels : std_logic_vector (10 downto 0) := "10000101010"; --1066
constant hbp : std_logic_vector (10 downto 0) := "00101101000"; --360
constant vbp : std_logic_vector (10 downto 0) := "00000101001"; --41
constant hfp : std_logic_vector (10 downto 0) := "11001101000"; --1640
constant vfp : std_logic_vector (10 downto 0) := "10000101001"; --1065
signal hcs : std_logic_vector (10 downto 0);
signal vcs : std_logic_vector (10 downto 0);
signal vsenable : std_logic;

begin
process(clock, clear)
begin
    if clear = '1' then
        hcs <= "00000000000";
    elsif(clock'event and clock = '1') then
        if hcs = hpixels - 1 then
            hcs <= "00000000000";
            vsenable <= '1';
        else
            hcs <= hcs + 1;
            vsenable <= '0';
        end if;
     end if;
end process;

hsync <= '0' when hcs < 112 else '1';

process(clock, clear)
begin
    if clear = '1' then
        vcs <= "00000000000";
    elsif(clock'event and clock = '1' and vsenable = '1') then
        if vcs = vpixels - 1 then
            vcs <= "00000000000";
        else
            vcs <= vcs + 1;
        end if;
     end if;
end process;

vsync <= '0' when vcs < 3 else '1';

vidon <= '1' when (((hcs < hfp) and (hcs >= hbp)) and ((vcs < vfp) and (vcs >= vbp))) else '0';

hc <= hcs;
vc <= vcs;

end Behavioral;