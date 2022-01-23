unit main;

{$mode objfpc}{$H+}

{.$DEFINE NEED_VAL_COMPAT}

interface

uses
  Classes, SysUtils, fpcunit, testregistry, Str2IntAlter;

type

  { TTestS2I }

  TTestS2I = class(TTestCase)
  published
    procedure Reject;
    procedure TestByte;
    procedure TestShortInt;
    procedure TestWord;
    procedure TestSmallInt;
    procedure TestDWord;
    procedure TestLongInt;
    procedure TestQWord;
    procedure TestInt64;
    procedure TestDWordWithSeparator;
    procedure TestLongIntWithSeparator;
    procedure TestQWordWithSeparator;
    procedure TestInt64WithSeparator;
  end;

implementation

{$PUSH}{$MACRO ON}
{$DEFINE FullRejectMacro :=
  s := '';
  AssertEquals('empty string to '+TypMacro, False, TryChars2Int(s[1..Length(s)], AnyArgMacro));
  s := '   ';
  AssertEquals('string of spaces to '+TypMacro, False, TryChars2Int(s[1..Length(s)], AnyArgMacro));
  s := '+';
  AssertEquals('single plus to '+TypMacro, False, TryChars2Int(s[1..Length(s)], AnyArgMacro));
  s := '-';
  AssertEquals('single minus to '+TypMacro, False, TryChars2Int(s[1..Length(s)], AnyArgMacro));
  s := '0x';
  AssertEquals('single 0x prefix to '+TypMacro, False, TryChars2Int(s[1..Length(s)], AnyArgMacro));
  s := '0X';
  AssertEquals('single 0X prefix to '+TypMacro, False, TryChars2Int(s[1..Length(s)], AnyArgMacro));
  s := 'X';
  AssertEquals('single X prefix to '+TypMacro, False, TryChars2Int(s[1..Length(s)], AnyArgMacro));
  s := 'x';
  AssertEquals('single x prefix to '+TypMacro, False, TryChars2Int(s[1..Length(s)], AnyArgMacro));
  s := '&';
  AssertEquals('single & prefix to '+TypMacro, False, TryChars2Int(s[1..Length(s)], AnyArgMacro));
  s := '0o';
  AssertEquals('single 0o prefix to '+TypMacro, False, TryChars2Int(s[1..Length(s)], AnyArgMacro));
  s := '0O';
  AssertEquals('single 0O prefix to '+TypMacro, False, TryChars2Int(s[1..Length(s)], AnyArgMacro));
  s := '%';
  AssertEquals('single % prefix to '+TypMacro, False, TryChars2Int(s[1..Length(s)], AnyArgMacro));
  s := '0b';
  AssertEquals('single 0b prefix to '+TypMacro, False, TryChars2Int(s[1..Length(s)], AnyArgMacro));
  s := '0B';
  AssertEquals('single 0B prefix to '+TypMacro, False, TryChars2Int(s[1..Length(s)], AnyArgMacro));
  s := '1u';
  AssertEquals('garbage symbol u to '+TypMacro, False, TryChars2Int(s[1..Length(s)], AnyArgMacro));
  s := '1 ';
  AssertEquals('garbage space to '+TypMacro, False, TryChars2Int(s[1..Length(s)], AnyArgMacro));
}

procedure TTestS2I.Reject;
var
  s: string;
  b: Byte;
  i8: ShortInt;
  w: Word;
  i16: SmallInt;
  d: DWord;
  i: LongInt;
  q: QWord;
  i64: Int64;
