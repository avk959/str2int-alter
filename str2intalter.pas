{****************************************************************************
*                                                                           *
*  Alternative set of string-to-int conversion routines for 32/64-bit CPUs. *
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

{.$DEFINE NEED_VAL_COMPAT}//uncomment if full compatibility with Val() is required

interface

{ parsing rules are basically the same as in the built-in Val():
    leading spaces and tabs are allowed;
    a minus sign is not allowed for unsigned integers;

    if input string represents a numerical value in decimal notation, or a negative number,
    then the numerical value MUST fit into the range of the type of aValue;

    if input string represents a numerical value in binary, octal or hexadecimal notation,
    and does not contain a minus sign, then the numerical value MUST fit into the unsigned
    counterpart of the type of aValue and will be casted to the type of aValue;

    hex notation can use the same prefixes as Val();
    if NEED_VAL_COMPAT is defined, then other supported prefixes are the same as in Val(),
    otherwise:
      binary notation can be prefixed with %(Pascal), 0b, or 0B(C, Python ...);
      octal notation can be prefixed with &(Pascal), 0(C, Python 2), 0O or 0o(Python 3, Nim);

  if the Try...2Int() function returns False, then aValue is undefined }
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

{ only for strings in decimal notation;
    leading spaces and tabs are allowed;
    leading zeros are allowed;
    a minus sign is not allowed for unsigned integers;
    numerical value MUST fit into the range of the type of aValue;
  if the TryDecimals2Int() returns False, then aValue is undefined }
  function TryDecimals2Int(const a: array of char; out aValue: LongWord): Boolean;
  function TryDecimals2Int(const a: array of char; out aValue: LongInt): Boolean;
  function TryDecimals2Int(const a: array of char; out aValue: QWord): Boolean;
  function TryDecimals2Int(const a: array of char; out aValue: Int64): Boolean;

  function TryDecimals2DWordDef(const a: array of char; aDefault: LongWord = 0): DWord;
  function TryDecimals2IntDef(const a: array of char; aDefault: LongInt = 0): Int64;
  function TryDecimals2QWordDef(const a: array of char; aDefault: QWord = 0): QWord;
  function TryDecimals2Int64Def(const a: array of char; aDefault: Int64 = 0): Int64;

  function TryDecStr2Int(const s: string; out aValue: LongWord): Boolean; inline;
  function TryDecStr2Int(const s: string; out aValue: LongInt): Boolean; inline;
  function TryDecStr2Int(const s: string; out aValue: QWord): Boolean; inline;
  function TryDecStr2Int(const s: string; out aValue: Int64): Boolean; inline;

  function TryDecStr2DWordDef(const s: string; aDefault: DWord = 0): DWord; inline;
  function TryDecStr2IntDef(const s: string; aDefault: LongInt = 0): LongInt; inline;
  function TryDecStr2QWordDef(const s: string; aDefault: QWord = 0): QWord; inline;
  function TryDecStr2Int64Def(const s: string; aDefault: Int64 = 0): Int64; inline;

{ some support for digit group separators, only for strings in decimal notation;
  aSep is a separator for groups of digits(for example an underscore or an apostrophe);
    a separator can not be less than #32;
    the string cannot start with a separator;
    leading spaces and tabs are allowed;
    leading zeros are allowed;
    a minus sign is not allowed for unsigned integers;
    numerical value MUST fit into the range of the type of aValue;
  if the TryD...2Int() returns False, then aValue is undefined }
  function TryDgsChars2Int(const a: array of char; aSep: char; out aValue: LongWord): Boolean;
  function TryDgsChars2Int(const a: array of char; aSep: char; out aValue: LongInt): Boolean;
  function TryDgsChars2Int(const a: array of char; aSep: char; out aValue: QWord): Boolean;
  function TryDgsChars2Int(const a: array of char; aSep: char; out aValue: Int64): Boolean;

  function TryDgsChars2DWordDef(const a: array of char; aSep: char; aDefault: DWord = 0): DWord;
  function TryDgsChars2IntDef(const a: array of char; aSep: char; aDefault: LongInt = 0): LongInt;
  function TryDgsChars2QWordDef(const a: array of char; aSep: char; aDefault: QWord = 0): QWord;
  function TryDgsChars2Int64Def(const a: array of char; aSep: char; aDefault: Int64 = 0): Int64;

  function TryDgsStr2Int(const s: string; aSep: char; out aValue: LongWord): Boolean; inline;
  function TryDgsStr2Int(const s: string; aSep: char; out aValue: LongInt): Boolean; inline;
  function TryDgsStr2Int(const s: string; aSep: char; out aValue: QWord): Boolean; inline;
  function TryDgsStr2Int(const s: string; aSep: char; out aValue: Int64): Boolean; inline;

  function TryDgsStr2DWordDef(const s: string; aSep: char; aDefault: DWord = 0): DWord; inline;
  function TryDgsStr2IntDef(const s: string; aSep: char; aDefault: LongInt = 0): LongInt; inline;
  function TryDgsStr2QWordDef(const s: string; aSep: char; aDefault: QWord = 0): QWord; inline;
  function TryDgsStr2Int64Def(const s: string; aSep: char; aDefault: Int64 = 0): Int64; inline;

{ some support for unicodestring }
  function TryChars2Int(const a: array of widechar; out aValue: LongWord): Boolean;
  function TryChars2Int(const a: array of widechar; out aValue: LongInt): Boolean;
  function TryChars2Int(const a: array of widechar; out aValue: QWord): Boolean;
  function TryChars2Int(const a: array of widechar; out aValue: Int64): Boolean;

  function TryChars2DWordDef(const a: array of widechar; aDefault: DWord = 0): DWord;
  function TryChars2IntDef(const a: array of widechar; aDefault: LongInt = 0): LongInt;
  function TryChars2QWordDef(const a: array of widechar; aDefault: QWord = 0): QWord;
  function TryChars2Int64Def(const a: array of widechar; aDefault: Int64 = 0): Int64;

  function TryStr2Int(const s: unicodestring; out aValue: LongWord): Boolean; inline;
  function TryStr2Int(const s: unicodestring; out aValue: LongInt): Boolean; inline;
  function TryStr2Int(const s: unicodestring; out aValue: QWord): Boolean; inline;
  function TryStr2Int(const s: unicodestring; out aValue: Int64): Boolean; inline;

  function TryStr2DWordDef(const s: unicodestring; aDefault: DWord = 0): DWord; inline;
  function TryStr2IntDef(const s: unicodestring; aDefault: LongInt = 0): LongInt; inline;
  function TryStr2QWordDef(const s: unicodestring; aDefault: QWord = 0): QWord; inline;
  function TryStr2Int64Def(const s: unicodestring; aDefault: Int64 = 0): Int64; inline;

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

{$MACRO ON}
{$DEFINE MainCaseMacro :=
  case p^ of
    '$': Result := ConvFunMacro(p+1, aCount-1, TypeMacro rxHex, OutMacro);
    '%': Result := ConvFunMacro(p+1, aCount-1, TypeMacro rxBin, OutMacro);
    '&': Result := ConvFunMacro(p+1, aCount-1, TypeMacro rxOct, OutMacro);
    '0':
      begin
        if aCount = 1 then
          begin
            aValue := 0;
            exit(True);
          end;
{$IFDEF NEED_VAL_COMPAT}
        case p[1] of
          '0'..'9':
            begin
              SetDecTrueMacro
              Result := ConvFunMacro(p+1, aCount-1, TypeMacro rxDec, OutMacro);
            end;
          'X', 'x': Result := ConvFunMacro(p+2, aCount-2, TypeMacro rxHex, OutMacro);
        end;
{$ELSE }
        case p[1] of
          '0'..'9': Result := ConvFunMacro(p+1, aCount-1, TypeMacro rxOct, OutMacro);
          'B', 'b': Result := ConvFunMacro(p+2, aCount-2, TypeMacro rxBin, OutMacro);
          'O', 'o': Result := ConvFunMacro(p+2, aCount-2, TypeMacro rxOct, OutMacro);
          'X', 'x': Result := ConvFunMacro(p+2, aCount-2, TypeMacro rxHex, OutMacro);
        end;
{$ENDIF NEED_VAL_COMPAT}
      end;
    '1'..'9':
      begin
        SetDecTrueMacro
        Result := ConvFunMacro(p, aCount, TypeMacro rxDec, OutMacro);
      end;
    'X', 'x': Result := ConvFunMacro(p+1, aCount-1, TypeMacro rxHex, OutMacro)
end;
}

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
  {$DEFINE TypeMacro := aType,}{$DEFINE SetDecTrueMacro :=}
  {$DEFINE ConvFunMacro := Base2UInt}{$DEFINE OutMacro := aValue}
  MainCaseMacro;
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
  {$DEFINE TypeMacro := aType,}{$DEFINE SetDecTrueMacro := IsDec := True;}
  {$DEFINE ConvFunMacro := Base2UInt}{$DEFINE OutMacro := v}
  MainCaseMacro;
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

function PChar2UIntImpl(p: PChar; aCount: SizeInt; aRadix: TRadix; out aValue: DWord): Boolean;
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

{$PUSH}{$WARN 4079 OFF}
function PChar2UIntImpl(p: PChar; aCount: SizeInt; aRadix: TRadix; out aValue: QWord): Boolean;
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

generic function PChar2UInt<T>(p: PChar; aCount: SizeInt; out aValue: T): Boolean;
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
  {$DEFINE TypeMacro :=}{$DEFINE SetDecTrueMacro :=}
  {$DEFINE ConvFunMacro := PChar2UIntImpl}{$DEFINE OutMacro := aValue}
  MainCaseMacro;
end;

generic function PChar2SInt<TUInt, TSint>(p: PChar; aCount: SizeInt; out aValue: TSint): Boolean;
var
  v: TUInt;
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
  {$DEFINE TypeMacro :=}{$DEFINE SetDecTrueMacro := IsDec := True;}
  {$DEFINE ConvFunMacro := PChar2UIntImpl}{$DEFINE OutMacro := v}
  MainCaseMacro;
  if Result then
    if IsNeg then
      begin
        if v > Succ(TUInt(High(TSint))) then exit(False);
        aValue := -TSint(v);
      end
    else
      begin
        if IsDec and (v > TUInt(High(TSint))) then exit(False);
        aValue := TSint(v);
      end;
end;
{$MACRO OFF}

function TryChars2Int(const a: array of char; out aValue: Byte): Boolean;
var
  v: DWord;
begin
  if (Length(a) = 0) or not BaseParseUInt(@a[0], Length(a), int8, v) then exit(False);
  aValue := v;
  Result := True;
end;

function TryChars2Int(const a: array of char; out aValue: ShortInt): Boolean;
var
  v: LongInt;
begin
  if (Length(a) = 0) or not BaseParseSInt(@a[0], Length(a), int8, v) then exit(False);
  aValue := v;
  Result := True;
end;

function TryChars2Int(const a: array of char; out aValue: Word): Boolean;
var
  v: DWord;
begin
  if (Length(a) = 0) or not BaseParseUInt(@a[0], Length(a), int16, v) then exit(False);
  aValue := v;
  Result := True;
end;

function TryChars2Int(const a: array of char; out aValue: SmallInt): Boolean;
var
  v: LongInt;
begin
  if (Length(a) = 0) or not BaseParseSInt(@a[0], Length(a), int16, v) then exit(False);
  aValue := v;
  Result := True;
end;

function TryChars2Int(const a: array of char; out aValue: LongWord): Boolean;
begin
  if Length(a) = 0 then exit(False);
  Result := specialize PChar2UInt<DWord>(@a[0], Length(a), aValue);
end;

function TryChars2Int(const a: array of char; out aValue: LongInt): Boolean;
begin
  if Length(a) = 0 then exit(False);
  Result :=  specialize PChar2SInt<DWord, LongInt>(@a[0], Length(a), aValue);
end;

function TryChars2Int(const a: array of char; out aValue: QWord): Boolean;
begin
  if Length(a) = 0 then exit(False);
  Result := specialize PChar2UInt<QWord>(@a[0], Length(a), aValue);
end;

function TryChars2Int(const a: array of char; out aValue: Int64): Boolean;
begin
  if Length(a) = 0 then exit(False);
  Result := specialize PChar2SInt<QWord, Int64>(@a[0], Length(a), aValue);
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

{$PUSH}{$WARN 4079 OFF}
function Decimals2UInt(p, pEnd: PChar; out aValue: DWord): Boolean;
var
  v, t, Count: DWord;
begin
  //here assumed p < pEnd and p^ not in [#9, ' ', '-', '+']
  while p^ = '0' do
    begin
      Inc(p);
      if p = pEnd then
        begin
          aValue := 0;
          exit(True);
        end;
    end;
  Count := pEnd - p;
  if Count > 10 then exit(False);
  v := 0;
{$IFDEF FPC_REQUIRES_PROPER_ALIGNMENT}
{$PUSH}{$WARN 4055 OFF}
  if SizeUInt(p) and 3 = 0 then
{$POP}
{$ENDIF FPC_REQUIRES_PROPER_ALIGNMENT}
  while p + 4 < pEnd do
    begin
      t := PDWord(p)^;
      {$IFDEF ENDIAN_BIG}SwapEndian(t);{$ENDIF ENDIAN_BIG}
      if t and DWord($F0F0F0F0) <> DWord($30303030) then exit(False);
      t -= DWord($30303030);
      if (t + DWord($06060606)) and DWord($F0F0F0F0) <> 0 then exit(False);
      v := v * 10000 + DWord((((PByte(@t)[0] * 10) + PByte(@t)[1])* 10 + PByte(@t)[2])* 10 + PByte(@t)[3]);
      Inc(p, 4);
    end;
  while p < pEnd do
    begin
      t := Table[p^];
      if t > 9 then exit(False);
      v := v * 10 + t;
      Inc(p);
    end;
  if (Count = 10) and (v < 1000000000) then exit(False);
  aValue := v;
  Result := True;
end;
{$POP}

function TryDecimals2Int(const a: array of char; out aValue: LongWord): Boolean;
var
  p, pEnd: PChar;
begin
  if Length(a) = 0 then exit(False);
  p := @a[0];
  pEnd := p + Length(a);
  while (p < pEnd) and (p^ in [#9, ' ']) do Inc(p);
  if p = pEnd then exit(False);
  if p^ = '+' then
    begin
      Inc(p);
      if p = pEnd then exit(False);
    end;
  Result := Decimals2UInt(p, pEnd, aValue);
end;

function TryDecimals2Int(const a: array of char; out aValue: LongInt): Boolean;
var
  p, pEnd: PChar;
  v: DWord;
  IsNeg: Boolean;
begin
  if Length(a) = 0 then exit(False);
  p := @a[0];
  pEnd := p + Length(a);
  while (p < pEnd) and (p^ in [#9, ' ']) do Inc(p);
  if p = pEnd then exit(False);
  if p^ = '-' then
    begin
      IsNeg := True;
      Inc(p);
      if p = pEnd then exit(False);
    end
  else
    begin
      IsNeg := False;
      if p^ = '+' then
        begin
          Inc(p);
          if p = pEnd then exit(False);
        end;
    end;
  Result := Decimals2UInt(p, pEnd, v);
  if Result then
    if IsNeg then
      begin
        if v > DWord(2147483648) then exit(False);
        aValue := -LongInt(v);
      end
    else
      begin
        if v > 2147483647 then exit(False);
        aValue := LongInt(v);
      end;
end;

function Decimals2UInt(p, pEnd: PChar; out aValue: QWord): Boolean;
var
  v{$IFDEF CPU64}, tQ{$ENDIF}: QWord;
  t, Count: DWord;
begin
  //here assumed p < pEnd and p^ not in [#9, ' ', '-', '+']
  while p^ = '0' do
    begin
      Inc(p);
      if p = pEnd then
        begin
          aValue := 0;
          exit(True);
        end;
    end;
  Count := pEnd - p;
  if Count > 20 then exit(False);
  v := 0;
{$IFDEF FPC_REQUIRES_PROPER_ALIGNMENT}
{$PUSH}{$WARN 4055 OFF}
{$IFDEF CPU64}
  case SizeUInt(p) and 7 of
    0:
      begin
        while p + 8 < pEnd do
          begin
            tQ := PQWord(p)^;
            {$IFDEF ENDIAN_BIG}SwapEndian(t8);{$ENDIF ENDIAN_BIG}
            if tQ and QWord($F0F0F0F0F0F0F0F0) <> QWord($3030303030303030) then exit(False);
            tQ -= QWord($3030303030303030);
            if (tQ + QWord($0606060606060606)) and QWord($F0F0F0F0F0F0F0F0) <> 0 then exit(False);
            v := v * 100000000 + (((((((PByte(@tQ)[0] * 10) + PByte(@tQ)[1])* 10 + PByte(@tQ)[2])* 10 +
              PByte(@tQ)[3])* 10 + PByte(@tQ)[4])* 10 + PByte(@tQ)[5])* 10 + PByte(@tQ)[6])* 10 + PByte(@tQ)[7];
            Inc(p, 8);
          end;
        while p + 4 < pEnd do
          begin
            t := PDWord(p)^;
            {$IFDEF ENDIAN_BIG}SwapEndian(t);{$ENDIF ENDIAN_BIG}
            if t and DWord($F0F0F0F0) <> DWord($30303030) then exit(False);
            t -= DWord($30303030);
            if (t + DWord($06060606)) and DWord($F0F0F0F0) <> 0 then exit(False);
            v := v * 10000 + ((((PByte(@t)[0] * 10) + PByte(@t)[1])* 10 + PByte(@t)[2])* 10 + PByte(@t)[3]);
            Inc(p, 4);
          end;
      end;
    4:
      while p + 4 < pEnd do
        begin
          t := PDWord(p)^;
          {$IFDEF ENDIAN_BIG}SwapEndian(t);{$ENDIF ENDIAN_BIG}
          if t and DWord($F0F0F0F0) <> DWord($30303030) then exit(False);
          t -= DWord($30303030);
          if (t + DWord($06060606)) and DWord($F0F0F0F0) <> 0 then exit(False);
          v := v * 10000 + ((((PByte(@t)[0] * 10) + PByte(@t)[1])* 10 + PByte(@t)[2])* 10 + PByte(@t)[3]);
          Inc(p, 4);
        end;
  else
  end;
{$ELSE CPU64}
  if SizeUInt(p) and 3 = 0 then
    while p + 4 < pEnd do
      begin
        t := PDWord(p)^;
        {$IFDEF ENDIAN_BIG}SwapEndian(t);{$ENDIF ENDIAN_BIG}
        if t and DWord($F0F0F0F0) <> DWord($30303030) then exit(False);
        t -= DWord($30303030);
        if (t + DWord($06060606)) and DWord($F0F0F0F0) <> 0 then exit(False);
        v := v * 10000 + ((((PByte(@t)[0] * 10) + PByte(@t)[1])* 10 + PByte(@t)[2])* 10 + PByte(@t)[3]);
        Inc(p, 4);
      end;
{$ENDIF CPU64}
{$POP}
{$ELSE FPC_REQUIRES_PROPER_ALIGNMENT}
{$IFDEF CPU64}
  while p + 8 < pEnd do
    begin
      tQ := PQWord(p)^;
      {$IFDEF ENDIAN_BIG}SwapEndian(t8);{$ENDIF ENDIAN_BIG}
      if tQ and QWord($F0F0F0F0F0F0F0F0) <> QWord($3030303030303030) then exit(False);
      tQ -= QWord($3030303030303030);
      if (tQ + QWord($0606060606060606)) and QWord($F0F0F0F0F0F0F0F0) <> 0 then exit(False);
      v := v * 100000000 + (((((((PByte(@tQ)[0] * 10) + PByte(@tQ)[1])* 10 + PByte(@tQ)[2])* 10 +
        PByte(@tQ)[3])* 10 + PByte(@tQ)[4])* 10 + PByte(@tQ)[5])* 10 + PByte(@tQ)[6])* 10 + PByte(@tQ)[7];
      Inc(p, 8);
    end;
{$ENDIF CPU64}
  while p + 4 < pEnd do
    begin
      t := PDWord(p)^;
      {$IFDEF ENDIAN_BIG}SwapEndian(t);{$ENDIF ENDIAN_BIG}
      if t and DWord($F0F0F0F0) <> DWord($30303030) then exit(False);
      t -= DWord($30303030);
      if (t + DWord($06060606)) and DWord($F0F0F0F0) <> 0 then exit(False);
      v := v * 10000 + ((((PByte(@t)[0] * 10) + PByte(@t)[1])* 10 + PByte(@t)[2])* 10 + PByte(@t)[3]);
      Inc(p, 4);
    end;
{$ENDIF FPC_REQUIRES_PROPER_ALIGNMENT}
  while p < pEnd do
    begin
      t := Table[p^];
      if t > 9 then exit(False);
      v := v * 10 + t;
      Inc(p);
    end;
  if (Count = 20) and (v < QWord(10000000000000000000)) then exit(False);
  aValue := v;
  Result := True;
end;

function TryDecimals2Int(const a: array of char; out aValue: QWord): Boolean;
var
  p, pEnd: PChar;
begin
  if Length(a) = 0 then exit(False);
  p := @a[0];
  pEnd := p + Length(a);
  while (p < pEnd) and (p^ in [#9, ' ']) do Inc(p);
  if p = pEnd then exit(False);
  if p^ = '+' then
    begin
      Inc(p);
      if p = pEnd then exit(False);
    end;
  Result := Decimals2UInt(p, pEnd, aValue);
end;

function TryDecimals2Int(const a: array of char; out aValue: Int64): Boolean;
var
  p, pEnd: PChar;
  v: QWord;
  IsNeg: Boolean;
begin
  if Length(a) = 0 then exit(False);
  p := @a[0];
  pEnd := p + Length(a);
  while (p < pEnd) and (p^ in [#9, ' ']) do Inc(p);
  if p = pEnd then exit(False);
  if p^ = '-' then
    begin
      IsNeg := True;
      Inc(p);
      if p = pEnd then exit(False);
    end
  else
    begin
      IsNeg := False;
      if p^ = '+' then
        begin
          Inc(p);
          if p = pEnd then exit(False);
        end;
    end;
  Result := Decimals2UInt(p, pEnd, v);
  if Result then
    if IsNeg then
      begin
        if v > QWord(9223372036854775808) then exit(False);
        aValue := -Int64(v);
      end
    else
      begin
        if v > QWord(9223372036854775807) then exit(False);
        aValue := Int64(v);
      end;
end;

function TryDecimals2DWordDef(const a: array of char; aDefault: LongWord): DWord;
begin
  if not TryDecimals2Int(a, Result) then
    Result := aDefault;
end;

function TryDecimals2IntDef(const a: array of char; aDefault: LongInt): Int64;
begin
  if not TryDecimals2Int(a, Result) then
    Result := aDefault;
end;

function TryDecimals2QWordDef(const a: array of char; aDefault: QWord): QWord;
begin
  if not TryDecimals2Int(a, Result) then
    Result := aDefault;
end;

function TryDecimals2Int64Def(const a: array of char; aDefault: Int64): Int64;
begin
  if not TryDecimals2Int(a, Result) then
    Result := aDefault;
end;

function TryDecStr2Int(const s: string; out aValue: LongWord): Boolean;
begin
  Result := TryDecimals2Int(s[1..Length(s)], aValue);
end;

function TryDecStr2Int(const s: string; out aValue: LongInt): Boolean;
begin
  Result := TryDecimals2Int(s[1..Length(s)], aValue);
end;

function TryDecStr2Int(const s: string; out aValue: QWord): Boolean;
begin
  Result := TryDecimals2Int(s[1..Length(s)], aValue);
end;

function TryDecStr2Int(const s: string; out aValue: Int64): Boolean;
begin
  Result := TryDecimals2Int(s[1..Length(s)], aValue);
end;

function TryDecStr2DWordDef(const s: string; aDefault: DWord): DWord;
begin
  if not TryDecimals2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TryDecStr2IntDef(const s: string; aDefault: LongInt): LongInt;
begin
  if not TryDecimals2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TryDecStr2QWordDef(const s: string; aDefault: QWord): QWord;
begin
  if not TryDecimals2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TryDecStr2Int64Def(const s: string; aDefault: Int64): Int64;
begin
  if not TryDecimals2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function DecPChar2UIntImpl(p: PChar; aCount: SizeInt; aSep: Char; out aValue: DWord): Boolean;
var
{$IFDEF CPU64}
  v: QWord;
  I, t: DWord;
{$ELSE}
  I, v, t: DWord;
{$ENDIF}
  pEnd: PChar;
begin
  // here assumed aCount > 0 and p^ is a decimal char
  v := Table[p^];
  pEnd := p + aCount;
  Inc(p);
  I := 1;
  while p < pEnd do
    begin
      if p^ = aSep then
        begin
          Inc(p);
          continue;
        end;
      if I = 10 then exit(False);
      t := Table[p^];
      if t > 9 then exit(False);
      v := v * 10 + t;
      Inc(p);
      Inc(I);
    end;
{$IFDEF CPU64}
  if v > High(DWord) then exit(False);
{$ELSE}
  if (I = 10) and (v < 1000000000) then exit(False);
{$ENDIF}
  aValue := v;
  Result := True;
end;

{$PUSH}{$WARN 4079 OFF}
function DecPChar2UIntImpl(p: PChar; aCount: SizeInt; aSep: char; out aValue: QWord): Boolean;
var
  v: QWord;
  I, t: DWord;
  pEnd: PChar;
begin
  // here assumed aCount > 0 and p^ is a decimal char
  v := Table[p^];
  pEnd := p + aCount;
  Inc(p);
  I := 1;
  while p < pEnd do
    begin
      if p^ = aSep then
        begin
          Inc(p);
          continue;
        end;
      if I = 20 then exit(False);
      t := Table[p^];
      if t > 9 then exit(False);
{$IFDEF CPU64}
      v := v * 10 + t;
{$ELSE}
      if I < 9 then
        v := DWord(v) * 10 + t
      else
        v := v * 10 + t;
{$ENDIF}
      Inc(p);
      Inc(I);
    end;
  if (I = 20) and (v < QWord(10000000000000000000)) then exit(False);
  aValue := v;
  Result := True;
end;
{$POP}

generic function DecPChar2UInt<T>(p: PChar; aCount: SizeInt; aSep: char; out aValue: T): Boolean;
begin
  //here assumed aCount > 0
  while p^ in [#9, ' '] do
    begin
      Inc(p);
      Dec(aCount);
      if aCount = 0 then exit(False);
    end;
  if p^ = '+' then
    begin
      Inc(p);
      Dec(aCount);
      if aCount = 0 then exit(False);
    end;
  if p^ = '0' then
  begin
    repeat
      Inc(p);
      Dec(aCount);
    until (aCount = 0) or not(p^ in ['0', aSep]);
    if aCount = 0 then
      begin
        aValue := 0;
        exit(True);
      end;
  end;
  if not (p^ in ['1'..'9']) then exit(False);
  Result := DecPChar2UIntImpl(p, aCount, aSep, aValue);
end;

generic function DecPChar2SInt<TUInt, TSint>(p: PChar; aCount: SizeInt; aSep: char; out aValue: TSint): Boolean;
var
  v: TUInt;
  IsNeg: Boolean;
begin
  //here assumed aCount > 0
  while p^ in [#9, ' '] do
    begin
      Inc(p);
      Dec(aCount);
      if aCount = 0 then exit(False);
    end;
  if p^ = '-' then
    begin
      IsNeg := True;
      Inc(p);
      Dec(aCount);
      if aCount = 0 then exit(False);
    end
  else
    begin
      IsNeg := False;
      if p^ = '+' then
        begin
          Inc(p);
          Dec(aCount);
          if aCount = 0 then exit(False);
        end;
    end;
  if p^ = '0' then
    begin
      repeat
        Inc(p);
        Dec(aCount);
      until (aCount = 0) or not(p^ in ['0', aSep]);
      if aCount = 0 then
        begin
          aValue := 0;
          exit(True);
        end;
    end;
  if not (p^ in ['1'..'9']) then exit(False);
  v := 0;
  Result := DecPChar2UIntImpl(p, aCount, aSep, v);
  if Result then
    if IsNeg then
      begin
        if v > Succ(TUInt(High(TSint))) then exit(False);
        aValue := -TSint(v);
      end
    else
      begin
        if v > TUInt(High(TSint)) then exit(False);
        aValue := TSint(v);
      end;
end;

function TryDgsChars2Int(const a: array of char; aSep: char; out aValue: LongWord): Boolean;
begin
  if (Length(a) = 0) or (aSep < ' ') then exit(False);
  Result := specialize DecPChar2UInt<LongWord>(@a[0], Length(a), aSep, aValue);
end;

function TryDgsChars2Int(const a: array of char; aSep: char; out aValue: LongInt): Boolean;
begin
  if (Length(a) = 0) or (aSep < ' ') then exit(False);
  Result := specialize DecPChar2SInt<DWord, LongInt>(@a[0], Length(a), aSep, aValue);
end;

function TryDgsChars2Int(const a: array of char; aSep: char; out aValue: QWord): Boolean;
begin
  if (Length(a) = 0) or (aSep < ' ') then exit(False);
  Result := specialize DecPChar2UInt<QWord>(@a[0], Length(a), aSep, aValue);
end;

function TryDgsChars2Int(const a: array of char; aSep: char; out aValue: Int64): Boolean;
begin
  if (Length(a) = 0) or (aSep < ' ') then exit(False);
  Result := specialize DecPChar2SInt<QWord, Int64>(@a[0], Length(a), aSep, aValue);
end;

function TryDgsChars2DWordDef(const a: array of char; aSep: char; aDefault: DWord): DWord;
begin
  if not TryDgsChars2Int(a, aSep, Result) then
    Result := aDefault;
end;

function TryDgsChars2IntDef(const a: array of char; aSep: char; aDefault: LongInt): LongInt;
begin
  if not TryDgsChars2Int(a, aSep, Result) then
    Result := aDefault;
end;

function TryDgsChars2QWordDef(const a: array of char; aSep: char; aDefault: QWord): QWord;
begin
  if not TryDgsChars2Int(a, aSep, Result) then
    Result := aDefault;
end;

function TryDgsChars2Int64Def(const a: array of char; aSep: char; aDefault: Int64): Int64;
begin
  if not TryDgsChars2Int(a, aSep, Result) then
    Result := aDefault;
end;

function TryDgsStr2Int(const s: string; aSep: char; out aValue: LongWord): Boolean;
begin
  Result := TryDgsChars2Int(s[1..Length(s)], aSep, aValue);
end;

function TryDgsStr2Int(const s: string; aSep: char; out aValue: LongInt): Boolean;
begin
  Result := TryDgsChars2Int(s[1..Length(s)], aSep, aValue);
end;

function TryDgsStr2Int(const s: string; aSep: char; out aValue: QWord): Boolean;
begin
  Result := TryDgsChars2Int(s[1..Length(s)], aSep, aValue);
end;

function TryDgsStr2Int(const s: string; aSep: char; out aValue: Int64): Boolean;
begin
  Result := TryDgsChars2Int(s[1..Length(s)], aSep, aValue);
end;

function TryDgsStr2DWordDef(const s: string; aSep: char; aDefault: DWord): DWord;
begin
  if not TryDgsChars2Int(s[1..Length(s)], aSep, Result) then
    Result := aDefault;
end;

function TryDgsStr2IntDef(const s: string; aSep: char; aDefault: LongInt): LongInt;
begin
  if not TryDgsChars2Int(s[1..Length(s)], aSep, Result) then
    Result := aDefault;
end;

function TryDgsStr2QWordDef(const s: string; aSep: char; aDefault: QWord): QWord;
begin
  if not TryDgsChars2Int(s[1..Length(s)], aSep, Result) then
    Result := aDefault;
end;

function TryDgsStr2Int64Def(const s: string; aSep: char; aDefault: Int64): Int64;
begin
  if not TryDgsChars2Int(s[1..Length(s)], aSep, Result) then
    Result := aDefault;
end;

function PWChar2UIntImpl(p: PWideChar; aCount: SizeInt; aRadix: TRadix; out aValue: DWord): Boolean;
var
{$IFDEF CPU64}
  v: QWord;
  Base, t: DWord;
{$ELSE}
  Base, v, t: DWord;
{$ENDIF}
  pEnd: PWideChar;
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
  if p^ > #$ff then exit(False);
  Base := Bases[aRadix];
  v := Table[p^];
  if v >= Base then exit(False);
  pEnd := p + aCount;
  Inc(p);
{$IFDEF CPU64}
  while p < pEnd do
    begin
      if p^ > #$ff then exit(False);
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
        if p^ > #$ff then exit(False);
        t := Table[p^];
        if t >= Base then exit(False);
        v := v * Base + t;
        Inc(p);
      end
  else
    begin
      while p < pEnd - 1 do
        begin
          if p^ > #$ff then exit(False);
          t := Table[p^];
          if t >= Base then exit(False);
          v := v * Base + t;
          Inc(p);
        end;
      if v > Int32PrevMax[aRadix] then exit(False);
      if p^ > #$ff then exit(False);
      t := Table[p^];
      if t >= Base then exit(False);
      v := v * Base + t;
      if v < t then exit(False);
    end;
{$ENDIF}
  aValue := v;
  Result := True;
end;

{$PUSH}{$WARN 4079 OFF}
function PWChar2UIntImpl(p: PWideChar; aCount: SizeInt; aRadix: TRadix; out aValue: QWord): Boolean;
var
  v: QWord;
  Base, t: DWord;
  pEnd: PWideChar;
{$IFNDEF CPU64}
  pDw: PWideChar;
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
  if p^ > #$ff then exit(False);
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
        if p^ > #$ff then exit(False);
        t := Table[p^];
        if t >= Base then exit(False);
        v := v * Base + t;
        Inc(p);
      end
  else
    begin
      while p < pEnd - 1 do
        begin
          if p^ > #$ff then exit(False);
          t := Table[p^];
          if t >= Base then exit(False);
          v := v * Base + t;
          Inc(p);
        end;
      if v > Int64PrevMax[aRadix] then exit(False);
      if p^ > #$ff then exit(False);
      t := Table[p^];
      if t >= Base then exit(False);
      v := v * Base + t;
      if v < t then exit(False);
    end;
{$ELSE}
  if (aCount < Int64MaxLen[aRadix]) or (aRadix in [rxBin, rxHex]) then
    while p < pEnd do
      begin
        if p^ > #$ff then exit(False);
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
          if p^ > #$ff then exit(False);
          t := Table[p^];
          if t >= Base then exit(False);
          v := DWord(v) * Base + t;
            Inc(p);
        end;
      while p < pEnd - 1 do
        begin
          if p^ > #$ff then exit(False);
          t := Table[p^];
          if t >= Base then exit(False);
          v := v * Base + t;
          Inc(p);
        end;
      if v > Int64PrevMax[aRadix] then exit(False);
      if p^ > #$ff then exit(False);
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

{$MACRO ON}
generic function PWChar2UInt<T>(p: PWideChar; aCount: SizeInt; out aValue: T): Boolean;
begin
  Result := False;
  //here assumed aCount > 0
  while (p^ = #9) or (p^ = ' ') do
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
  {$DEFINE TypeMacro :=}{$DEFINE SetDecTrueMacro :=}
  {$DEFINE ConvFunMacro := PWChar2UIntImpl}{$DEFINE OutMacro := aValue}
  MainCaseMacro;
end;

generic function PWChar2SInt<TUInt, TSint>(p: PWideChar; aCount: SizeInt; out aValue: TSint): Boolean;
var
  v: TUInt;
  IsNeg, IsDec: Boolean;
begin
  Result := False;
  //here assumed aCount > 0
  while (p^ = #9) or (p^ = ' ') do
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
  {$DEFINE TypeMacro :=}{$DEFINE SetDecTrueMacro := IsDec := True;}
  {$DEFINE ConvFunMacro := PWChar2UIntImpl}{$DEFINE OutMacro := v}
  MainCaseMacro;
  if Result then
    if IsNeg then
      begin
        if v > Succ(TUInt(High(TSint))) then exit(False);
        aValue := -TSint(v);
      end
    else
      begin
        if IsDec and (v > TUInt(High(TSint))) then exit(False);
        aValue := TSint(v);
      end;
end;
{$MACRO OFF}

function TryChars2Int(const a: array of widechar; out aValue: LongWord): Boolean;
begin
  if Length(a) = 0 then exit(False);
  Result := specialize PWChar2UInt<DWord>(@a[0], Length(a), aValue);
end;

function TryChars2Int(const a: array of widechar; out aValue: LongInt): Boolean;
begin
  if Length(a) = 0 then exit(False);
  Result :=  specialize PWChar2SInt<DWord, LongInt>(@a[0], Length(a), aValue);
end;

function TryChars2Int(const a: array of widechar; out aValue: QWord): Boolean;
begin
  if Length(a) = 0 then exit(False);
  Result := specialize PWChar2UInt<QWord>(@a[0], Length(a), aValue);
end;

function TryChars2Int(const a: array of widechar; out aValue: Int64): Boolean;
begin
  if Length(a) = 0 then exit(False);
  Result :=  specialize PWChar2SInt<QWord, Int64>(@a[0], Length(a), aValue);
end;

function TryChars2DWordDef(const a: array of widechar; aDefault: DWord): DWord;
begin
  if not TryChars2Int(a, Result) then
    Result := aDefault;
end;

function TryChars2IntDef(const a: array of widechar; aDefault: LongInt): LongInt;
begin
  if not TryChars2Int(a, Result) then
    Result := aDefault;
end;

function TryChars2QWordDef(const a: array of widechar; aDefault: QWord): QWord;
begin
  if not TryChars2Int(a, Result) then
    Result := aDefault;
end;

function TryChars2Int64Def(const a: array of widechar; aDefault: Int64): Int64;
begin
  if not TryChars2Int(a, Result) then
    Result := aDefault;
end;

function TryStr2Int(const s: unicodestring; out aValue: LongWord): Boolean;
begin
  Result := TryChars2Int(s[1..Length(s)], aValue);
end;

function TryStr2Int(const s: unicodestring; out aValue: LongInt): Boolean;
begin
  Result := TryChars2Int(s[1..Length(s)], aValue);
end;

function TryStr2Int(const s: unicodestring; out aValue: QWord): Boolean;
begin
  Result := TryChars2Int(s[1..Length(s)], aValue);
end;

function TryStr2Int(const s: unicodestring; out aValue: Int64): Boolean;
begin
  Result := TryChars2Int(s[1..Length(s)], aValue);
end;

function TryStr2DWordDef(const s: unicodestring; aDefault: DWord): DWord;
begin
  if not TryChars2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TryStr2IntDef(const s: unicodestring; aDefault: LongInt): LongInt;
begin
  if not TryChars2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TryStr2QWordDef(const s: unicodestring; aDefault: QWord): QWord;
begin
  if not TryChars2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

function TryStr2Int64Def(const s: unicodestring; aDefault: Int64): Int64;
begin
  if not TryChars2Int(s[1..Length(s)], Result) then
    Result := aDefault;
end;

end.

