--Library STD;

-- Variables cant start with _

--- LOGIC GATES

-- OR, XOR, NOR, NAND

--- String Ops.

-- & Ulama islemi, vektoru genisletmek icin kullanilir

--- Sequential

-- If it has some kind of memory (register), it's sequential, otherwise combinational.
-- Senkron: clock for all modules
-- Asenkron: clock for a single one and then it signals the others

--- TESTS

-- WAIT;
-- WAIT ON signal UNTIL condition FOR time;
-- WAIT ON e.f UNTIL s='0';

-- a <= '1' After 5ns;
-- b <= '1' After 5ns, '0' After 10ns; -- takes 10ns to complete at total

-- A: std_logic_vector(0 to 31);
-- lbl: for i in A'range loop -- lbl: for i in A'low to A'high loop
--  seq. statements
-- end loop lbl;
-- 'range 'low 'high

-- while cond loop
--   seq.
-- end loop;

-- loop
--   seq.
-- end loop;

--- Scripting

-- Vcom file.vhd
-- Vsim work.eVe

-- Add wave *
-- Add wave -logic A

-- Force reset 1 0
-- Run 100
-- Force reset 0 0
-- Run 300
--> Alternative:
-- force reset 1 0, 0 100
-- Run 400

-- force -freeze clk 0 0, 1 {50ns} -r 100ns

-- Run <time> -- ps/sec/ns/...

--- do <scriptfile>

Library IEEE;
use IEEE.std_logic_1164.all;

Entity eTest41 is
  Generic(n: natural := 8);
  Port(
    A: in std_logic_vector(n-1 downto 0);
    s: in std_logic;
    f: out std_logic --_vector(n-1 downto 0)
  );
End Entity;

Architecture Bhv of eTest41 is
begin
  process (s) is
    variable k: std_logic := '1';
  begin
    if rising_edge(s) then
      k := not(k);
      f <= k;
    end if;
  end process;
End Architecture;

Library IEEE;
use IEEE.std_logic_1164.all;

Entity eTest41_TB is
End Entity;

Architecture Bhv of eTest41_TB is
  signal TA: std_logic_vector(7 downto 0) := "10101010";
  signal ts: std_logic := '0';
  signal tf: std_logic;
  
  Component eTest41 is
    Generic(n: natural);
    Port(
      A: in std_logic_vector(n-1 downto 0);
      s: in std_logic;
      f: out std_logic
    );
  End Component;
begin
  Modu1l: eTest41
    Generic Map(n => 8)
    Port Map(TA, ts, Tf);
  
  process is
  begin
    ts <= not(ts);
    wait for 100 ps;
  end process;
End Architecture;
