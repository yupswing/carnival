<%
'-----------------------------------------------------------------
' ******************** HELLO THIS IS CARNIVAL ********************
'-----------------------------------------------------------------
' Copyright (c) 2007-2011 Simone Cingano
' 
' Permission is hereby granted, free of charge, to any person
' obtaining a copy of this software and associated documentation
' files (the "Software"), to deal in the Software without
' restriction, including without limitation the rights to use,
' copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the
' Software is furnished to do so, subject to the following
' conditions:
' 
' The above copyright notice and this permission notice shall be
' included in all copies or substantial portions of the Software.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
' EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
' OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
' NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
' HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
' WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
' FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
' OTHER DEALINGS IN THE SOFTWARE.
'-----------------------------------------------------------------
' * @category        Carnival
' * @package         Carnival
' * @author          Simone Cingano <info@carnivals.it>
' * @copyright       2007-2011 Simone Cingano
' * @license         http://www.opensource.org/licenses/mit-license.php
' * @version         SVN: $Id: inc.dba.asp 114 2010-10-11 19:00:34Z imente $
' * @home            http://www.carnivals.it
'-----------------------------------------------------------------
%><!--#include file = "class.aspdbbox.asp"--><%
Public rs, SQL

dim dbManager, dbPagination
set dbManager = new Class_ASPDbManager : dbManager.debugging = false

dbManager.database = CARNIVAL_DATABASE_TYPE

sub connect()
	dim str_host, str_user, str_password
	str_host = "" : if CARNIVAL_DATABASE_TYPE = "mysql" then str_host = CARNIVAL_DATABASE_HOST
	str_user = "" : if CARNIVAL_DATABASE_TYPE = "mysql" then str_user = CARNIVAL_DATABASE_USER
	str_password = "" : if CARNIVAL_DATABASE_TYPE = "mysql" then str_password = CARNIVAL_DATABASE_PASSWORD
	if not dbManager.Connect(CARNIVAL_DATABASE,str_user,str_password,"") then response.redirect("critical.asp?c=00")
end sub

sub disconnect()
	call dbManager.Disconnect()
end sub
%>
