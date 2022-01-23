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

function NextUInt32: string;
begin
  case Random(4) of
    0: Result := ' +%' + NextRandomDWord.ToBinString;
    1: Result := ' +&' + OctStr(LongInt(NextRandomDWord), 11);
    2: Result := ' +' + NextRandomDWord.ToString;
  else
    Result := ' +0x' + NextRandomDWord.ToHexString;
  end;
end;

function NextSInt32: string;
begin
  case Random(4) of
    0: Result := ' %' + NextRandomDWord.ToBinString;
    1: Result := ' &' + OctStr(LongInt(NextRandomDWord), 11);
    2: Result := '  ' + LongInt(NextRandomDWord).ToString;
  else
    Result := ' 0x' + NextRandomDWord.ToHexString;
  end;
end;

function NextUInt64: string;
begin
  case Random(4) of
    0: Result := ' +%' + NextRandomQWord.ToBinString;
    1: Result := ' +&' + OctStr(Int64(NextRandomQWord), 22);
    2: Result := '  ' + NextRandomQWord.ToString;
  else
    Result := ' +0x' + NextRandomQWord.ToHexString;
  end;
end;

function NextSInt64: string;
begin
  case Random(4) of
    0: Result := ' %' + NextRandomQWord.ToBinString;
    1: Result := ' &' + OctStr(Int64(NextRandomQWord), 22);
    2: Result := '  ' + Int64(NextRandomQWord).ToString;
  else
    Result := ' 0x' + NextRandomQWord.ToHexString;
  end;
end;

procedure GenTestUInt32;
var
  I: Integer;
const
  TestSize = 3000;
begin
  SetLength(a, TestSize);
  for I := 0 to High(a) do
    a[I] := NextUInt32;
end;

procedure GenTestUInt64;
var
  I: Integer;
const
  TestSize = 2000;
begin
  SetLength(a, TestSize);
  for I := 0 to High(a) do
    a[I] := NextUInt64;
end;

procedure GenTestSInt32;
var
  I: Integer;
const
  TestSize = 3000;
begin
  SetLength(a, TestSize);
  for I := 0 to High(a) do
    a[I] := NextSInt32;
end;

procedure GenTestSInt64;
var
  I: Integer;
const
  TestSize = 2000;
begin
  SetLength(a, TestSize);
  for I := 0 to High(a) do
    a[I] := NextSInt64;
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
  WriteLn('Press any key to exit...');
  ReadLn;
end.

