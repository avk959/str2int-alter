# str2int-alter
An alternative set of routines for converting strings to integers for 32/64-bit platforms.
At least on the Intel platform they work 2-2.5 times faster than the built-in Val().

Only FPC compiler from version 3.2.2 and later is supported (earlier versions have not been tested).


String parsing is basically the same as in the built-in Val() from the current development version of FPC(with a little extension).
There seems to be only one significant difference from Val(): since the lone leading zero is the prefix of an octal string, decimal strings cannot start with a zero.
However, one can force full compatibility with Val() by uncommenting the NEED_VAL_COMPAT flag.
 
The set is extended with functions that accept an array of char or a PChar, which allows one to parse part of a string without resorting to copying.
