library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity vga_controller is
    Port (  clk : in std_logic;
            notes: in std_logic_vector(11 downto 0);
            octaves : in std_logic_vector(2 downto 0);
            hsync : out std_logic;
            vsync : out std_logic;
            red : out std_logic_vector(3 downto 0);
            green : out std_logic_vector(3 downto 0);
            blue : out std_logic_vector(3 downto 0));
end vga_controller;

architecture Behavioral of vga_controller is
    component vga_synch is
        Port (clock : in std_logic;
              clear : in std_logic;
              hsync : out std_logic;
              vsync : out std_logic;
              vidon : out std_logic;
              hc :  out std_logic_vector(10 downto 0);
              vc :  out std_logic_vector(10 downto 0));
     end component;
     
     component vga_draw is
        Port (vidon : in std_logic;
              clk : in std_logic;
              notes : in std_logic_vector(11 downto 0);
              octaves : in std_logic_vector(2 downto 0);
              hc :  in std_logic_vector(10 downto 0);
              vc :  in std_logic_vector(10 downto 0);
              red :  out std_logic_vector(3 downto 0);
              blue :  out std_logic_vector(3 downto 0);
              green :  out std_logic_vector(3 downto 0));
     end component;
     
 signal vidon : std_logic;
 signal clr : std_logic;
 signal hc : std_logic_vector(10 downto 0);
 signal vc : std_logic_vector(10 downto 0);
 
begin

    uut1 : vga_synch Port Map(clk, clr, hsync, vsync, vidon, hc, vc);
    uut2 : vga_draw port map(vidon, clk, notes, octaves, hc, vc, red, green, blue);


end Behavioral;
