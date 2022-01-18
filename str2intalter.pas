{****************************************************************************
*                                                                           *
*   Alternative set of conversion routines for 32/64-bit CPUs.              *
*                                                                           *
*   Copyright(c) 2022 A.Koverdyaev(avk)                                     *
*                                                                           *
*   This code is free software; you can redistribute it and/or modify it    *
*   under the terms of the MIT License.                                     *
*                                                                           *
*  Unless required by applicable law or agreed to in writing, software      *
*  distributed under the License is distributed on an "AS IS" BASIS,        *
*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. *
*  See the License for the specific language governing permissions and      *
*  limitations under the License.                                           *
*                                                                           *
*****************************************************************************}
unit Str2IntAlter;

{$MODE OBJFPC}{$H+}

interface
{
  parsing rules are basically the same as in the built-in Val():
    leading spaces and tabs are allowed;
    a minus sign is not allowed for unsigned integers;
    binary notation can be prefixed with %(Pascal), 0b, or 0B(C, Python ...);
    octal notation can be prefixed with &(Pascal), 0(C, Python 2), 0O or 0o(Python 3, Nim);
    hex notation can use the same prefixes as Val();
  if the Try...2Int() function returns False, then aValue is undefined
}
  function TryChars2Int(const a: array of char; out aValue: Byte): Boolean;
  function TryChars2Int(const a: array of char; out aValue: ShortInt): Boolean;
  function TryChars2Int(const a: array of char; out aValue: Word): Boolean;
  function TryChars2Int(const a: array of char; out aValue: SmallInt): Boolean;
  function TryChars2Int(const a: array of char; out aValue: LongWord): Boolean;
  function TryChars2Int(const a: array of char; out aValue: LongInt): Boolean;
  function TryChars2Int(const a: array of char; out aValue: QWord): Boolean;
  function TryChars2Int(const a: array of char; out aValue: Int64): Boolean;

  function TryChars2ByteDef(const a: array of char; aDefault: Byte = 0): Byte;
  function TryChars2ShortIntDef(const a: array of char; aDefault: ShortInt = 0): ShortInt;
  function TryChars2WordDef(const a: array of char; aDefault: Word = 0): Word;
  function TryChars2SmallIntDef(const a: array of char; aDefault: SmallInt = 0): SmallInt;
  function TryChars2DWordDef(const a: array of char; aDefault: DWord = 0): DWord;
  function TryChars2IntDef(const a: array of char; aDefault: LongInt = 0): LongInt;
  function TryChars2QWordDef(const a: array of char; aDefault: QWord = 0): QWord;
  function TryChars2Int64Def(const a: array of char; aDefault: Int64 = 0): Int64;

  function TryStr2Int(const s: string; out aValue: Byte): Boolean; inline;
  function TryStr2Int(const s: string; out aValue: ShortInt): Boolean; inline;
  function TryStr2Int(const s: string; out aValue: Word): Boolean; inline;
  function TryStr2Int(const s: string; out aValue: SmallInt): Boolean; inline;
  function TryStr2Int(const s: string; out aValue: LongWord): Boolean; inline;
  function TryStr2Int(const s: string; out aValue: LongInt): Boolean; inline;
  function TryStr2Int(const s: string; out aValue: QWord): Boolean; inline;
  function TryStr2Int(const s: string; out aValue: Int64): Boolean; inline;

  function TryStr2ByteDef(const s: string; aDefault: Byte = 0): Byte; inline;
  function TryStr2ShortIntDef(const s: string; aDefault: ShortInt = 0): ShortInt; inline;
  function TryStr2WordDef(const s: string; aDefault: Word = 0): Word; inline;
  function TryStr2SmallIntDef(const s: string; aDefault: SmallInt = 0): SmallInt; inline;
  function TryStr2DWordDef(const s: string; aDefault: DWord = 0): DWord; inline;
  function TryStr2IntDef(const s: string; aDefault: LongInt = 0): LongInt; inline;
  function TryStr2QWordDef(const s: string; aDefault: QWord = 0): QWord; inline;
  function TryStr2Int64Def(const s: string; aDefault: Int64 = 0): Int64; inline;

  function TrySStr2Int(const s: shortstring; out aValue: Byte): Boolean; inline;
  function TrySStr2Int(const s: shortstring; out aValue: ShortInt): Boolean; inline;
  function TrySStr2Int(const s: shortstring; out aValue: Word): Boolean; inline;
  function TrySStr2Int(const s: shortstring; out aValue: SmallInt): Boolean; inline;
  function TrySStr2Int(const s: shortstring; out aValue: LongWord): Boolean; inline;
  function TrySStr2Int(const s: shortstring; out aValue: LongInt): Boolean; inline;
  function TrySStr2Int(const s: shortstring; out aValue: QWord): Boolean; inline;
  function TrySStr2Int(const s: shortstring; out aValue: Int64): Boolean; inline;

  function TrySStr2ByteDef(const s: shortstring; aDefault: Byte = 0): Byte; inline;
  function TrySStr2ShortIntDef(const s: shortstring; aDefault: ShortInt = 0): ShortInt; inline;
  function TrySStr2WordDef(const s: shortstring; aDefault: Word = 0): Word; inline;
  function TrySStr2SmallIntDef(const s: shortstring; aDefault: SmallInt = 0): SmallInt; inline;
  function TrySStr2DWordDef(const s: shortstring; aDefault: DWord = 0): DWord; inline;
  function TrySStr2IntDef(const s: shortstring; aDefault: LongInt = 0): LongInt; inline;
  function TrySStr2QWordDef(const s: shortstring; aDefault: QWord = 0): QWord; inline;
  function TrySStr2Int64Def(const s: shortstring; aDefault: Int64 = 0): Int64; inline;

  function TryStr2Int(p: PChar; aCount: SizeInt; out aValue: Byte): Boolean; inline;
  function TryStr2Int(p: PChar; aCount: SizeInt; out aValue: ShortInt): Boolean; inline;
  function TryStr2Int(p: PChar; aCount: SizeInt; out aValue: Word): Boolean; inline;
  function TryStr2Int(p: PChar; aCount: SizeInt; out aValue: SmallInt): Boolean; inline;
  function TryStr2Int(p: PChar; aCount: SizeInt; out aValue: LongWord): Boolean; inline;
  function TryStr2Int(p: PChar; aCount: SizeInt; out aValue: LongInt): Boolean; inline;
  function TryStr2Int(p: PChar; aCount: SizeInt; out aValue: QWord): Boolean; inline;
  function TryStr2Int(p: PChar; aCount: SizeInt; out aValue: Int64): Boolean; inline;

  function TryStr2ByteDef(p: PChar; aCount: SizeInt; aDefault: Byte = 0): Byte; inline;
  function TryStr2ShortIntDef(p: PChar; aCount: SizeInt; aDefault: ShortInt = 0): ShortInt; inline;
  function TryStr2WordDef(p: PChar; aCount: SizeInt; aDefault: Word = 0): Word; inline;
  function TryStr2SmallIntDef(p: PChar; aCount: SizeInt; aDefault: SmallInt = 0): SmallInt; inline;
  function TryStr2DWordDef(p: PChar; aCount: SizeInt; aDefault: DWord = 0): DWord; inline;
  function TryStr2IntDef(p: PChar; aCount: SizeInt; aDefault: LongInt = 0): LongInt; inline;
  function TryStr2QWordDef(p: PChar; aCount: SizeInt; aDefault: QWord = 0): QWord; inline;
  function TryStr2Int64Def(p: PChar; aCount: SizeInt; aDefault: Int64 = 0): Int64; inline;

