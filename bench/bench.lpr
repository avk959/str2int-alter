program bench;

{$MODE OBJFPC}{$H+}

uses
  SysUtils, DateUtils, StrUtils, Str2IntAlter;

var
  a: TStringArray = nil;

function NextRandomDWord: DWord;
begin
  Result := DWord(Random(Int64($100000000)));
end;

function NextRandomQWord: QWord;
begin
  Result := QWord(Random(Int64($100000000))) shl 32 or QWord(Random(Int64($100000000)));
end;

function NextValue32: string;
begin
  case Random(4) of
    0: Result := '%' + LongInt(NextRandomDWord).ToBinString;
    1: Result := '&' + OctStr(LongInt(NextRandomDWord), 11);
    2: Result := LongInt(NextRandomDWord).ToString;
  else
    Result := '0x' + LongInt(NextRandomDWord).ToHexString;
  end;
end;

function NextValue64: string;
begin
  case Random(4) of
    0: Result := '%' + Int64(NextRandomQWord).ToBinString;
    1: Result := '&' + OctStr(Int64(NextRandomQWord), 22);
    2: Result := Int64(NextRandomQWord).ToString;
  else
    Result := '0x' + Int64(NextRandomQWord).ToHexString;
  end;
end;

procedure GenTestData32;
var
  I: Integer;
const
  TestSize = 3000;
begin
  SetLength(a, TestSize);
  Randomize;
  for I := 0 to High(a) do
    a[I] := NextValue32;
end;

procedure GenTestData64;
var
  I: Integer;
const
  TestSize = 2000;
begin
  SetLength(a, TestSize);
  Randomize;
  for I := 0 to High(a) do
    a[I] := NextValue64;
end;

procedure RunVal32;
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

procedure RunVal64;
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

procedure RunAlt32;
var
  Score: Int64;
  Start: TTime;
  I, J, v, r: Integer;
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

procedure RunAlt64;
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

begin
  GenTestData32;
  WriteLn('Int32: ');
  RunVal32;
  RunAlt32;
  WriteLn('Int64: ');
  GenTestData64;
  RunVal64;
  RunAlt64;
  WriteLn('Press any key to exit...');
  ReadLn;
end.

