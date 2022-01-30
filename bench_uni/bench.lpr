program bench;

{$MODE OBJFPC}{$H+}

uses
  SysUtils, DateUtils, StrUtils, Str2IntAlter;

var
  a: array of unicodestring;

function NextRandomDWord: DWord;
begin
  Result := DWord(Random(Int64($100000000)));
end;

function NextRandomQWord: QWord;
begin
  Result := QWord(Random(Int64($100000000))) shl 32 or QWord(Random(Int64($100000000)));
end;

function NextUInt32: string;
begin
  case Random(4) of
    0: Result := ' '#9'+%' + NextRandomDWord.ToBinString;
    1: Result := ' '#9'+&' + OctStr(LongInt(NextRandomDWord), 11);
    2: Result := ' '#9'+' + NextRandomDWord.ToString;
  else
    Result := ' '#9'+$' + NextRandomDWord.ToHexString;
  end;
end;

function NextSInt32: string;
begin
  case Random(4) of
    0: Result := ' '#9'%' + LongInt(NextRandomDWord).ToBinString;
    1: Result := ' '#9'&' + OctStr(LongInt(NextRandomDWord), 11);
    2: Result := ' '#9 + LongInt(NextRandomDWord).ToString;
  else
    Result := ' '#9'$' + LongInt(NextRandomDWord).ToHexString;
  end;
end;

function NextUInt64: string;
begin
  case Random(4) of
    0: Result := ' '#9'+%' + NextRandomQWord.ToBinString;
    1: Result := ' '#9'+&' + OctStr(NextRandomQWord, 22);
    2: Result := ' '#9'+' + NextRandomQWord.ToString;
  else
    Result := ' '#9'+$' + NextRandomQWord.ToHexString;
  end;
end;

function NextSInt64: string;
begin
  case Random(4) of
    0: Result := ' '#9'%' + Int64(NextRandomQWord).ToBinString;
    1: Result := ' '#9'&' + OctStr(Int64(NextRandomQWord), 22);
    2: Result := ' '#9 + Int64(NextRandomQWord).ToString;
  else
    Result := ' '#9'$' + Int64(NextRandomQWord).ToHexString;
  end;
end;

procedure GenTestUInt32;
var
  I: Integer;
const
  TestSize = 2000;
begin
  SetLength(a, TestSize);
  for I := 0 to High(a) do
    a[I] := unicodestring(NextUInt32);
end;

procedure GenTestUInt64;
var
  I: Integer;
const
  TestSize = 2000;
begin
  SetLength(a, TestSize);
  for I := 0 to High(a) do
    a[I] :=  unicodestring(NextUInt64);
end;

procedure GenTestSInt32;
var
  I: Integer;
const
  TestSize = 2000;
begin
  SetLength(a, TestSize);
  for I := 0 to High(a) do
    a[I] :=  unicodestring(NextSInt32);
end;

procedure GenTestSInt64;
var
  I: Integer;
const
  TestSize = 2000;
begin
  SetLength(a, TestSize);
  for I := 0 to High(a) do
    a[I] :=  unicodestring(NextSInt64);
end;

procedure RunValSInt32;
var
  Score: Int64;
  Start: TTime;
  I, J, v, c, r: Integer;
begin
  r := 0;
  Start := Time;
  for J := 1 to 10000 do
    for I := 0 to High(a) do
      begin
        Val(a[I], v, c);
        Inc(r, Ord(c <> 0));
      end;
  Score := MillisecondsBetween(Time, Start);
  WriteLn('Val(), score:        ', Score);
  WriteLn('rejected:            ', r);
end;

procedure RunAltSInt32;
var
  I, J, v, r: Integer;
  Start: TTime;
  Score: Int64;