implementation
{$Q-}{$B-}{$R-}{$J-}{$COPERATORS ON}{$POINTERMATH ON}

const
  Table: array[#0..#255] of Byte = (
  $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff,
  $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff,
  $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff,
  $00, $01, $02, $03, $04, $05, $06, $07, $08, $09, $ff, $ff, $ff, $ff, $ff, $ff,
  $ff, $0a, $0b, $0c, $0d, $0e, $0f, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff,
  $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff,
  $ff, $0a, $0b, $0c, $0d, $0e, $0f, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff,
  $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff,
  $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff,
  $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff,
  $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff,
  $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff,
  $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff,
  $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff,
  $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff,
  $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff);

type
  TInt   = (int8, int16);
  TRadix = (rxBin, rxOct, rxDec, rxHex);

const
  Bases: array[TRadix] of DWord = (2, 8, 10, 16);
  UIntMax: array[TInt] of DWord = (High(Byte), High(Word));
  SIntMax: array[TInt] of DWord = (High(ShortInt), High(SmallInt));
  UIntMaxLen: array[TInt, TRadix] of SizeInt = ((8, 3, 3, 2), (16, 6, 5, 4));
  Int32MaxLen: array[TRadix] of SizeInt = (32, 11, 10, 8);
{$IFNDEF CPU64}
  Int32PrevMax: array[TRadix] of DWord = (0, 536870911, 429496729, 0);
{$ENDIF}
  Int64MaxLen: array[TRadix] of SizeInt = (64, 22, 20, 16);
  Int64PrevMax: array[TRadix] of QWord = (0, 2305843009213693951, 1844674407370955161, 0);

