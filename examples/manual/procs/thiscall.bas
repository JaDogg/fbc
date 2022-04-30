'' examples/manual/procs/thiscall.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic '__THISCALL'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=KeyPgThiscall
'' --------

'' __thiscall only makes sense on windows 32-bit
#if defined(__FB_WIN32__) And Not defined(__FB_64BIT__)
	#define thiscall __Thiscall
#else
	#define thiscall
#endif

Extern "c++"
Type UDT
	value As Long
	'' fbc doesn't automatically add the __thiscall calling convention
	'' therefore, currently needs to be explicitly given where needed
	Declare Constructor thiscall ()
	Declare Destructor thiscall ()
	Declare Sub someproc thiscall ()
	'' etc
End Type
End Extern
