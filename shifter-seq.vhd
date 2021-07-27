Library IEEE;
Use IEEE.std_logic_1164.all;

Entity eShifter is
  Generic(n: natural := 8);
  Port(
    A: in std_logic_vector(n-1 downto 0);
    --DEAFULT VALUE EXAMPLE: a: in std_logic_vector(n-1 downto 0) := (others=>'0');
    left, right, load, s: in std_logic;
    F: out std_logic_vector(n-1 downto 0)
  );
End eShifter;

Architecture Bhv of eShifter is
  signal Y : std_logic_vector(n-1 downto 0);
  procedure addZeroL(A1: in std_logic_vector(n-2 downto 0);
                    signal F1: out std_logic_vector(n-1 downto 0)) is
  begin
    F1 <= '0' & A1;
  end procedure;
  
  procedure addZeroR(A1: in std_logic_vector(n-2 downto 0);
                    signal F1: out std_logic_vector(n-1 downto 0)) is
  begin
    F1 <= A1 & '0'; -- & ulama/ekleme
  end procedure;
  
  function getlessbit(A1: std_logic_vector(n-1 downto 0);
                      left: std_logic)
    return std_logic_vector is
  begin
    if left='1' then
      return A1(n-2 downto 0);
    else
      return A1(n-1 downto 1);
    end if;
  end;
Begin
   F <= Y;
   
   process (s, load)
   begin
      if load='1' then
        Y <= A;
      elsif rising_edge(s) then -- s='1' and s'Event
        if left='1' then
          addZeroL(getlessbit(Y, '1'), Y);
          --Y=Y*2; -- toplama devresi olu?turur
        elsif right='1' then
          addZeroR(getlessbit(Y, '0'), Y);
        end if;
      end if;
   end process;
End Bhv;
