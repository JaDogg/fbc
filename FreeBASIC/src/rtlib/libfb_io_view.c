/*
 *  libfb - FreeBASIC's runtime library
 *	Copyright (C) 2004-2005 Andre Victor T. Vicentini (av1ctor@yahoo.com.br)
 *
 *  This library is free software; you can redistribute it and/or
 *  modify it under the terms of the GNU Lesser General Public
 *  License as published by the Free Software Foundation; either
 *  version 2.1 of the License, or (at your option) any later version.
 *
 *  This library is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 *  Lesser General Public License for more details.
 *
 *  You should have received a copy of the GNU Lesser General Public
 *  License along with this library; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/*
 * io_view.c -- view print (console, no gfx)
 *
 * chng: nov/2004 written [v1ctor]
 *
 */

#include "fb.h"


/*:::::*/
FBCALL void fb_ConsoleView( int toprow, int botrow )
{
   	int maxrow = fb_ConsoleGetMaxRow( ) - 1;

   	if( toprow > 0 )
   	{
   		fb_viewTopRow = toprow - 1;
   		if( fb_viewTopRow < 0 )
      		fb_viewTopRow = 0;
    }
    else
    	fb_viewTopRow = 0;

   	if( botrow > 0 )
   	{
   		fb_viewBotRow = botrow - 1;
   		if( fb_viewBotRow > maxrow )
      		fb_viewBotRow = maxrow;
    }
    else
    	fb_viewBotRow = maxrow;

    fb_ConsoleViewUpdate( );

    /* to top row */
    fb_ConsoleLocate( fb_viewTopRow + 1, 1, -1 );
}

/*:::::*/
void fb_ConsoleGetView( int *toprow, int *botrow )
{

	if( fb_viewTopRow == -1 || fb_viewBotRow == -1 )
	{
	    fb_viewTopRow = 0;
	    fb_viewBotRow = fb_ConsoleGetMaxRow( ) - 1;
	}

	*toprow = fb_viewTopRow + 1;
    *botrow = fb_viewBotRow + 1;
}