begin
  {$DEFINE AnyArgMacro := b}{$DEFINE TypMacro := 'Byte'}
  FullRejectMacro;
  {$DEFINE AnyArgMacro := i8}{$DEFINE TypMacro := 'ShortInt'}
  FullRejectMacro;
  {$DEFINE AnyArgMacro := w}{$DEFINE TypMacro := 'Word'}
  FullRejectMacro;
  {$DEFINE AnyArgMacro := i16}{$DEFINE TypMacro := 'SmallInt'}
  FullRejectMacro;
  {$DEFINE AnyArgMacro := d}{$DEFINE TypMacro := 'DWord'}
  FullRejectMacro;
  {$DEFINE AnyArgMacro := i}{$DEFINE TypMacro := 'LongInt'}
  FullRejectMacro;
  {$DEFINE AnyArgMacro := q}{$DEFINE TypMacro := 'QWord'}
  FullRejectMacro;
  {$DEFINE AnyArgMacro := i64}{$DEFINE TypMacro := 'Int64'}
  FullRejectMacro;
  s := '-7';
  AssertEquals('convert negative value to Byte', False, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert negative value to Word', False, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert negative value to DWord', False, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert negative value to QWord', False, TryChars2Int(s[1..Length(s)], q));
end;
{$POP}

procedure TTestS2I.TestByte;
var
  s: string;
  b: Byte;
begin
  s := '+0000';
  b := 42;
  AssertEquals('convert "+0000" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "+0000" to Byte, result', 0, b);

  s := '+255';
  AssertEquals('convert "+255" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "+255" to Byte, result', 255, b);
  s := '256';
  AssertEquals('convert "256" to Byte', False, TryChars2Int(s[1..Length(s)], b));
  s := #32#9'255';
  AssertEquals('convert #32#9"255" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert 255 to Byte, result', 255, b);

  s := '+%11111111';
  AssertEquals('convert "+%11111111" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "+%11111111" to Byte, result', 255, b);
  s := '%100000000';
  AssertEquals('convert "%100000000" to Byte', False, TryChars2Int(s[1..Length(s)], b));
  s := #32#9'%0011111111';
  AssertEquals('convert "#32#9%0011111111" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "#32#9%0011111111" to Byte, result', 255, b);
  s := '%0000';
  AssertEquals('convert "%0000" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "%0000" to Byte, result', 0, b);
{$IFNDEF NEED_VAL_COMPAT}
  s := '+0b11111111';
  AssertEquals('convert "+0b11111111" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "+0b11111111" to Byte, result', 255, b);
  s := '0b100000000';
  AssertEquals('convert "0b100000000 to Byte', False, TryChars2Int(s[1..Length(s)], b));
  s := #32#9'0b0011111111';
  AssertEquals('convert "#32#90b0011111111" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "#32#90b0011111111" to Byte, result', 255, b);
  s := '0b0000';
  AssertEquals('convert "0b0000" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "0b0000" to Byte, result', 0, b);

  s := '+0B11111111';
  AssertEquals('convert "+0B11111111" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "+0B11111111" to Byte, result', 255, b);
  s := '0B100000000';
  AssertEquals('convert "0B100000000" to Byte', False, TryChars2Int(s[1..Length(s)], b));
  s := #32#9'+0B0011111111';
  AssertEquals('convert "#32#9+0B0011111111" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "#32#9+0B0011111111" to Byte, result', 255, b);
  s := '0B0000';
  AssertEquals('convert "0B0000" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "0B0000" to Byte, result', 0, b);
{$ENDIF NEED_VAL_COMPAT}
  s := '+&377';
  AssertEquals('convert "+&377" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "+&0377" to Byte, result', 255, b);
  s := '&400';
  AssertEquals('convert "&400" to Byte', False, TryChars2Int(s[1..Length(s)], b));
  s := #32#9'&00377';
  AssertEquals('convert "#32#9&00377" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "#32#9&00377" to Byte, result', 255, b);
  s := '&0000';
  AssertEquals('convert "&0000" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "&0000" to Byte, result', 0, b);
{$IFNDEF NEED_VAL_COMPAT}
  s := '+0377';
  AssertEquals('convert "+0377" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "+0377" to Byte, result', 255, b);
  s := '0400';
  AssertEquals('convert "0400" to Byte', False, TryChars2Int(s[1..Length(s)], b));
  s := #32#9'0377';
  AssertEquals('convert "#32#90377" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "#32#90377" to Byte, result', 255, b);

  s := '+0o377';
  AssertEquals('convert "+0o377" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "+0o377" to Byte, result', 255, b);
  s := '0o400';
  AssertEquals('convert "0o400" to Byte', False, TryChars2Int(s[1..Length(s)], b));
  s := #32#9'0o00377';
  AssertEquals('convert "#32#90o00377" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "#32#90o00377" to Byte, result', 255, b);
  s := '0o0000';
  AssertEquals('convert "0o0000" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "0o0000" to Byte, result', 0, b);

  s := '+0O377';
  AssertEquals('convert "+0O377" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "+0O377" to Byte, result', 255, b);
  s := '0O400';
  AssertEquals('convert "0O400" to Byte', False, TryChars2Int(s[1..Length(s)], b));
  s := #32#9'0O00377';
  AssertEquals('convert "#32#90O00377" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "#32#90O00377" to Byte, result', 255, b);
  s := '0O0000';
  AssertEquals('convert "0O0000" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "0O0000" to Byte, result', 0, b);
{$ENDIF NEED_VAL_COMPAT}
  s := '+$ff';
  AssertEquals('convert "+$ff" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "+$ff" to Byte, result', 255, b);
  s := '$100';
  AssertEquals('convert "$100" to Byte', False, TryChars2Int(s[1..Length(s)], b));
  s := #32#9'$00ff';
  AssertEquals('convert "#32#9$00ff" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "#32#9$00ff" to Byte, result', 255, b);
  s := '$0000';
  AssertEquals('convert "$0000" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "$0000" to Byte, result', 0, b);

  s := '+0xff';
  AssertEquals('convert "+0xff" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "+0xff" to Byte, result', 255, b);
  s := '0x100';
  AssertEquals('convert "0x100" to Byte', False, TryChars2Int(s[1..Length(s)], b));
  s := #32#9'0x00ff';
  AssertEquals('convert "#32#90x00ff" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "#32#90x00ff" to Byte, result', 255, b);
  s := '0x0000';
  AssertEquals('convert "0x0000" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "0x0000" to Byte, result', 0, b);

  s := '+0Xff';
  AssertEquals('convert "+0Xff" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "+0Xff" to Byte, result', 255, b);
  s := '0X100';
  AssertEquals('convert "0X100" to Byte', False, TryChars2Int(s[1..Length(s)], b));
  s := #32#9'0X00ff';
  AssertEquals('convert "#32#90X00ff" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "#32#90X00ff" to Byte, result', 255, b);
  s := '0X0000';
  AssertEquals('convert "0X0000" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "0X0000" to Byte, result', 0, b);

  s := '+xff';
  AssertEquals('convert "+xff" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "+xff" to Byte, result', 255, b);
  s := 'x100';
  AssertEquals('convert "x100" to Byte', False, TryChars2Int(s[1..Length(s)], b));
  s := #32#9'x00ff';
  AssertEquals('convert "#32#9x00ff" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "#32#9x00ff" to Byte, result', 255, b);
  s := 'x0000';
  AssertEquals('convert "x0000" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "x0000" to Byte, result', 0, b);

  s := '+Xff';
  AssertEquals('convert "+Xff" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "+Xff" to Byte, result', 255, b);
  s := 'X100';
  AssertEquals('convert "0X100" to Byte', False, TryChars2Int(s[1..Length(s)], b));
  s := #32#9'X00ff';
  AssertEquals('convert "#32#9X00ff" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "#32#9X00ff" to Byte, result', 255, b);
  s := 'X0000';
  AssertEquals('convert "X0000" to Byte', True, TryChars2Int(s[1..Length(s)], b));
  AssertEquals('convert "X0000" to Byte, result', 0, b);

end;

procedure TTestS2I.TestShortInt;
var
  s: string;
  i: ShortInt;
begin
  s := '+0000';
  i := 42;
  AssertEquals('convert "+0000" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "+0000" to ShortInt, result', 0, i);

  s := #9#32'-0000';
  i := 42;
  AssertEquals('convert "#9#32-0000" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "#9#32-0000" to ShortInt, result', 0, i);

  s := '+127';
  AssertEquals('convert "+127" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "+127" to ShortInt, result', 127, i);
  s := '128';
  AssertEquals('convert "128" to ShortInt', False, TryChars2Int(s[1..Length(s)], i));
  s := '-128';
  AssertEquals('convert "-128" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-128" to ShortInt, result', -128, i);
  s := '-129';
  AssertEquals('convert "-129" to ShortInt', False, TryChars2Int(s[1..Length(s)], i));

  s := '%1111111';
  AssertEquals('convert "%1111111" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "%1111111" to ShortInt, result', 127, i);
  s := '%10000000';
  AssertEquals('convert "%10000000" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "%10000000" to ShortInt, result', -128, i);
  s := '-%10000000';
  AssertEquals('convert "-%10000000" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-%10000000" to ShortInt, result', -128, i);
  s := '-%10000001';
  AssertEquals('convert "-%10000001" to ShortInt', False, TryChars2Int(s[1..Length(s)], i));
{$IFNDEF NEED_VAL_COMPAT}
  s := '0b1111111';
  AssertEquals('convert "0b1111111" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0b1111111" to ShortInt, result', 127, i);
  s := '0b10000000';
  AssertEquals('convert "0b10000000" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0b10000000" to ShortInt, result', -128, i);
  s := '-0b10000000';
  AssertEquals('convert "-0b10000000" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0b10000000" to ShortInt, result', -128, i);
  s := '-0b10000001';
  AssertEquals('convert "-0b10000001" to ShortInt', False, TryChars2Int(s[1..Length(s)], i));

  s := '0B1111111';
  AssertEquals('convert "0B1111111" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0B1111111" to ShortInt, result', 127, i);
  s := '0B10000000';
  AssertEquals('convert "0B10000000" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0B10000000" to ShortInt, result', -128, i);
  s := '-0B10000000';
  AssertEquals('convert "-0B10000000" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0B10000000" to ShortInt, result', -128, i);
  s := '-0B10000001';
  AssertEquals('convert "-0B10000001" to ShortInt', False, TryChars2Int(s[1..Length(s)], i));

  s := '0177';
  AssertEquals('convert "0177" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0177" to ShortInt, result', 127, i);
  s := '0200';
  AssertEquals('convert "0200" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0200" to ShortInt, result', -128, i);
  s := '-0200';
  AssertEquals('convert "-0200" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0200" to ShortInt, result', -128, i);
  s := '-0201';
  AssertEquals('convert "-0201" to ShortInt', False, TryChars2Int(s[1..Length(s)], i));
{$ENDIF NEED_VAL_COMPAT}
  s := '&177';
  AssertEquals('convert "&177" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "&177" to ShortInt, result', 127, i);
  s := '&200';
  AssertEquals('convert "&200" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "&200" to ShortInt, result', -128, i);
  s := '-&200';
  AssertEquals('convert "-&200" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-&200" to ShortInt, result', -128, i);
  s := '-&201';
  AssertEquals('convert "-&201" to ShortInt', False, TryChars2Int(s[1..Length(s)], i));
{$IFNDEF NEED_VAL_COMPAT}
  s := '0o177';
  AssertEquals('convert "0o177" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0o177" to ShortInt, result', 127, i);
  s := '0o200';
  AssertEquals('convert "0o200" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0o200" to ShortInt, result', -128, i);
  s := '-0o200';
  AssertEquals('convert "-0o200" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0o200" to ShortInt, result', -128, i);
  s := '-0o201';
  AssertEquals('convert "-0o201" to ShortInt', False, TryChars2Int(s[1..Length(s)], i));

  s := '0O177';
  AssertEquals('convert "0O177" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0Oo177" to ShortInt, result', 127, i);
  s := '0O200';
  AssertEquals('convert "0O200" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0O200" to ShortInt, result', -128, i);
  s := '-0O200';
  AssertEquals('convert "-0O200" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0O200" to ShortInt, result', -128, i);
  s := '-0O201';
  AssertEquals('convert "-0O201" to ShortInt', False, TryChars2Int(s[1..Length(s)], i));
{$ENDIF NEED_VAL_COMPAT}
  s := '$7f';
  AssertEquals('convert "$7f" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "$7f" to ShortInt, result', 127, i);
  s := '$80';
  AssertEquals('convert "$80" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "$80" to ShortInt, result', -128, i);
  s := '-$80';
  AssertEquals('convert "-$80" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-$80" to ShortInt, result', -128, i);
  s := '-$81';
  AssertEquals('convert "-$81" to ShortInt', False, TryChars2Int(s[1..Length(s)], i));

  s := '0x7f';
  AssertEquals('convert "0x7f" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0x7f" to ShortInt, result', 127, i);
  s := '0x80';
  AssertEquals('convert "0x80" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0x80" to ShortInt, result', -128, i);
  s := '-0x80';
  AssertEquals('convert "-0x80" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0x80" to ShortInt, result', -128, i);
  s := '-0x$81';
  AssertEquals('convert "-0x$81" to ShortInt', False, TryChars2Int(s[1..Length(s)], i));

  s := '0X7f';
  AssertEquals('convert "0X7f" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0X7f" to ShortInt, result', 127, i);
  s := '0X80';
  AssertEquals('convert "0X80" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0X80" to ShortInt, result', -128, i);
  s := '-0X80';
  AssertEquals('convert "-0X80" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0X80" to ShortInt, result', -128, i);
  s := '-0X$81';
  AssertEquals('convert "-0X$81" to ShortInt', False, TryChars2Int(s[1..Length(s)], i));

  s := 'x7f';
  AssertEquals('convert "x7f" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "x7f" to ShortInt, result', 127, i);
  s := 'x80';
  AssertEquals('convert "x80" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "x80" to ShortInt, result', -128, i);
  s := '-x80';
  AssertEquals('convert "-x80" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-x80" to ShortInt, result', -128, i);
  s := '-x$81';
  AssertEquals('convert "-x$81" to ShortInt', False, TryChars2Int(s[1..Length(s)], i));

  s := 'X7f';
  AssertEquals('convert "X7f" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "X7f" to ShortInt, result', 127, i);
  s := 'X80';
  AssertEquals('convert "X80" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "X80" to ShortInt, result', -128, i);
  s := '-X80';
  AssertEquals('convert "-X80" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-X80" to ShortInt, result', -128, i);
  s := '-X$81';
  AssertEquals('convert "-X$81" to ShortInt', False, TryChars2Int(s[1..Length(s)], i));
end;

procedure TTestS2I.TestWord;
var
  s: string;
  w: Word;
begin
  s := '+0000';
  w := 42;
  AssertEquals('convert "+0000" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "+0000" to Word, result', 0, w);

  s := '+65535';
  AssertEquals('convert "+65535" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "+65535" to Word, result', 65535, w);
  s := '65536';
  AssertEquals('convert "65536" to Word', False, TryChars2Int(s[1..Length(s)], w));
  s := #32#9'65535';
  AssertEquals('convert #32#9"65535" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert 65535 to Word, result', 65535, w);

  s := '+%1111111111111111';
  AssertEquals('convert "+%1111111111111111" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "+%1111111111111111" to Word, result', 65535, w);
  s := '%10000000000000000';
  AssertEquals('convert "%10000000000000000" to Word', False, TryChars2Int(s[1..Length(s)], w));
  s := #32#9'%001111111111111111';
  AssertEquals('convert "#32#9%001111111111111111" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "#32#9%001111111111111111" to Word, result', 65535, w);
  s := '%0000';
  AssertEquals('convert "%0000" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "%0000" to Word, result', 0, w);
{$IFNDEF NEED_VAL_COMPAT}
  s := '+0b1111111111111111';
  AssertEquals('convert "+0b1111111111111111" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "+0b1111111111111111" to Word, result', 65535, w);
  s := '0b10000000000000000';
  AssertEquals('convert "0b10000000000000000" to Word', False, TryChars2Int(s[1..Length(s)], w));
  s := #32#9'0b001111111111111111';
  AssertEquals('convert "#32#90b001111111111111111" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "#32#90b001111111111111111" to Word, result', 65535, w);
  s := '0b0000';
  AssertEquals('convert "0b0000" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "0b0000" to Word, result', 0, w);

  s := '+0B1111111111111111';
  AssertEquals('convert "+0B1111111111111111" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "+0B1111111111111111" to Word, result', 65535, w);
  s := '0B10000000000000000';
  AssertEquals('convert "0B10000000000000000" to Word', False, TryChars2Int(s[1..Length(s)], w));
  s := #32#9'+0B001111111111111111';
  AssertEquals('convert "#32#9+0B001111111111111111" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "#32#9+0B001111111111111111" to Word, result', 65535, w);
  s := '0B0000';
  AssertEquals('convert "0B0000" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "0B0000" to Word, result', 0, w);
{$ENDIF NEED_VAL_COMPAT}
  s := '+&177777';
  AssertEquals('convert "+&177777" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "+&177777" to Word, result', 65535, w);
  s := '&200000';
  AssertEquals('convert "&200000" to Word', False, TryChars2Int(s[1..Length(s)], w));
  s := #32#9'&00177777';
  AssertEquals('convert "#32#9&00177777" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "#32#9&00177777" to Word, result', 65535, w);
  s := '&0000';
  AssertEquals('convert "&0000" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "&0000" to Word, result', 0, w);
{$IFNDEF NEED_VAL_COMPAT}
  s := '+0177777';
  AssertEquals('convert "+0177777" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "+0177777" to Word, result', 65535, w);
  s := '0200000';
  AssertEquals('convert "0200000" to Word', False, TryChars2Int(s[1..Length(s)], w));
  s := #32#9'0177777';
  AssertEquals('convert "#32#90177777" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "#32#90177777" to Word, result', 65535, w);

  s := '+0o177777';
  AssertEquals('convert "+0o177777" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "+0o177777" to Word, result', 65535, w);
  s := '0o200000';
  AssertEquals('convert "0o200000" to Word', False, TryChars2Int(s[1..Length(s)], w));
  s := #32#9'0o00177777';
  AssertEquals('convert "#32#90o00177777" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "#32#90o00177777" to Word, result', 65535, w);
  s := '0o0000';
  AssertEquals('convert "0o0000" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "0o0000" to Word, result', 0, w);

  s := '+0O177777';
  AssertEquals('convert "+0O177777" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "+0O177777" to Word, result', 65535, w);
  s := '0O200000';
  AssertEquals('convert "0O200000" to Word', False, TryChars2Int(s[1..Length(s)], w));
  s := #32#9'0O00177777';
  AssertEquals('convert "#32#90O00177777" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "#32#90O00177777" to Word, result', 65535, w);
  s := '0O0000';
  AssertEquals('convert "0O0000" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "0O0000" to Word, result', 0, w);
{$ENDIF NEED_VAL_COMPAT}
  s := '+$ffff';
  AssertEquals('convert "+$ffff" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "+$ffff" to Word, result', 65535, w);
  s := '$10000';
  AssertEquals('convert "$10000" to Word', False, TryChars2Int(s[1..Length(s)], w));
  s := #32#9'$00ffff';
  AssertEquals('convert "#32#9$00ffff" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "#32#9$00ffff" to Word, result', 65535, w);
  s := '$0000';
  AssertEquals('convert "$0000" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "$0000" to Word, result', 0, w);

  s := '+0xffff';
  AssertEquals('convert "+0xffff" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "+0xffff" to Word, result', 65535, w);
  s := '0x10000';
  AssertEquals('convert "0x10000" to Word', False, TryChars2Int(s[1..Length(s)], w));
  s := #32#9'0x00ffff';
  AssertEquals('convert "#32#90x00ffff" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "#32#90x00ffff" to Word, result', 65535, w);
  s := '0x0000';
  AssertEquals('convert "0x0000" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "0x0000" to Word, result', 0, w);

  s := '+0Xffff';
  AssertEquals('convert "+0Xffff" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "+0Xffff" to Word, result', 65535, w);
  s := '0X10000';
  AssertEquals('convert "0X10000" to Word', False, TryChars2Int(s[1..Length(s)], w));
  s := #32#9'0X00ffff';
  AssertEquals('convert "#32#90X00ffff" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "#32#90X00ffff" to Word, result', 65535, w);
  s := '0X0000';
  AssertEquals('convert "0X0000" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "0X0000" to Word, result', 0, w);

  s := '+xffff';
  AssertEquals('convert "+xffff" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "+xffff" to Word, result', 65535, w);
  s := 'x10000';
  AssertEquals('convert "x10000" to Word', False, TryChars2Int(s[1..Length(s)], w));
  s := #32#9'x00ffff';
  AssertEquals('convert "#32#9x00ffff" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "#32#9x00ffff" to Word, result', 65535, w);
  s := 'x0000';
  AssertEquals('convert "x0000" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "x0000" to Word, result', 0, w);

  s := '+Xffff';
  AssertEquals('convert "+Xffff" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "+Xffff" to Word, result', 65535, w);
  s := 'X10000';
  AssertEquals('convert "0X10000" to Word', False, TryChars2Int(s[1..Length(s)], w));
  s := #32#9'X00ffff';
  AssertEquals('convert "#32#9X00ffff" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "#32#9X00ffff" to Word, result', 65535, w);
  s := 'X0000';
  AssertEquals('convert "X0000" to Word', True, TryChars2Int(s[1..Length(s)], w));
  AssertEquals('convert "X0000" to Word, result', 0, w);

end;

procedure TTestS2I.TestSmallInt;
var
  s: string;
  i: SmallInt;
begin
  s := '+0000';
  i := 42;
  AssertEquals('convert "+0000" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "+0000" to ShortInt, result', 0, i);

  s := #9#32'-0000';
  i := 42;
  AssertEquals('convert "#9#32-0000" to ShortInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "#9#32-0000" to ShortInt, result', 0, i);

  s := '+32767';
  AssertEquals('convert "+32767" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "+32767" to SmallInt, result', 32767, i);
  s := '32768';
  AssertEquals('convert "32768" to SmallInt', False, TryChars2Int(s[1..Length(s)], i));
  s := '-32768';
  AssertEquals('convert "-32768" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-32768" to SmallInt, result', -32768, i);
  s := '-32769';
  AssertEquals('convert "-32769" to SmallInt', False, TryChars2Int(s[1..Length(s)], i));

  s := '%111111111111111';
  AssertEquals('convert "%111111111111111" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "%111111111111111" to SmallInt, result', 32767, i);
  s := '%1000000000000000';
  AssertEquals('convert "%1000000000000000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "%1000000000000000" to SmallInt, result', -32768, i);
  s := '-%1000000000000000';
  AssertEquals('convert "-%1000000000000000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-%1000000000000000" to SmallInt, result', -32768, i);
  s := '-%1000000000000001';
  AssertEquals('convert "-%1000000000000001" to SmallInt', False, TryChars2Int(s[1..Length(s)], i));
{$IFNDEF NEED_VAL_COMPAT}
  s := '0b111111111111111';
  AssertEquals('convert "0b111111111111111" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0b111111111111111" to SmallInt, result', 32767, i);
  s := '0b1000000000000000';
  AssertEquals('convert "0b1000000000000000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0b1000000000000000" to SmallInt, result', -32768, i);
  s := '-0b1000000000000000';
  AssertEquals('convert "-0b1000000000000000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0b1000000000000000" to SmallInt, result', -32768, i);
  s := '-0b1000000000000001';
  AssertEquals('convert "-0b1000000000000001" to SmallInt', False, TryChars2Int(s[1..Length(s)], i));

  s := '0B111111111111111';
  AssertEquals('convert "0B111111111111111" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0B111111111111111" to SmallInt, result', 32767, i);
  s := '0B1000000000000000';
  AssertEquals('convert "0B1000000000000000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0B1000000000000000" to SmallInt, result', -32768, i);
  s := '-0B1000000000000000';
  AssertEquals('convert "-0B1000000000000000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0B1000000000000000" to SmallInt, result', -32768, i);
  s := '-0B1000000000000001';
  AssertEquals('convert "-0B1000000000000001" to SmallInt', False, TryChars2Int(s[1..Length(s)], i));

  s := '077777';
  AssertEquals('convert "077777" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "077777" to SmallInt, result', 32767, i);
  s := '0100000';
  AssertEquals('convert "0100000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0100000" to SmallInt, result', -32768, i);
  s := '-0100000';
  AssertEquals('convert "-0100000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0100000" to SmallInt, result', -32768, i);
  s := '-0100001';
  AssertEquals('convert "-0100001" to SmallInt', False, TryChars2Int(s[1..Length(s)], i));
{$ENDIF NEED_VAL_COMPAT}
  s := '&77777';
  AssertEquals('convert "&77777" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "&77777" to SmallInt, result', 32767, i);
  s := '&100000';
  AssertEquals('convert "&100000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "&100000" to SmallInt, result', -32768, i);
  s := '-&100000';
  AssertEquals('convert "-&100000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-&100000" to SmallInt, result', -32768, i);
  s := '-&100001';
  AssertEquals('convert "-&100001" to SmallInt', False, TryChars2Int(s[1..Length(s)], i));
{$IFNDEF NEED_VAL_COMPAT}
  s := '0o77777';
  AssertEquals('convert "0o77777" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0o77777" to SmallInt, result', 32767, i);
  s := '0o100000';
  AssertEquals('convert "0o100000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0o100000" to SmallInt, result', -32768, i);
  s := '-0o100000';
  AssertEquals('convert "-0o100000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0o100000" to SmallInt, result', -32768, i);
  s := '-0o100001';
  AssertEquals('convert "-0o100001" to SmallInt', False, TryChars2Int(s[1..Length(s)], i));

  s := '0O77777';
  AssertEquals('convert "0O77777" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0O77777" to SmallInt, result', 32767, i);
  s := '0O100000';
  AssertEquals('convert "0O100000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0O100000" to SmallInt, result', -32768, i);
  s := '-0O100000';
  AssertEquals('convert "-0O100000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0O100000" to SmallInt, result', -32768, i);
  s := '-0O100001';
  AssertEquals('convert "-0O100001" to SmallInt', False, TryChars2Int(s[1..Length(s)], i));
{$ENDIF NEED_VAL_COMPAT}
  s := '$7fff';
  AssertEquals('convert "$7fff" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "$7fff" to SmallInt, result', 32767, i);
  s := '$8000';
  AssertEquals('convert "$8000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "$8000" to SmallInt, result', -32768, i);
  s := '-$8000';
  AssertEquals('convert "-$8000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-$8000" to SmallInt, result', -32768, i);
  s := '-$8001';
  AssertEquals('convert "-$8001" to SmallInt', False, TryChars2Int(s[1..Length(s)], i));

  s := '0x7fff';
  AssertEquals('convert "0x7fff" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0x7fff" to SmallInt, result', 32767, i);
  s := '0x8000';
  AssertEquals('convert "0x8000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0x8000" to SmallInt, result', -32768, i);
  s := '-0x8000';
  AssertEquals('convert "-0x8000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0x8000" to SmallInt, result', -32768, i);
  s := '-0x$8001';
  AssertEquals('convert "-0x$8001" to SmallInt', False, TryChars2Int(s[1..Length(s)], i));

  s := '0X7fff';
  AssertEquals('convert "0X7fff" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0X7fff" to SmallInt, result', 32767, i);
  s := '0X8000';
  AssertEquals('convert "0X8000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0X8000" to SmallInt, result', -32768, i);
  s := '-0X8000';
  AssertEquals('convert "-0X8000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0X8000" to SmallInt, result', -32768, i);
  s := '-0X$8001';
  AssertEquals('convert "-0X$8001" to SmallInt', False, TryChars2Int(s[1..Length(s)], i));

  s := 'x7fff';
  AssertEquals('convert "x7fff" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "x7fff" to SmallInt, result', 32767, i);
  s := 'x8000';
  AssertEquals('convert "x8000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "x8000" to SmallInt, result', -32768, i);
  s := '-x8000';
  AssertEquals('convert "-x8000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-x8000" to SmallInt, result', -32768, i);
  s := '-x$8001';
  AssertEquals('convert "-x$8001" to SmallInt', False, TryChars2Int(s[1..Length(s)], i));

  s := 'X7fff';
  AssertEquals('convert "X7fff" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "X7fff" to SmallInt, result', 32767, i);
  s := 'X8000';
  AssertEquals('convert "X8000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "X8000" to SmallInt, result', -32768, i);
  s := '-X8000';
  AssertEquals('convert "-X8000" to SmallInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-X8000" to SmallInt, result', -32768, i);
  s := '-X$8001';
  AssertEquals('convert "-X$8001" to SmallInt', False, TryChars2Int(s[1..Length(s)], i));
end;

procedure TTestS2I.TestDWord;
var
  s: string;
  d: DWord;
begin
  s := '+0000';
  d := 42;
  AssertEquals('convert "+0000" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "+0000" to DWord, result', 0, d);

  s := '+4294967295';
  AssertEquals('convert "+4294967295" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "+4294967295" to DWord, result', 4294967295, d);
  s := '4294967296';
  AssertEquals('convert "4294967296" to DWord', False, TryChars2Int(s[1..Length(s)], d));
  s := #32#9'4294967295';
  AssertEquals('convert #32#9"4294967295" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert 4294967295 to DWord, result', 4294967295, d);

  s := '+%11111111111111111111111111111111';
  AssertEquals('convert "+%11111111111111111111111111111111" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "+%11111111111111111111111111111111" to DWord, result', 4294967295, d);
  s := '%100000000000000000000000000000000';
  AssertEquals('convert "%100000000000000000000000000000000" to DWord', False, TryChars2Int(s[1..Length(s)], d));
  s := #32#9'%11111111111111111111111111111111';
  AssertEquals('convert "#32#9%11111111111111111111111111111111" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "#32#9%11111111111111111111111111111111" to DWord, result', 4294967295, d);
  s := '%0000';
  AssertEquals('convert "%0000" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "%0000" to DWord, result', 0, d);
{$IFNDEF NEED_VAL_COMPAT}
  s := '+0b11111111111111111111111111111111';
  AssertEquals('convert "+0b11111111111111111111111111111111" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "+0b11111111111111111111111111111111" to DWord, result', 4294967295, d);
  s := '0b100000000000000000000000000000000';
  AssertEquals('convert "0b100000000000000000000000000000000" to DWord', False, TryChars2Int(s[1..Length(s)], d));
  s := #32#9'0b0011111111111111111111111111111111';
  AssertEquals('convert "#32#90b0011111111111111111111111111111111" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "#32#90b0011111111111111111111111111111111" to DWord, result', 4294967295, d);
  s := '0b0000';
  AssertEquals('convert "0b0000" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "0b0000" to DWord, result', 0, d);

  s := '+0B11111111111111111111111111111111';
  AssertEquals('convert "+0B11111111111111111111111111111111" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "+0B11111111111111111111111111111111" to DWord, result', 4294967295, d);
  s := '0B100000000000000000000000000000000';
  AssertEquals('convert "0B100000000000000000000000000000000" to DWord', False, TryChars2Int(s[1..Length(s)], d));
  s := #32#9'+0B0011111111111111111111111111111111';
  AssertEquals('convert "#32#9+0B0011111111111111111111111111111111" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "#32#9+0B0011111111111111111111111111111111" to DWord, result', 4294967295, d);
  s := '0B0000';
  AssertEquals('convert "0B0000" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "0B0000" to DWord, result', 0, d);
{$ENDIF NEED_VAL_COMPAT}
  s := '+&37777777777';
  AssertEquals('convert "+&37777777777" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "+&37777777777" to DWord, result', 4294967295, d);
  s := '&40000000000';
  AssertEquals('convert "&40000000000" to DWord', False, TryChars2Int(s[1..Length(s)], d));
  s := #32#9'&0037777777777';
  AssertEquals('convert "#32#9&0037777777777" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "#32#9&0037777777777" to DWord, result', 4294967295, d);
  s := '&0000';
  AssertEquals('convert "&0000" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "&0000" to DWord, result', 0, d);
{$IFNDEF NEED_VAL_COMPAT}
  s := '+037777777777';
  AssertEquals('convert "+037777777777" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "+037777777777" to DWord, result', 4294967295, d);
  s := '040000000000';
  AssertEquals('convert "040000000000" to DWord', False, TryChars2Int(s[1..Length(s)], d));
  s := #32#9'037777777777';
  AssertEquals('convert "#32#90177777" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "#32#90177777" to DWord, result', 4294967295, d);

  s := '+0o37777777777';
  AssertEquals('convert "+0o37777777777" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "+0o37777777777" to DWord, result', 4294967295, d);
  s := '0o40000000000';
  AssertEquals('convert "0o40000000000" to DWord', False, TryChars2Int(s[1..Length(s)], d));
  s := #32#9'0o0037777777777';
  AssertEquals('convert "#32#90o0037777777777" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "#32#90o0037777777777" to DWord, result', 4294967295, d);
  s := '0o0000';
  AssertEquals('convert "0o0000" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "0o0000" to DWord, result', 0, d);

  s := '+0O37777777777';
  AssertEquals('convert "+0O37777777777" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "+0O37777777777" to DWord, result', 4294967295, d);
  s := '0O40000000000';
  AssertEquals('convert "0O40000000000" to DWord', False, TryChars2Int(s[1..Length(s)], d));
  s := #32#9'0O0037777777777';
  AssertEquals('convert "#32#90O0037777777777" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "#32#90O0037777777777" to DWord, result', 4294967295, d);
  s := '0O0000';
  AssertEquals('convert "0O0000" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "0O0000" to DWord, result', 0, d);
{$ENDIF NEED_VAL_COMPAT}
  s := '+$ffffffff';
  AssertEquals('convert "+$ffffffff" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "+$ffffffff" to DWord, result', 4294967295, d);
  s := '$100000000';
  AssertEquals('convert "$100000000" to DWord', False, TryChars2Int(s[1..Length(s)], d));
  s := #32#9'$00ffffffff';
  AssertEquals('convert "#32#9$00ffffffff" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "#32#9$00ffffffff" to DWord, result', 4294967295, d);
  s := '$0000';
  AssertEquals('convert "$0000" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "$0000" to DWord, result', 0, d);

  s := '+0xffffffff';
  AssertEquals('convert "+0xffffffff" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "+0xffffffff" to DWord, result', 4294967295, d);
  s := '0x100000000';
  AssertEquals('convert "0x100000000" to DWord', False, TryChars2Int(s[1..Length(s)], d));
  s := #32#9'0x00ffffffff';
  AssertEquals('convert "#32#90x00ffffffff" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "#32#90x00ffffffff" to DWord, result', 4294967295, d);
  s := '0x0000';
  AssertEquals('convert "0x0000" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "0x0000" to DWord, result', 0, d);

  s := '+0Xffffffff';
  AssertEquals('convert "+0Xffffffff" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "+0Xffffffff" to DWord, result', 4294967295, d);
  s := '0X100000000';
  AssertEquals('convert "0X100000000" to DWord', False, TryChars2Int(s[1..Length(s)], d));
  s := #32#9'0X00ffffffff';
  AssertEquals('convert "#32#90X00ffffffff" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "#32#90X00ffffffff" to DWord, result', 4294967295, d);
  s := '0X0000';
  AssertEquals('convert "0X0000" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "0X0000" to DWord, result', 0, d);

  s := '+xffffffff';
  AssertEquals('convert "+xffffffff" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "+xffffffff" to DWord, result', 4294967295, d);
  s := 'x100000000';
  AssertEquals('convert "x100000000" to DWord', False, TryChars2Int(s[1..Length(s)], d));
  s := #32#9'x00ffffffff';
  AssertEquals('convert "#32#9x00ffffffff" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "#32#9x00ffffffff" to DWord, result', 4294967295, d);
  s := 'x0000';
  AssertEquals('convert "x0000" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "x0000" to DWord, result', 0, d);

  s := '+Xffffffff';
  AssertEquals('convert "+Xffffffff" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "+Xffffffff" to DWord, result', 4294967295, d);
  s := 'X100000000';
  AssertEquals('convert "0X100000000" to DWord', False, TryChars2Int(s[1..Length(s)], d));
  s := #32#9'X00ffffffff';
  AssertEquals('convert "#32#9X00ffffffff" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "#32#9X00ffffffff" to DWord, result', 4294967295, d);
  s := 'X0000';
  AssertEquals('convert "X0000" to DWord', True, TryChars2Int(s[1..Length(s)], d));
  AssertEquals('convert "X0000" to DWord, result', 0, d);
end;

procedure TTestS2I.TestLongInt;
var
  s: string;
  i: LongInt;
begin
  s := '+0000';
  i := 42;
  AssertEquals('convert "+0000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "+0000" to LongInt, result', 0, i);

  s := #9#32'-0000';
  i := 42;
  AssertEquals('convert "#9#32-0000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "#9#32-0000" to LongInt, result', 0, i);

  s := '+2147483647';
  AssertEquals('convert "+2147483647" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "+2147483647" to LongInt, result', 2147483647, i);
  s := '2147483648';
  AssertEquals('convert "2147483648" to LongInt', False, TryChars2Int(s[1..Length(s)], i));
  s := '-2147483648';
  AssertEquals('convert "-2147483648" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-2147483648" to LongInt, result', -2147483648, i);
  s := '-2147483649';
  AssertEquals('convert "-2147483649" to LongInt', False, TryChars2Int(s[1..Length(s)], i));

  s := '%1111111111111111111111111111111';
  AssertEquals('convert "%1111111111111111111111111111111" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "%1111111111111111111111111111111" to LongInt, result', 2147483647, i);
  s := '%10000000000000000000000000000000';
  AssertEquals('convert "%10000000000000000000000000000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "%10000000000000000000000000000000" to LongInt, result', -2147483648, i);
  s := '-%10000000000000000000000000000000';
  AssertEquals('convert "-%10000000000000000000000000000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-%10000000000000000000000000000000" to LongInt, result', -2147483648, i);
  s := '-%10000000000000000000000000000001';
  AssertEquals('convert "-%10000000000000000000000000000001" to LongInt', False, TryChars2Int(s[1..Length(s)], i));
{$IFNDEF NEED_VAL_COMPAT}
  s := '0b1111111111111111111111111111111';
  AssertEquals('convert "0b1111111111111111111111111111111" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0b1111111111111111111111111111111" to LongInt, result', 2147483647, i);
  s := '0b10000000000000000000000000000000';
  AssertEquals('convert "0b10000000000000000000000000000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0b10000000000000000000000000000000" to LongInt, result', -2147483648, i);
  s := '-0b10000000000000000000000000000000';
  AssertEquals('convert "-0b10000000000000000000000000000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0b10000000000000000000000000000000" to LongInt, result', -2147483648, i);
  s := '-0b10000000000000000000000000000001';
  AssertEquals('convert "-0b10000000000000000000000000000001" to LongInt', False, TryChars2Int(s[1..Length(s)], i));

  s := '0B1111111111111111111111111111111';
  AssertEquals('convert "0B1111111111111111111111111111111" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0B1111111111111111111111111111111" to LongInt, result', 2147483647, i);
  s := '0B10000000000000000000000000000000';
  AssertEquals('convert "0B10000000000000000000000000000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0B10000000000000000000000000000000" to LongInt, result', -2147483648, i);
  s := '-0B10000000000000000000000000000000';
  AssertEquals('convert "-0B10000000000000000000000000000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0B10000000000000000000000000000000" to LongInt, result', -2147483648, i);
  s := '-0B10000000000000000000000000000001';
  AssertEquals('convert "-0B10000000000000000000000000000001" to LongInt', False, TryChars2Int(s[1..Length(s)], i));

  s := '017777777777';
  AssertEquals('convert "017777777777" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "017777777777" to LongInt, result', 2147483647, i);
  s := '020000000000';
  AssertEquals('convert "020000000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "020000000000" to LongInt, result', -2147483648, i);
  s := '-020000000000';
  AssertEquals('convert "-020000000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-020000000000" to LongInt, result', -2147483648, i);
  s := '-0120000000001';
  AssertEquals('convert "-0120000000001" to LongInt', False, TryChars2Int(s[1..Length(s)], i));
{$ENDIF NEED_VAL_COMPAT}
  s := '&17777777777';
  AssertEquals('convert "&17777777777" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "&17777777777" to LongInt, result', 2147483647, i);
  s := '&20000000000';
  AssertEquals('convert "&20000000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "&20000000000" to LongInt, result', -2147483648, i);
  s := '-&20000000000';
  AssertEquals('convert "-&20000000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-&20000000000" to LongInt, result', -2147483648, i);
  s := '-&20000000001';
  AssertEquals('convert "-&20000000001" to LongInt', False, TryChars2Int(s[1..Length(s)], i));
{$IFNDEF NEED_VAL_COMPAT}
  s := '0o17777777777';
  AssertEquals('convert "0o17777777777" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0o17777777777" to LongInt, result', 2147483647, i);
  s := '0o20000000000';
  AssertEquals('convert "0o20000000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0o20000000000" to LongInt, result', -2147483648, i);
  s := '-0o20000000000';
  AssertEquals('convert "-0o20000000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0o20000000000" to LongInt, result', -2147483648, i);
  s := '-0o20000000001';
  AssertEquals('convert "-0o20000000001" to LongInt', False, TryChars2Int(s[1..Length(s)], i));

  s := '0O17777777777';
  AssertEquals('convert "0O17777777777" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0O17777777777" to LongInt, result', 2147483647, i);
  s := '0O20000000000';
  AssertEquals('convert "0O20000000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0O20000000000" to LongInt, result', -2147483648, i);
  s := '-0O20000000000';
  AssertEquals('convert "-0O20000000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0O20000000000" to LongInt, result', -2147483648, i);
  s := '-0O20000000001';
  AssertEquals('convert "-0O120000000001" to LongInt', False, TryChars2Int(s[1..Length(s)], i));
{$ENDIF NEED_VAL_COMPAT}
  s := '$7fffffff';
  AssertEquals('convert "$7fffffff" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "$7fffffff" to LongInt, result', 2147483647, i);
  s := '$80000000';
  AssertEquals('convert "$80000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "$80000000" to LongInt, result', -2147483648, i);
  s := '-$80000000';
  AssertEquals('convert "-$80000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-$80000000" to LongInt, result', -2147483648, i);
  s := '-$80000001';
  AssertEquals('convert "-$80000001" to LongInt', False, TryChars2Int(s[1..Length(s)], i));

  s := '0x7fffffff';
  AssertEquals('convert "0x7fffffff" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0x7fffffff" to LongInt, result', 2147483647, i);
  s := '0x80000000';
  AssertEquals('convert "0x80000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0x80000000" to LongInt, result', -2147483648, i);
  s := '-0x80000000';
  AssertEquals('convert "-0x80000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0x80000000" to LongInt, result', -2147483648, i);
  s := '-0x$80000001';
  AssertEquals('convert "-0x$80000001" to LongInt', False, TryChars2Int(s[1..Length(s)], i));

  s := '0X7fffffff';
  AssertEquals('convert "0X7fffffff" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0X7fffffff" to LongInt, result', 2147483647, i);
  s := '0X80000000';
  AssertEquals('convert "0X80000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0X80000000" to LongInt, result', -2147483648, i);
  s := '-0X80000000';
  AssertEquals('convert "-0X80000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0X80000000" to LongInt, result', -2147483648, i);
  s := '-0X$80000001';
  AssertEquals('convert "-0X$80000001" to LongInt', False, TryChars2Int(s[1..Length(s)], i));

  s := 'x7fffffff';
  AssertEquals('convert "x7fffffff" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "x7fffffff" to LongInt, result', 2147483647, i);
  s := 'x80000000';
  AssertEquals('convert "x80000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "x80000000" to LongInt, result', -2147483648, i);
  s := '-x80000000';
  AssertEquals('convert "-x80000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-x80000000" to LongInt, result', -2147483648, i);
  s := '-x$80000001';
  AssertEquals('convert "-x$80000001" to LongInt', False, TryChars2Int(s[1..Length(s)], i));

  s := 'X7fffffff';
  AssertEquals('convert "X7fffffff" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "X7fffffff" to LongInt, result', 2147483647, i);
  s := 'X80000000';
  AssertEquals('convert "X80000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "X80000000" to LongInt, result', -2147483648, i);
  s := '-X80000000';
  AssertEquals('convert "-X80000000" to LongInt', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-X80000000" to LongInt, result', -2147483648, i);
  s := '-X$80000001';
  AssertEquals('convert "-X$80000001" to LongInt', False, TryChars2Int(s[1..Length(s)], i));
end;

procedure TTestS2I.TestQWord;
var
  s: string;
  q: QWord;
begin
  s := '+0000';
  q := 42;
  AssertEquals('convert "+0000" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "+0000" to DWord, result', 0, q);

  s := '+18446744073709551615';
  AssertEquals('convert "+18446744073709551615" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "+18446744073709551615" to DWord, result', 18446744073709551615, q);
  s := '18446744073709551616';
  AssertEquals('convert "18446744073709551616" to DWord', False, TryChars2Int(s[1..Length(s)], q));
  s := #32#9'18446744073709551615';
  AssertEquals('convert #32#9"18446744073709551615" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert 18446744073709551615 to DWord, result', 18446744073709551615, q);

  s := '+%1111111111111111111111111111111111111111111111111111111111111111';
  AssertEquals('convert "+%1111111111111111111111111111111111111111111111111111111111111111" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "+%1111111111111111111111111111111111111111111111111111111111111111" to DWord, result', 18446744073709551615, q);
  s := '%10000000000000000000000000000000000000000000000000000000000000000';
  AssertEquals('convert "%10000000000000000000000000000000000000000000000000000000000000000" to DWord', False, TryChars2Int(s[1..Length(s)], q));
  s := #32#9'%1111111111111111111111111111111111111111111111111111111111111111';
  AssertEquals('convert "#32#9%1111111111111111111111111111111111111111111111111111111111111111" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "#32#9%1111111111111111111111111111111111111111111111111111111111111111" to DWord, result', 18446744073709551615, q);
  s := '%0000';
  AssertEquals('convert "%0000" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "%0000" to DWord, result', 0, q);
{$IFNDEF NEED_VAL_COMPAT}
  s := '+0b1111111111111111111111111111111111111111111111111111111111111111';
  AssertEquals('convert "+0b1111111111111111111111111111111111111111111111111111111111111111" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "+0b1111111111111111111111111111111111111111111111111111111111111111" to DWord, result', 18446744073709551615, q);
  s := '0b10000000000000000000000000000000000000000000000000000000000000000';
  AssertEquals('convert "0b10000000000000000000000000000000000000000000000000000000000000000" to DWord', False, TryChars2Int(s[1..Length(s)], q));
  s := #32#9'0b001111111111111111111111111111111111111111111111111111111111111111';
  AssertEquals('convert "#32#90b001111111111111111111111111111111111111111111111111111111111111111" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "#32#90b001111111111111111111111111111111111111111111111111111111111111111" to DWord, result', 18446744073709551615, q);
  s := '0b0000';
  AssertEquals('convert "0b0000" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "0b0000" to DWord, result', 0, q);

  s := '+0B1111111111111111111111111111111111111111111111111111111111111111';
  AssertEquals('convert "+0B1111111111111111111111111111111111111111111111111111111111111111" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "+0B1111111111111111111111111111111111111111111111111111111111111111" to DWord, result', 18446744073709551615, q);
  s := '0B10000000000000000000000000000000000000000000000000000000000000000';
  AssertEquals('convert "0B10000000000000000000000000000000000000000000000000000000000000000" to DWord', False, TryChars2Int(s[1..Length(s)], q));
  s := #32#9'+0B001111111111111111111111111111111111111111111111111111111111111111';
  AssertEquals('convert "#32#9+0B001111111111111111111111111111111111111111111111111111111111111111" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "#32#9+0B001111111111111111111111111111111111111111111111111111111111111111" to DWord, result', 18446744073709551615, q);
  s := '0B0000';
  AssertEquals('convert "0B0000" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "0B0000" to DWord, result', 0, q);
{$ENDIF NEED_VAL_COMPAT}
  s := '+&1777777777777777777777';
  AssertEquals('convert "+&1777777777777777777777" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "+&1777777777777777777777" to DWord, result', 18446744073709551615, q);
  s := '&2000000000000000000000';
  AssertEquals('convert "&2000000000000000000000" to DWord', False, TryChars2Int(s[1..Length(s)], q));
  s := #32#9'&001777777777777777777777';
  AssertEquals('convert "#32#9&001777777777777777777777" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "#32#9&001777777777777777777777" to DWord, result', 18446744073709551615, q);
  s := '&0000';
  AssertEquals('convert "&0000" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "&0000" to DWord, result', 0, q);
{$IFNDEF NEED_VAL_COMPAT}
  s := '+01777777777777777777777';
  AssertEquals('convert "+01777777777777777777777" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "+01777777777777777777777" to DWord, result', 18446744073709551615, q);
  s := '02000000000000000000000';
  AssertEquals('convert "02000000000000000000000" to DWord', False, TryChars2Int(s[1..Length(s)], q));
  s := #32#9'01777777777777777777777';
  AssertEquals('convert "#32#901777777777777777777777" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "#32#901777777777777777777777" to DWord, result', 18446744073709551615, q);

  s := '+0o1777777777777777777777';
  AssertEquals('convert "+0o1777777777777777777777" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "+0o1777777777777777777777" to DWord, result', 18446744073709551615, q);
  s := '0o2000000000000000000000';
  AssertEquals('convert "0o2000000000000000000000" to DWord', False, TryChars2Int(s[1..Length(s)], q));
  s := #32#9'0o001777777777777777777777';
  AssertEquals('convert "#32#90o001777777777777777777777" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "#32#90o001777777777777777777777" to DWord, result', 18446744073709551615, q);
  s := '0o0000';
  AssertEquals('convert "0o0000" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "0o0000" to DWord, result', 0, q);

  s := '+0O1777777777777777777777';
  AssertEquals('convert "+0O1777777777777777777777" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "+0O1777777777777777777777" to DWord, result', 18446744073709551615, q);
  s := '0O2000000000000000000000';
  AssertEquals('convert "0O2000000000000000000000" to DWord', False, TryChars2Int(s[1..Length(s)], q));
  s := #32#9'0O001777777777777777777777';
  AssertEquals('convert "#32#90O001777777777777777777777" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "#32#90O001777777777777777777777" to DWord, result', 18446744073709551615, q);
  s := '0O0000';
  AssertEquals('convert "0O0000" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "0O0000" to DWord, result', 0, q);
{$ENDIF NEED_VAL_COMPAT}
  s := '+$ffffffffffffffff';
  AssertEquals('convert "+$ffffffffffffffff" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "+$ffffffffffffffff" to DWord, result', 18446744073709551615, q);
  s := '$10000000000000000';
  AssertEquals('convert "$10000000000000000" to DWord', False, TryChars2Int(s[1..Length(s)], q));
  s := #32#9'$00ffffffffffffffff';
  AssertEquals('convert "#32#9$00ffffffffffffffff" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "#32#9$00ffffffffffffffff" to DWord, result', 18446744073709551615, q);
  s := '$0000';
  AssertEquals('convert "$0000" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "$0000" to DWord, result', 0, q);

  s := '+0xffffffffffffffff';
  AssertEquals('convert "+0xffffffffffffffff" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "+0xffffffffffffffff" to DWord, result', 18446744073709551615, q);
  s := '0x10000000000000000';
  AssertEquals('convert "0x10000000000000000" to DWord', False, TryChars2Int(s[1..Length(s)], q));
  s := #32#9'0x00ffffffffffffffff';
  AssertEquals('convert "#32#90x00ffffffffffffffff" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "#32#90x00ffffffffffffffff" to DWord, result', 18446744073709551615, q);
  s := '0x0000';
  AssertEquals('convert "0x0000" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "0x0000" to DWord, result', 0, q);

  s := '+0Xffffffffffffffff';
  AssertEquals('convert "+0Xffffffffffffffff" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "+0Xffffffffffffffff" to DWord, result', 18446744073709551615, q);
  s := '0X10000000000000000';
  AssertEquals('convert "0X10000000000000000" to DWord', False, TryChars2Int(s[1..Length(s)], q));
  s := #32#9'0X00ffffffffffffffff';
  AssertEquals('convert "#32#90X00ffffffffffffffff" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "#32#90X00ffffffffffffffff" to DWord, result', 18446744073709551615, q);
  s := '0X0000';
  AssertEquals('convert "0X0000" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "0X0000" to DWord, result', 0, q);

  s := '+xffffffffffffffff';
  AssertEquals('convert "+xffffffffffffffff" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "+xffffffffffffffff" to DWord, result', 18446744073709551615, q);
  s := 'x10000000000000000';
  AssertEquals('convert "x10000000000000000" to DWord', False, TryChars2Int(s[1..Length(s)], q));
  s := #32#9'x00ffffffffffffffff';
  AssertEquals('convert "#32#9x00ffffffffffffffff" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "#32#9x00ffffffffffffffff" to DWord, result', 18446744073709551615, q);
  s := 'x0000';
  AssertEquals('convert "x0000" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "x0000" to DWord, result', 0, q);

  s := '+Xffffffffffffffff';
  AssertEquals('convert "+Xffffffffffffffff" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "+Xffffffffffffffff" to DWord, result', 18446744073709551615, q);
  s := 'X10000000000000000';
  AssertEquals('convert "0X10000000000000000" to DWord', False, TryChars2Int(s[1..Length(s)], q));
  s := #32#9'X00ffffffffffffffff';
  AssertEquals('convert "#32#9X00ffffffffffffffff" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "#32#9X00ffffffffffffffff" to DWord, result', 18446744073709551615, q);
  s := 'X0000';
  AssertEquals('convert "X0000" to DWord', True, TryChars2Int(s[1..Length(s)], q));
  AssertEquals('convert "X0000" to DWord, result', 0, q);
end;

procedure TTestS2I.TestInt64;
var
  s: string;
  i: Int64;
begin
  s := '+0000';
  i := 42;
  AssertEquals('convert "+0000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "+0000" to Int64, result', 0, i);

  s := #9#32'-0000';
  i := 42;
  AssertEquals('convert "#9#32-0000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "#9#32-0000" to Int64, result', 0, i);

  s := '+9223372036854775807';
  AssertEquals('convert "+9223372036854775807" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "+9223372036854775807" to Int64, result', 9223372036854775807, i);
  s := '9223372036854775808';
  AssertEquals('convert "9223372036854775808" to Int64', False, TryChars2Int(s[1..Length(s)], i));
  s := '-9223372036854775808';
  AssertEquals('convert "-9223372036854775808" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-9223372036854775808" to Int64, result', -9223372036854775808, i);
  s := '-9223372036854775809';
  AssertEquals('convert "-9223372036854775809" to Int64', False, TryChars2Int(s[1..Length(s)], i));

  s := '%111111111111111111111111111111111111111111111111111111111111111';
  AssertEquals('convert "%111111111111111111111111111111111111111111111111111111111111111" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "%111111111111111111111111111111111111111111111111111111111111111" to Int64, result', 9223372036854775807, i);
  s := '%1000000000000000000000000000000000000000000000000000000000000000';
  AssertEquals('convert "%1000000000000000000000000000000000000000000000000000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "%1000000000000000000000000000000000000000000000000000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-%1000000000000000000000000000000000000000000000000000000000000000';
  AssertEquals('convert "-%1000000000000000000000000000000000000000000000000000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-%1000000000000000000000000000000000000000000000000000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-%1000000000000000000000000000000000000000000000000000000000000001';
  AssertEquals('convert "-%1000000000000000000000000000000000000000000000000000000000000001" to Int64', False, TryChars2Int(s[1..Length(s)], i));
{$IFNDEF NEED_VAL_COMPAT}
  s := '0b111111111111111111111111111111111111111111111111111111111111111';
  AssertEquals('convert "0b111111111111111111111111111111111111111111111111111111111111111" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0b111111111111111111111111111111111111111111111111111111111111111" to Int64, result', 9223372036854775807, i);
  s := '0b1000000000000000000000000000000000000000000000000000000000000000';
  AssertEquals('convert "0b1000000000000000000000000000000000000000000000000000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0b1000000000000000000000000000000000000000000000000000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-0b1000000000000000000000000000000000000000000000000000000000000000';
  AssertEquals('convert "-0b1000000000000000000000000000000000000000000000000000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0b1000000000000000000000000000000000000000000000000000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-0b1000000000000000000000000000000000000000000000000000000000000001';
  AssertEquals('convert "-0b1000000000000000000000000000000000000000000000000000000000000001" to Int64', False, TryChars2Int(s[1..Length(s)], i));

  s := '0B111111111111111111111111111111111111111111111111111111111111111';
  AssertEquals('convert "0B111111111111111111111111111111111111111111111111111111111111111" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0B111111111111111111111111111111111111111111111111111111111111111" to Int64, result', 9223372036854775807, i);
  s := '0B1000000000000000000000000000000000000000000000000000000000000000';
  AssertEquals('convert "0B1000000000000000000000000000000000000000000000000000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0B1000000000000000000000000000000000000000000000000000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-0B1000000000000000000000000000000000000000000000000000000000000000';
  AssertEquals('convert "-0B1000000000000000000000000000000000000000000000000000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0B1000000000000000000000000000000000000000000000000000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-0B1000000000000000000000000000000000000000000000000000000000000001';
  AssertEquals('convert "-0B1000000000000000000000000000000000000000000000000000000000000001" to Int64', False, TryChars2Int(s[1..Length(s)], i));

  s := '0777777777777777777777';
  AssertEquals('convert "0777777777777777777777" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0777777777777777777777" to Int64, result', 9223372036854775807, i);
  s := '01000000000000000000000';
  AssertEquals('convert "01000000000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "01000000000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-01000000000000000000000';
  AssertEquals('convert "-01000000000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-01000000000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-01000000000000000000001';
  AssertEquals('convert "-01000000000000000000001" to Int64', False, TryChars2Int(s[1..Length(s)], i));
{$ENDIF NEED_VAL_COMPAT}
  s := '&777777777777777777777';
  AssertEquals('convert "&777777777777777777777" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "&777777777777777777777" to Int64, result', 9223372036854775807, i);
  s := '&1000000000000000000000';
  AssertEquals('convert "&1000000000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "&1000000000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-&1000000000000000000000';
  AssertEquals('convert "-&1000000000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-&1000000000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-&1000000000000000000001';
  AssertEquals('convert "-&1000000000000000000001" to Int64', False, TryChars2Int(s[1..Length(s)], i));
{$IFNDEF NEED_VAL_COMPAT}
  s := '0o777777777777777777777';
  AssertEquals('convert "0o777777777777777777777" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0o777777777777777777777" to Int64, result', 9223372036854775807, i);
  s := '0o1000000000000000000000';
  AssertEquals('convert "0o1000000000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0o1000000000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-0o1000000000000000000000';
  AssertEquals('convert "-0o1000000000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0o1000000000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-0o1000000000000000000001';
  AssertEquals('convert "-0o1000000000000000000001" to Int64', False, TryChars2Int(s[1..Length(s)], i));

  s := '0O777777777777777777777';
  AssertEquals('convert "0O777777777777777777777" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0O777777777777777777777" to Int64, result', 9223372036854775807, i);
  s := '0O1000000000000000000000';
  AssertEquals('convert "0O1000000000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0O1000000000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-0O1000000000000000000000';
  AssertEquals('convert "-0O1000000000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0O1000000000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-0O1000000000000000000001';
  AssertEquals('convert "-0O1000000000000000000001" to Int64', False, TryChars2Int(s[1..Length(s)], i));
{$ENDIF NEED_VAL_COMPAT}
  s := '$7fffffffffffffff';
  AssertEquals('convert "$7fffffffffffffff" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "$7fffffffffffffff" to Int64, result', 9223372036854775807, i);
  s := '$8000000000000000';
  AssertEquals('convert "$8000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "$8000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-$8000000000000000';
  AssertEquals('convert "-$8000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-$8000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-$8000000000000001';
  AssertEquals('convert "-$8000000000000001" to Int64', False, TryChars2Int(s[1..Length(s)], i));

  s := '0x7fffffffffffffff';
  AssertEquals('convert "0x7fffffffffffffff" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0x7fffffffffffffff" to Int64, result', 9223372036854775807, i);
  s := '0x8000000000000000';
  AssertEquals('convert "0x8000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0x8000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-0x8000000000000000';
  AssertEquals('convert "-0x8000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0x8000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-0x$8000000000000001';
  AssertEquals('convert "-0x$8000000000000001" to Int64', False, TryChars2Int(s[1..Length(s)], i));

  s := '0X7fffffffffffffff';
  AssertEquals('convert "0X7fffffffffffffff" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0X7fffffffffffffff" to Int64, result', 9223372036854775807, i);
  s := '0X8000000000000000';
  AssertEquals('convert "0X8000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "0X8000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-0X8000000000000000';
  AssertEquals('convert "-0X8000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-0X8000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-0X$8000000000000001';
  AssertEquals('convert "-0X$8000000000000001" to Int64', False, TryChars2Int(s[1..Length(s)], i));

  s := 'x7fffffffffffffff';
  AssertEquals('convert "x7fffffffffffffff" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "x7fffffffffffffff" to Int64, result', 9223372036854775807, i);
  s := 'x8000000000000000';
  AssertEquals('convert "x8000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "x8000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-x8000000000000000';
  AssertEquals('convert "-x8000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-x8000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-x$8000000000000001';
  AssertEquals('convert "-x$8000000000000001" to Int64', False, TryChars2Int(s[1..Length(s)], i));

  s := 'X7fffffffffffffff';
  AssertEquals('convert "X7fffffffffffffff" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "X7fffffffffffffff" to Int64, result', 9223372036854775807, i);
  s := 'X8000000000000000';
  AssertEquals('convert "X8000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "X8000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-X8000000000000000';
  AssertEquals('convert "-X8000000000000000" to Int64', True, TryChars2Int(s[1..Length(s)], i));
  AssertEquals('convert "-X8000000000000000" to Int64, result', -9223372036854775808, i);
  s := '-X$8000000000000001';
  AssertEquals('convert "-X$8000000000000001" to Int64', False, TryChars2Int(s[1..Length(s)], i));
end;

procedure TTestS2I.TestDWordWithSeparator;
var
  s: string;
  d: DWord;
begin
  s := '';
  AssertEquals('empty string', False, TryDChars2Int(s[1..Length(s)], '_', d));
  s := '_0';
  AssertEquals('convert "_0"', False, TryDChars2Int(s[1..Length(s)], '_', d));
  s := '0_';
  d := 42;
  AssertEquals('convert "0_"', True, TryDChars2Int(s[1..Length(s)], '_', d));
  AssertEquals('convert "0_", result', 0,  d);
  s := '-1_0';
  AssertEquals('convert "-1_0"', False, TryDChars2Int(s[1..Length(s)], '_', d));
  s := '10';
  AssertEquals('use "#9" as separator', False, TryDChars2Int(s[1..Length(s)], #9, d));
  d := 42;
  s := '  '#9#9'0';
  AssertEquals('convert "  #9#90"', True, TryDChars2Int(s[1..Length(s)], '_', d));
  AssertEquals('convert "  #9#90", result', 0, d);
  s := '1_0';
  AssertEquals('convert "1_0"', True, TryDChars2Int(s[1..Length(s)], '_', d));
  AssertEquals('convert "1_0", result', 10, d);
  s := ' '#9'+4_000_000_000_';
  AssertEquals('convert " #9+4_000_000_000_"', True, TryDChars2Int(s[1..Length(s)], '_', d));
  AssertEquals('convert " #9+4_000_000_000", result', 4000000000, d);
  s := '4__294__96__729__5__';
  AssertEquals('convert "4__294__96__729__5__"', True, TryDChars2Int(s[1..Length(s)], '_', d));
  AssertEquals('convert "4__294__96__729__5__", result', 4294967295, d);
  s := '4__294__96__7b9__5';
  AssertEquals('convert "4__294__96__7b9__5"', False, TryDChars2Int(s[1..Length(s)], '_', d));
  s := '4__294__96__729__6__';
  AssertEquals('convert "4__294__96__729__5__6"', False, TryDChars2Int(s[1..Length(s)], '_', d));
end;

procedure TTestS2I.TestLongIntWithSeparator;
var
  s: string;
  i: Integer;
begin
  s := '';
  AssertEquals('empty string', False, TryDChars2Int(s[1..Length(s)], '_', i));
  s := '_0';
  AssertEquals('convert "_0"', False, TryDChars2Int(s[1..Length(s)], '_', i));
  s := '0_';
  i := 42;
  AssertEquals('convert "0_"', True, TryDChars2Int(s[1..Length(s)], '_', i));
  AssertEquals('convert "0_", result', 0,  i);
  s := '+0';
  AssertEquals('use "#9" as separator', False, TryDChars2Int(s[1..Length(s)], #9, i));
  i := 42;
  s := '  '#9#9'-0';
  AssertEquals('convert "  #9#9-0"', True, TryDChars2Int(s[1..Length(s)], '_', i));
  AssertEquals('convert "  #9#90", result', 0, i);
  s := '-1_0';
  AssertEquals('convert "-1_0"', True, TryDChars2Int(s[1..Length(s)], '_', i));
  AssertEquals('convert "-1_0", result', -10, i);
  s := '2_147_483_647_';
  AssertEquals('convert "2_147_483_647_"', True, TryDChars2Int(s[1..Length(s)], '_', i));
  AssertEquals('convert "2_147_483_647_", result', 2147483647, i);
  s := '2_147_483_648_';
  AssertEquals('convert "2_147_483_648_"', False, TryDChars2Int(s[1..Length(s)], '_', i));
  s := ' -2_147_483_648_';
  AssertEquals('convert "-2_147_483_648_"', True, TryDChars2Int(s[1..Length(s)], '_', i));
  AssertEquals('convert "-2_147_483_648_", result', -2147483648, i);
  s := '-2_147_483_649_';
  AssertEquals('convert "2_147_483_648_"', False, TryDChars2Int(s[1..Length(s)], '_', i));
end;

procedure TTestS2I.TestQWordWithSeparator;
var
  s: string;
  q: QWord;
begin
  s := '';
  AssertEquals('empty string', False, TryDChars2Int(s[1..Length(s)], '_', q));
  s := '_0';
  AssertEquals('convert "_0"', False, TryDChars2Int(s[1..Length(s)], '_', q));
  s := '0_';
  q := 42;
  AssertEquals('convert "0_"', True, TryDChars2Int(s[1..Length(s)], '_', q));
  AssertEquals('convert "0_", result', 0,  q);
  s := '-1_0';
  AssertEquals('convert "-1_0"', False, TryDChars2Int(s[1..Length(s)], '_', q));
  s := '10';
  AssertEquals('use "#9" as separator', False, TryDChars2Int(s[1..Length(s)], #9, q));
  q := 42;
  s := '  '#9#9'0';
  AssertEquals('convert "  #9#90"', True, TryDChars2Int(s[1..Length(s)], '_', q));
  AssertEquals('convert "  #9#90", result', 0, q);
  s := '1_0';
  AssertEquals('convert "1_0"', True, TryDChars2Int(s[1..Length(s)], '_', q));
  AssertEquals('convert "1_0", result', 10, q);
  s := ' '#9'+18__44__67__440__737__09__551__615_';
  AssertEquals('convert " #9+18__44__67__440__737__09__551__615_"', True, TryDChars2Int(s[1..Length(s)], '_', q));
  AssertEquals('convert " #9+18__44__67__440__737__09__551__615_", result', 18446744073709551615, q);
  s := '18_446_744_0e3_709_551_616';
  AssertEquals('convert "18_446_744_0e3_709_551_616"', False, TryDChars2Int(s[1..Length(s)], '_', q));
  s := '18_446_744_073_709_551_616';
  AssertEquals('convert "18_446_744_073_709_551_616"', False, TryDChars2Int(s[1..Length(s)], '_', q));
end;

procedure TTestS2I.TestInt64WithSeparator;
var
  s: string;
  i: Int64;
begin
  s := '';
  AssertEquals('empty string', False, TryDChars2Int(s[1..Length(s)], '_', i));
  s := '_0';
  AssertEquals('convert "_0"', False, TryDChars2Int(s[1..Length(s)], '_', i));
  s := '0_';
  i := 42;
  AssertEquals('convert "0_"', True, TryDChars2Int(s[1..Length(s)], '_', i));
  AssertEquals('convert "0_", result', 0,  i);
  s := '+0';
  AssertEquals('use "#9" as separator', False, TryDChars2Int(s[1..Length(s)], #9, i));
  i := 42;
  s := '  '#9#9'-0';
  AssertEquals('convert "  #9#9-0"', True, TryDChars2Int(s[1..Length(s)], '_', i));
  AssertEquals('convert "  #9#90", result', 0, i);
  s := '-1_0';
  AssertEquals('convert "-1_0"', True, TryDChars2Int(s[1..Length(s)], '_', i));
  AssertEquals('convert "-1_0", result', -10, i);
  s := '9_223_372_036_____854_775_807';
  AssertEquals('convert "9_223_372_036_____854_775_807"', True, TryDChars2Int(s[1..Length(s)], '_', i));
  AssertEquals('convert "9_223_372_036_____854_775_807", result', 9223372036854775807, i);
  s := '9_223_372_036_854_775_808';
  AssertEquals('convert "9_223_372_036_854_775_808"', False, TryDChars2Int(s[1..Length(s)], '_', i));
  s := ' -9_223_372_036_854_775_808';
  AssertEquals('convert "-9_223_372_036_854_775_808"', True, TryDChars2Int(s[1..Length(s)], '_', i));
  AssertEquals('convert "-9_223_372_036_854_775_808", result', -9223372036854775808, i);
  s := '-9_223_372_036_854_775_809';
  AssertEquals('convert "9_223_372_036_854_775_809"', False, TryDChars2Int(s[1..Length(s)], '_', i));
end;



initialization

  RegisterTest(TTestS2I);

end.

