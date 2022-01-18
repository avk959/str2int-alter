# str2int-alter
An alternative set of routines for converting a string to an integer(s).

String parsing is basically the same as in the built-in Val() from the current development version of FPC(with a little extension). 
The set is extended with functions that accept an array of char or a PChar, which allows one to parse part of a string without resorting to copying.