function Base2UInt(p: PChar; aCount: SizeInt; aType: TInt; aRadix: TRadix; out aValue: DWord): Boolean;
var
  Base, v, t: DWord;
  pEnd: PChar;
begin
  if aCount < 1 then exit(False);
  while p^ = '0' do
    begin
      Inc(p);
      Dec(aCount);
      if aCount = 0 then
        begin
          aValue := 0;
          exit(True);
        end;
    end;
  if aCount > UIntMaxLen[aType, aRadix] then exit(False);
  Base := Bases[aRadix];
  v := Table[p^];
  if v >= Base then exit(False);
  pEnd := p + aCount;
  Inc(p);
  while p < pEnd do
    begin
      t := Table[p^];
      if t >= Base then exit(False);
      v := v * Base + t;
      Inc(p);
    end;
  if v > UIntMax[aType] then exit(False);
  aValue := v;
  Result := True;
end;

function BaseParseUInt(p: PChar; aCount: SizeInt; aType: TInt; out aValue: DWord): Boolean;
begin
  Result := False;
  //here assumed aCount > 0
  while p^ in [#9, ' '] do
    begin
      Inc(p);
      Dec(aCount);
      if aCount = 0 then exit;
    end;
  if p^ = '+' then
    begin
      Inc(p);
      Dec(aCount);
      if aCount = 0 then exit;
    end;
  case p^ of
    '$': Result := Base2UInt(p+1, aCount-1, aType, rxHex, aValue);
    '%': Result := Base2UInt(p+1, aCount-1, aType, rxBin, aValue);
    '&': Result := Base2UInt(p+1, aCount-1, aType, rxOct, aValue);
    '0':
      begin
        if aCount = 1 then
          begin
            aValue := 0;
            exit(True);
          end;
        //here aCount > 1
        case p[1] of
          '0'..'9': Result := Base2UInt(p+1, aCount-1, aType, rxOct, aValue);
          'B', 'b': Result := Base2UInt(p+2, aCount-2, aType, rxBin, aValue);
          'O', 'o': Result := Base2UInt(p+2, aCount-2, aType, rxOct, aValue);
          'X', 'x': Result := Base2UInt(p+2, aCount-2, aType, rxHex, aValue);
        end;
      end;
    '1'..'9': Result := Base2UInt(p, aCount, aType, rxDec, aValue);
    'X', 'x': Result := Base2UInt(p+1, aCount-1, aType, rxHex, aValue);
  end;
end;

function BaseParseSInt(p: PChar; aCount: SizeInt; aType: TInt; out aValue: LongInt): Boolean;
var
  v: DWord;
  IsNeg, IsDec: Boolean;
begin
  Result := False;
  //here assumed aCount > 0
  while p^ in [#9, ' '] do
    begin
      Inc(p);
      Dec(aCount);
      if aCount = 0 then exit;
    end;
  if p^ = '-' then
    begin
      IsNeg := True;
      Inc(p);
      Dec(aCount);
      if aCount = 0 then exit;
    end
  else
    begin
      IsNeg := False;
      if p^ = '+' then
        begin
          Inc(p);
          Dec(aCount);
          if aCount = 0 then exit;
        end;
    end;
  v := 0;
  IsDec := False;
  case p^ of
    '$': Result := Base2UInt(p+1, aCount-1, aType, rxHex, v);
    '%': Result := Base2UInt(p+1, aCount-1, aType, rxBin, v);
    '&': Result := Base2UInt(p+1, aCount-1, aType, rxOct, v);
    '0':
      begin
        if aCount = 1 then
          begin
            aValue := 0;
            exit(True);
          end;
        //here aCount > 1
        case p[1] of
          '0'..'9': Result := Base2UInt(p+1, aCount-1, aType, rxOct, v);
          'B', 'b': Result := Base2UInt(p+2, aCount-2, aType, rxBin, v);
          'O', 'o': Result := Base2UInt(p+2, aCount-2, aType, rxOct, v);
          'X', 'x': Result := Base2UInt(p+2, aCount-2, aType, rxHex, v);
        end;
      end;
    '1'..'9':
      begin
        IsDec := True;
        Result := Base2UInt(p, aCount, aType, rxDec, v);
      end;
    'X', 'x': Result := Base2UInt(p+1, aCount-1, aType, rxHex, v);
  end;
  if not Result then exit;
  if IsNeg then
    begin
      if v > Succ(SIntMax[aType]) then exit(False);
      aValue := -LongInt(v);
    end
  else
    begin
      if IsDec and (v > SIntMax[aType]) then exit(False);
      aValue := LongInt(v);
    end;
end;

function TryChars2Int(const a: array of char; out aValue: Byte): Boolean;
var
  v: DWord;
begin
  if Length(a) = 0 then exit(False);
  Result := BaseParseUInt(@a[0], Length(a), int8, v);
  if Result then
    aValue := v;
end;

function TryChars2Int(const a: array of char; out aValue: ShortInt): Boolean;
var
  v: LongInt;
begin
  if Length(a) = 0 then exit(False);
  Result := BaseParseSInt(@a[0], Length(a), int8, v);
  if Result then
    aValue := v;
end;

function TryChars2Int(const a: array of char; out aValue: Word): Boolean;
var
  v: DWord;
begin
  if Length(a) = 0 then exit(False);
  Result := BaseParseUInt(@a[0], Length(a), int16, v);
  if Result then
    aValue := v;
end;

function TryChars2Int(const a: array of char; out aValue: SmallInt): Boolean;
var
  v: LongInt;
begin
  if Length(a) = 0 then exit(False);
  Result := BaseParseSInt(@a[0], Length(a), int16, v);
  if Result then
    aValue := v;
end;

function CharToDWord(p: PChar; aCount: SizeInt; aRadix: TRadix; out aValue: DWord): Boolean;
var
{$IFDEF CPU64}
  v: QWord;
  Base, t: DWord;
{$ELSE}
  Base, v, t: DWord;
{$ENDIF}
  pEnd: PChar;
begin
  if aCount < 1 then exit(False);
  while p^ = '0' do
    begin
      Inc(p);
      Dec(aCount);
      if aCount = 0 then
        begin
          aValue := 0;
          exit(True);
        end;
    end;
  if aCount > Int32MaxLen[aRadix] then exit(False);
  Base := Bases[aRadix];
  v := Table[p^];
  if v >= Base then exit(False);
  pEnd := p + aCount;
  Inc(p);
{$IFDEF CPU64}
  while p < pEnd do
    begin
      t := Table[p^];
      if t >= Base then exit(False);
      v := v * Base + t;
      Inc(p);
    end;
  if v > High(DWord) then exit(False);
{$ELSE}
  if (aCount < Int32MaxLen[aRadix]) or (aRadix in [rxBin, rxHex]) then
    while p < pEnd do
      begin
        t := Table[p^];
        if t >= Base then exit(False);
        v := v * Base + t;
        Inc(p);
      end
  else
    begin
      while p < pEnd - 1 do
        begin
          t := Table[p^];
          if t >= Base then exit(False);
          v := v * Base + t;
          Inc(p);
        end;
      if v > Int32PrevMax[aRadix] then exit(False);
      t := Table[p^];
      if t >= Base then exit(False);
      v := v * Base + t;
      if v < t then exit(False);
    end;
{$ENDIF}
  aValue := v;
  Result := True;
end;

function TryChars2Int(const a: array of char; out aValue: LongWord): Boolean;
var
  Count: SizeInt;
  p: PChar;
begin
  Result := False;
  if Length(a) = 0 then exit;
  Count := Length(a);
  p := @a[0];
  while p^ in [#9, ' '] do
    begin
      Inc(p);
      Dec(Count);
      if Count = 0 then exit;
    end;
  if p^ = '+' then
    begin
      Inc(p);
      Dec(Count);
      if Count = 0 then exit;
    end;

  case p^ of
    '$': Result := CharToDWord(p+1, Count-1, rxHex, aValue);
    '%': Result := CharToDWord(p+1, Count-1, rxBin, aValue);
    '&': Result := CharToDWord(p+1, Count-1, rxOct, aValue);
    '0':
      begin
        if Count = 1 then
          begin
            aValue := 0;
            exit(True);
          end;
        //here Count > 1
        case p[1] of
          '0'..'9': Result := CharToDWord(p+1, Count-1, rxOct, aValue);
          'B', 'b': Result := CharToDWord(p+2, Count-2, rxBin, aValue);
          'O', 'o': Result := CharToDWord(p+2, Count-2, rxOct, aValue);
          'X', 'x': Result := CharToDWord(p+2, Count-2, rxHex, aValue);
        end;
      end;
    '1'..'9': Result := CharToDWord(p, Count, rxDec, aValue);
    'X', 'x': Result := CharToDWord(p+1, Count-1, rxHex, aValue);
  end;
end;

function TryChars2Int(const a: array of char; out aValue: LongInt): Boolean;
var
  v: DWord;
  Count: SizeInt;
  p: PChar;
  IsNeg, IsDec: Boolean;
begin
  Result := False;
  if Length(a) = 0 then exit;
  Count := Length(a);
  p := @a[0];
  while p^ in [#9, ' '] do
    begin
      Inc(p);
      Dec(Count);
      if Count = 0 then exit;
    end;
  if p^ = '-' then
    begin
      IsNeg := True;
      Inc(p);
      Dec(Count);
      if Count = 0 then exit;
    end
  else
    begin
      IsNeg := False;
      if p^ = '+' then
        begin
          Inc(p);
          Dec(Count);
          if Count = 0 then exit;
        end;
    end;
  v := 0;
  IsDec := False;
  case p^ of
    '$': Result := CharToDWord(p+1, Count-1, rxHex, v);
    '%': Result := CharToDWord(p+1, Count-1, rxBin, v);
    '&': Result := CharToDWord(p+1, Count-1, rxOct, v);
    '0':
      begin
        if Count = 1 then
          begin
            aValue := 0;
            exit(True);
          end;
        //here Count > 1
        case p[1] of
          '0'..'9': Result := CharToDWord(p+1, Count-1, rxOct, v);
          'B', 'b': Result := CharToDWord(p+2, Count-2, rxBin, v);
          'O', 'o': Result := CharToDWord(p+2, Count-2, rxOct, v);
          'X', 'x': Result := CharToDWord(p+2, Count-2, rxHex, v);
        end;
      end;
    '1'..'9':
      begin
        IsDec := True;
        Result := CharToDWord(p, Count, rxDec, v);
      end;
    'X', 'x': Result := CharToDWord(p+1, Count-1, rxHex, v);
  end;
  if not Result then exit;
  if IsNeg then
    begin
      if v > Succ(DWord(High(LongInt))) then exit(False);
      aValue := -LongInt(v);
    end
  else
    begin
      if IsDec and (v > DWord(High(LongInt))) then exit(False);
      aValue := LongInt(v);
    end;
end;

{$PUSH}{$WARN 4079 OFF}
function CharToQWord(p: PChar; aCount: SizeInt; aRadix: TRadix; out aValue: QWord): Boolean;
var
  v: QWord;
  Base, t: DWord;
  pEnd: PChar;
{$IFNDEF CPU64}
  pDw: PChar;
{$ENDIF}
begin
  if aCount < 1 then exit(False);
  while p^ = '0' do
    begin
      Inc(p);
      Dec(aCount);
      if aCount = 0 then
        begin
          aValue := 0;
          exit(True);
        end;
    end;
  if aCount > Int64MaxLen[aRadix] then exit(False);
  Base := Bases[aRadix];
  v := Table[p^];
  if v >= Base then exit(False);
  pEnd := p + aCount;
{$IFNDEF CPU64}
  pDw := p + Pred(Int32MaxLen[aRadix]);
{$ENDIF}
  Inc(p);
{$IFDEF CPU64}
  if (aCount < Int64MaxLen[aRadix]) or (aRadix in [rxBin, rxHex]) then
    while p < pEnd do
      begin
        t := Table[p^];
        if t >= Base then exit(False);
        v := v * Base + t;
        Inc(p);
      end
  else
    begin
      while p < pEnd - 1 do
        begin
          t := Table[p^];
          if t >= Base then exit(False);
          v := v * Base + t;
          Inc(p);
        end;
      if v > Int64PrevMax[aRadix] then exit(False);
      t := Table[p^];
      if t >= Base then exit(False);
      v := v * Base + t;
      if v < t then exit(False);
    end;
{$ELSE}
  if (aCount < Int64MaxLen[aRadix]) or (aRadix in [rxBin, rxHex]) then
    while p < pEnd do
      begin
        t := Table[p^];
        if t >= Base then exit(False);
        if p < pDw then
          v := DWord(v) * Base + t
        else
          v := v * Base + t;
        Inc(p);
      end
  else
    begin
      while p < pDw do
        begin
          t := Table[p^];
          if t >= Base then exit(False);
          v := DWord(v) * Base + t;
            Inc(p);
        end;
      while p < pEnd - 1 do
        begin
          t := Table[p^];
          if t >= Base then exit(False);
          v := v * Base + t;
          Inc(p);
        end;
      if v > Int64PrevMax[aRadix] then exit(False);
      t := Table[p^];
      if t >= Base then exit(False);
      v := v * Base + t;
      if v < t then exit(False);
    end;
{$ENDIF}
  aValue := v;
  Result := True;
end;
{$POP}

function TryChars2Int(const a: array of char; out aValue: QWord): Boolean;
var
  Count: SizeInt;
  p: PChar;
begin
  Result := False;
  if Length(a) = 0 then exit;
  Count := Length(a);
  p := @a[0];
  while p^ in [#9, ' '] do
    begin
      Inc(p);
      Dec(Count);
      if Count = 0 then exit;
    end;
  if p^ = '+' then
    begin
      Inc(p);
      Dec(Count);
      if Count = 0 then exit;
    end;

  case p^ of
    '$': Result := CharToQWord(p+1, Count-1, rxHex, aValue);
    '%': Result := CharToQWord(p+1, Count-1, rxBin, aValue);
    '&': Result := CharToQWord(p+1, Count-1, rxOct, aValue);
    '0':
      begin
        if Count = 1 then
          begin
            aValue := 0;
            exit(True);
          end;
        //here Count > 1
        case p[1] of
          '0'..'9': Result := CharToQWord(p+1, Count-1, rxOct, aValue);
          'B', 'b': Result := CharToQWord(p+2, Count-2, rxBin, aValue);
          'O', 'o': Result := CharToQWord(p+2, Count-2, rxOct, aValue);
          'X', 'x': Result := CharToQWord(p+2, Count-2, rxHex, aValue);
        end;
      end;
    '1'..'9': Result := CharToQWord(p, Count, rxDec, aValue);
    'X', 'x': Result := CharToQWord(p+1, Count-1, rxHex, aValue);
  end;
end;

function TryChars2Int(const a: array of char; out aValue: Int64): Boolean;
var
  v: QWord;
  Count: SizeInt;
  p: PChar;
  IsNeg, IsDec: Boolean;
begin
  Result := False;
  if Length(a) = 0 then exit;
  Count := Length(a);
  p := @a[0];
  while p^ in [#9, ' '] do
    begin
      Inc(p);
      Dec(Count);
      if Count = 0 then exit;
    end;
  if p^ = '-' then
    begin
      IsNeg := True;
      Inc(p);
      Dec(Count);
      if Count = 0 then exit;
    end
  else
    begin
      IsNeg := False;
      if p^ = '+' then
        begin
          Inc(p);
          Dec(Count);
          if Count = 0 then exit;
        end;
    end;
  v := 0;
  IsDec := False;
  case p^ of
    '$': Result := CharToQWord(p+1, Count-1, rxHex, v);
    '%': Result := CharToQWord(p+1, Count-1, rxBin, v);
    '&': Result := CharToQWord(p+1, Count-1, rxOct, v);
    '0':
      begin
        if Count = 1 then
          begin
            aValue := 0;
            exit(True);
          end;
        //here Count > 1
        case p[1] of
          '0'..'9': Result := CharToQWord(p+1, Count-1, rxOct, v);
          'B', 'b': Result := CharToQWord(p+2, Count-2, rxBin, v);
          'O', 'o': Result := CharToQWord(p+2, Count-2, rxOct, v);
          'X', 'x': Result := CharToQWord(p+2, Count-2, rxHex, v);
        end;
      end;
    '1'..'9':
      begin
        IsDec := True;
        Result := CharToQWord(p, Count, rxDec, v);
      end;
    'X', 'x': Result := CharToQWord(p+1, Count-1, rxHex, v);
  end;
  if not Result then exit;
  if IsNeg then
    begin
      if v > Succ(QWord(High(Int64))) then exit(False);
      aValue := -Int64(v);
    end
  else
    begin
      if IsDec and (v > QWord(High(Int64))) then exit(False);
      aValue := Int64(v);
    end;
end;

function TryChars2ByteDef(const a: array of char; aDefault: Byte): Byte;
begin
  if not TryChars2Int(a, Result) then
    Result := aDefault;
end;

function TryChars2ShortIntDef(const a: array of char; aDefault: ShortInt): ShortInt;
begin
  if not TryChars2Int(a, Result) then
    Result := aDefault;
end;

function TryChars2WordDef(const a: array of char; aDefault: Word): Word;
begin
  if not TryChars2Int(a, Result) then
    Result := aDefault;
end;

function TryChars2SmallIntDef(const a: array of char; aDefault: SmallInt): SmallInt;
begin
  if not TryChars2Int(a, Result) then
    Result := aDefault;
end;

function TryChars2DWordDef(const a: array of char; aDefault: DWord): DWord;
begin
  if not TryChars2Int(a, Result) then
    Result := aDefault;
end;

function TryChars2IntDef(const a: array of char; aDefault: LongInt): LongInt;
begin
  if not TryChars2Int(a, Result) then
    Result := aDefault;
end;

function TryChars2QWordDef(const a: array of char; aDefault: QWord): QWord;
begin
  if not TryChars2Int(a, Result) then
    Result := aDefault;
end;

function TryChars2Int64Def(const a: array of char; aDefault: Int64): Int64;
begin
  if not TryChars2Int(a, Result) then
    Result := aDefault;
end;

function TryStr2Int(const s: string; out aValue: Byte): Boolean;
begin
  Result := TryChars2Int(s[1..System.Length(s)], aValue);
end;

function TryStr2Int(const s: string; out aValue: ShortInt): Boolean;
begin
  Result := TryChars2Int(s[1..Length(s)], aValue);
end;

function TryStr2Int(const s: string; out aValue: Word): Boolean;
begin
  Result := TryChars2Int(s[1..Length(s)], aValue);
end;

function TryStr2Int(const s: string; out aValue: SmallInt): Boolean;
begin
  Result := TryChars2Int(s[1..Length(s)], aValue);
end;

function TryStr2Int(const s: string; out aValue: LongWord): Boolean;
begin
  Result := TryChars2Int(s[1..Length(s)], aValue);
end;

function TryStr2Int(const s: string; out aValue: LongInt): Boolean;
begin
  Result := TryChars2Int(s[1..Length(s)], aValue);
end;

function TryStr2Int(const s: string; out aValue: QWord): Boolean;
begin
  Result := TryChars2Int(s[1..Length(s)], aValue);
end;

function TryStr2Int(const s: string; out aValue: Int64): Boolean;
begin
  Result := TryChars2Int(s[1..Length(s)], aValue);
end;

function TryStr2ByteDef(const s: string; aDefault: Byte): Byte;
begin
  if not TryChars2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TryStr2ShortIntDef(const s: string; aDefault: ShortInt): ShortInt;
begin
  if not TryChars2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TryStr2WordDef(const s: string; aDefault: Word): Word;
begin
  if not TryChars2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TryStr2SmallIntDef(const s: string; aDefault: SmallInt): SmallInt;
begin
  if not TryChars2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TryStr2DWordDef(const s: string; aDefault: DWord): DWord;
begin
  if not TryChars2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TryStr2IntDef(const s: string; aDefault: LongInt): LongInt;
begin
  if not TryChars2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TryStr2QWordDef(const s: string; aDefault: QWord): QWord;
begin
  if not TryChars2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TryStr2Int64Def(const s: string; aDefault: Int64): Int64;
begin
  if not TryChars2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TrySStr2Int(const s: shortstring; out aValue: Byte): Boolean;
begin
  Result := TryChars2Int(s[1..Length(s)], aValue);
end;

function TrySStr2Int(const s: shortstring; out aValue: ShortInt): Boolean;
begin
  Result := TryChars2Int(s[1..Length(s)], aValue);
end;

function TrySStr2Int(const s: shortstring; out aValue: Word): Boolean;
begin
  Result := TryChars2Int(s[1..Length(s)], aValue);
end;

function TrySStr2Int(const s: shortstring; out aValue: SmallInt): Boolean;
begin
  Result := TryChars2Int(s[1..Length(s)], aValue);
end;

function TrySStr2Int(const s: shortstring; out aValue: LongWord): Boolean;
begin
  Result := TryChars2Int(s[1..Length(s)], aValue);
end;

function TrySStr2Int(const s: shortstring; out aValue: LongInt): Boolean;
begin
  Result := TryChars2Int(s[1..Length(s)], aValue);
end;

function TrySStr2Int(const s: shortstring; out aValue: QWord): Boolean;
begin
  Result := TryChars2Int(s[1..Length(s)], aValue);
end;

function TrySStr2Int(const s: shortstring; out aValue: Int64): Boolean;
begin
  Result := TryChars2Int(s[1..Length(s)], aValue);
end;

function TrySStr2ByteDef(const s: shortstring; aDefault: Byte): Byte;
begin
  if not TryChars2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TrySStr2ShortIntDef(const s: shortstring; aDefault: ShortInt): ShortInt;
begin
  if not TryChars2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TrySStr2WordDef(const s: shortstring; aDefault: Word): Word;
begin
  if not TryChars2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TrySStr2SmallIntDef(const s: shortstring; aDefault: SmallInt): SmallInt;
begin
  if not TryChars2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TrySStr2DWordDef(const s: shortstring; aDefault: DWord): DWord;
begin
  if not TryChars2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TrySStr2IntDef(const s: shortstring; aDefault: LongInt): LongInt;
begin
  if not TryChars2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TrySStr2QWordDef(const s: shortstring; aDefault: QWord): QWord;
begin
  if not TryChars2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TrySStr2Int64Def(const s: shortstring; aDefault: Int64): Int64;
begin
  if not TryChars2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TryStr2Int(p: PChar; aCount: SizeInt; out aValue: Byte): Boolean;
begin
  Result := TryChars2Int(p[0..Pred(aCount)], aValue);
end;

function TryStr2Int(p: PChar; aCount: SizeInt; out aValue: ShortInt): Boolean;
begin
  Result := TryChars2Int(p[0..Pred(aCount)], aValue);
end;

function TryStr2Int(p: PChar; aCount: SizeInt; out aValue: Word): Boolean;
begin
  Result := TryChars2Int(p[0..Pred(aCount)], aValue);
end;

function TryStr2Int(p: PChar; aCount: SizeInt; out aValue: SmallInt): Boolean;
begin
  Result := TryChars2Int(p[0..Pred(aCount)], aValue);
end;

function TryStr2Int(p: PChar; aCount: SizeInt; out aValue: LongWord): Boolean;
begin
  Result := TryChars2Int(p[0..Pred(aCount)], aValue);
end;

function TryStr2Int(p: PChar; aCount: SizeInt; out aValue: LongInt): Boolean;
begin
  Result := TryChars2Int(p[0..Pred(aCount)], aValue);
end;

function TryStr2Int(p: PChar; aCount: SizeInt; out aValue: QWord): Boolean;
begin
  Result := TryChars2Int(p[0..Pred(aCount)], aValue);
end;

function TryStr2Int(p: PChar; aCount: SizeInt; out aValue: Int64): Boolean;
begin
  Result := TryChars2Int(p[0..Pred(aCount)], aValue);
end;

function TryStr2ByteDef(p: PChar; aCount: SizeInt; aDefault: Byte): Byte;
begin
  if not TryChars2Int(p[0..Pred(aCount)], Result) then
    Result := aDefault;
end;

function TryStr2ShortIntDef(p: PChar; aCount: SizeInt; aDefault: ShortInt): ShortInt;
begin
  if not TryChars2Int(p[0..Pred(aCount)], Result) then
    Result := aDefault;
end;

function TryStr2WordDef(p: PChar; aCount: SizeInt; aDefault: Word): Word;
begin
  if not TryChars2Int(p[0..Pred(aCount)], Result) then
    Result := aDefault;
end;

function TryStr2SmallIntDef(p: PChar; aCount: SizeInt; aDefault: SmallInt): SmallInt;
begin
  if not TryChars2Int(p[0..Pred(aCount)], Result) then
    Result := aDefault;
end;

function TryStr2DWordDef(p: PChar; aCount: SizeInt; aDefault: DWord): DWord;
begin
  if not TryChars2Int(p[0..Pred(aCount)], Result) then
    Result := aDefault;
end;

function TryStr2IntDef(p: PChar; aCount: SizeInt; aDefault: LongInt): LongInt;
begin
  if not TryChars2Int(p[0..Pred(aCount)], Result) then
    Result := aDefault;
end;

function TryStr2QWordDef(p: PChar; aCount: SizeInt; aDefault: QWord): QWord;
begin
  if not TryChars2Int(p[0..Pred(aCount)], Result) then
    Result := aDefault;
end;

function TryStr2Int64Def(p: PChar; aCount: SizeInt; aDefault: Int64): Int64;
begin
  if not TryChars2Int(p[0..Pred(aCount)], Result) then
    Result := aDefault;
end;

end.

