
Library IEEE, std;
Use IEEE.std_logic_textio.all;
Use std.textio.all;

Entity eFileTest is
End;

Architecture Bhv of eFileTest is
    Type tIntFile is file of integer;
    File dYaz: tIntFile open WRITE_MODE is "file.int";
    File dOku: tIntFile open READ_MODE is "file.int";
    File dYaz2: TEXT open WRITE_MODE is "file.text";
    File dOku2: TEXT open READ_MODE is "file.text";
begin
  process is
  begin
    --file_open(file_RESULTS, "output_results.txt", write_mode);
    write(dYaz, 32);
    write(dYaz, 65);
    --file_close(file_RESULTS);
    wait;
  end process;
  
  process is
    variable i: integer;
  begin
    read(dOku, i);
    wait;
  end process;
  
  process is
    variable lsatir: line;
  begin
    write(lsatir, 'a');
    write(lsatir, 65);
    writeline(dYaz2, lsatir);
    --write(line, str, right/left, line_length);
    wait;
  end process;
  
  process is
    variable lsatir: line;
    variable c: character;
  begin
    if not endfile(dOku2) then
      readline(dOku2, lsatir);
      read(lsatir, c);
    end if;
    wait;
  end process;
End;
