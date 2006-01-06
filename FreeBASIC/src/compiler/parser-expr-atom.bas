''	FreeBASIC - 32-bit BASIC Compiler.
''	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
''
''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA.


'' atomic and parentheses expression parsing
''
'' chng: sep/2004 written [v1ctor]

option explicit
option escape

#include once "inc\fb.bi"
#include once "inc\fbint.bi"
#include once "inc\parser.bi"
#include once "inc\ast.bi"

'':::::
''ParentExpression=   '(' Expression ')' .
''
function cParentExpression( byref parexpr as ASTNODE ptr ) as integer

  	function = FALSE

  	'' '('
  	if( hMatch( CHAR_LPRNT ) = FALSE ) then
  		exit function
  	end if

  	'' ++parent cnt
  	env.prntcnt += 1

  	if( cExpression( parexpr ) = FALSE ) then
  		'' calling a SUB? it can be a BYVAL or nothing due the optional ()'s
  		if( env.prntopt = FALSE ) then
  			hReportError( FB_ERRMSG_EXPECTEDEXPRESSION )
  			exit function
  		end if

  	else
  		'' ')'
  		if( hMatch( CHAR_RPRNT ) ) then
  			'' --parent cnt
  			env.prntcnt -= 1
  		else
  			'' not calling a SUB or parent cnt = 0?
  			if( (env.prntopt = FALSE) or (env.prntcnt = 0) ) then
  				hReportError( FB_ERRMSG_EXPECTEDRPRNT )
  				exit function
  			end if
  		end if

  		function = TRUE
  	end if

end function

'':::::
''Atom            =   Constant | Function | QuirkFunction | Variable | Literal .
''
function cAtom( byref atom as ASTNODE ptr ) as integer
    dim as integer res

  	atom = NULL

  	select case lexGetClass
  	case FB_TKCLASS_KEYWORD
  		return cQuirkFunction( atom )

  	case FB_TKCLASS_IDENTIFIER
  		res = cConstant( atom )
  		if( res = FALSE ) then
  			res = cFunction( atom )
  			if( res = FALSE ) then
  				res = cVariable( atom, env.checkarray )
  			end if
  		end if

  		return res

  	case else
  		return cLiteral( atom )
  	end select

end function