begin
  r := 0;
  Start := Time;
  for J := 1 to 10000 do
    for I := 0 to High(a) do
      if not TryChars2Int(a[I][1..Length(a[I])], v) then
        Inc(r);
  Score := MillisecondsBetween(Time, Start);
  WriteLn('TryChars2Int, score: ', Score);
  WriteLn('rejected:            ', r);
end;

procedure RunValUInt32;
var
  I, J, c, r: Integer;
  v: DWord;
  Start: TTime;
  Score: Int64;
begin
  r := 0;
  Start := Time;
  for J := 1 to 10000 do
    for I := 0 to High(a) do
      begin
        Val(a[I], v, c);
        Inc(r, Ord(c <> 0));
      end;
  Score := MillisecondsBetween(Time, Start);
  WriteLn('Val(), score:        ', Score);
  WriteLn('rejected:            ', r);
end;

procedure RunAltUInt32;
var
  I, J, r: Integer;
  v: DWord;
  Start: TTime;
  Score: Int64;
begin
  r := 0;
  Start := Time;
  for J := 1 to 10000 do
    for I := 0 to High(a) do
      if not TryChars2Int(a[I][1..Length(a[I])], v) then
        Inc(r);
  Score := MillisecondsBetween(Time, Start);
  WriteLn('TryChars2Int, score: ', Score);
  WriteLn('rejected:            ', r);
end;

procedure RunValSInt64;
var
  Score, v: Int64;
  Start: TTime;
  I, J, c, r: Integer;
begin
  r := 0;
  Start := Time;
  for J := 1 to 10000 do
    for I := 0 to High(a) do
      begin
        Val(a[I], v, c);
        Inc(r, Ord(c <> 0));
      end;
  Score := MillisecondsBetween(Time, Start);
  WriteLn('Val(), score:        ', Score);
  WriteLn('rejected:            ', r);
end;

procedure RunAltSInt64;
var
  Score, v: Int64;
  Start: TTime;
  I, J, r: Integer;
begin
  r := 0;
  v := 0;
  Start := Time;
  for J := 1 to 10000 do
    for I := 0 to High(a) do
      if not TryChars2Int(a[I][1..Length(a[I])], v) then
        Inc(r);
  Score := MillisecondsBetween(Time, Start);
  WriteLn('TryChars2Int, score: ', Score);
  WriteLn('rejected:            ', r);
end;

procedure RunValUInt64;
var
  Score: Int64;
  Start: TTime;
  I, J, c, r: Integer;
  v: QWord;
begin
  r := 0;
  Start := Time;
  for J := 1 to 10000 do
    for I := 0 to High(a) do
      begin
        Val(a[I], v, c);
        Inc(r, Ord(c <> 0));
      end;
  Score := MillisecondsBetween(Time, Start);
  WriteLn('Val(), score:        ', Score);
  WriteLn('rejected:            ', r);
end;

procedure RunAltUInt64;
var
  Score: Int64;
  Start: TTime;
  I, J, r: Integer;
  v: QWord;
begin
  r := 0;
  v := 0;
  Start := Time;
  for J := 1 to 10000 do
    for I := 0 to High(a) do
      if not TryChars2Int(a[I][1..Length(a[I])], v) then
        Inc(r);
  Score := MillisecondsBetween(Time, Start);
  WriteLn('TryChars2Int, score: ', Score);
  WriteLn('rejected:            ', r);
end;

begin
  Randomize;
  WriteLn('SInt32: ');
  GenTestSInt32;
  RunValSInt32;
  RunAltSInt32;
  WriteLn;

  WriteLn('SInt64: ');
  GenTestSInt64;
  RunValSInt64;
  RunAltSInt64;
  WriteLn;

  WriteLn('UInt32: ');
  GenTestUInt32;
  RunValUInt32;
  RunAltUInt32;
  WriteLn;

  WriteLn('UInt64: ');
  GenTestUInt64;
  RunValUInt64;
  RunAltUInt64;
  WriteLn;

  WriteLn('Press enter to exit...');
  ReadLn;
end.


