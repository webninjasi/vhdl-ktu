Library IEEE, std;
Use IEEE.std_logic_1164.all;
Use IEEE.std_logic_unsigned.all;
Use IEEE.std_logic_arith.all;

Entity eRAM is
  Port(
    s, okuyaz: in std_logic;
    Addr: in std_logic_vector(4 downto 0);
    A: in std_logic_vector(7 downto 0);
    F: out std_logic_vector(7 downto 0)
  );
End Entity eRAM;

Architecture bhv of eRAM is
  Type RAMArray is array(0 to 31) of std_logic_vector(7 downto 0);
  signal RAMMem: RAMArray;
begin
  process (s, okuyaz) is
  begin
    if rising_edge(s) then
      if okuyaz='1' then
        RAMMem(conv_integer(Addr)) <= A;
      elsif okuyaz='0' then
        F <= RAMMem(conv_integer(Addr));
      else
        F <= "ZZZZZZZZ";
      end if;
    end if;
  end process;
End Architecture bhv;
