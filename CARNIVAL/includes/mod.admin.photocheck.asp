<!--#include file = "inc.first.asp"--><%
'-----------------------------------------------------------------
' ******************** HELLO THIS IS CARNIVAL ********************
'-----------------------------------------------------------------
' Copyright (c) 2007-2008 Simone Cingano
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
' * @author          Simone Cingano <simonecingano@imente.org>
' * @copyright       2007-2008 Simone Cingano
' * @license         http://www.opensource.org/licenses/mit-license.php
' * @version         SVN: $Id: mod.admin.photocheck.asp 16 2008-06-28 12:25:27Z imente $
' * @home            http://www.carnivals.it
'-----------------------------------------------------------------
%><!--#include file = "inc.admin.check.asp"-->
<%
dim crn_returnpage
crnPhotoId = cleanLong(request.QueryString("id"))
crn_returnpage = cleanLong(request.QueryString("returnpage"))

SQL = "SELECT photo_original FROM tba_photo WHERE photo_id = " & crnPhotoId
set rs = dbManager.conn.execute(SQL)
if rs.eof then  response.redirect("errors.asp?c=post0")
crnPhotoOriginal = rs("photo_original")

dim crn_action
crn_action = normalize(request.QueryString("action"),"edit","new")
%>
	<h2>Controllo foto</h2>
	<div class="page-description"><p>L'immagine originale, l'immagine da visualizzare e la miniatura sono state caricate o create correttamente.<br />
	Controllare che le tre immagine corrispondano e siano delle dimensioni desiderate; se non sono corrette &egrave; possibile caricarne altre.</p></div>
	<div class="cnbuttons">
	<div class="nbuttons">
	<% if crn_action = "edit" then %>
		<a href="admin.asp?module=photo-list&amp;page=<%=crn_returnpage%>">
			<span>
			<img src="<%=carnival_pathimages%>/lay-adm-ico-but-next.gif" alt=""/> 
			continua
			</span>
		</a>
		<a href="admin.asp?module=photo-upload&amp;id=<%=crnPhotoId%>&amp;action=edit&amp;returnpage=<%=crn_returnpage%>">
			<span>
			<img src="<%=carnival_pathimages%>/lay-adm-ico-but-upload.gif" alt=""/> 
			carica immagini differenti
			</span>
		</a>
	<% else %>
		<a href="admin.asp?module=photo-edit&amp;id=<%=crnPhotoId%>&amp;action=new">
			<span>
			<img src="<%=carnival_pathimages%>/lay-adm-ico-but-next.gif" alt=""/> 
			continua
			</span>
		</a>
		<a href="admin.asp?module=photo-upload&amp;id=<%=crnPhotoId%>&amp;action=new">
			<span>
			<img src="<%=carnival_pathimages%>/lay-adm-ico-but-upload.gif" alt=""/> 
			carica immagini differenti
			</span>
		</a>
	<% end if %>
	</div>
	</div>
	<hr/>
	<div class="check-box">
		<div class="check-title">miniatura (altezza massima 90px)</div>
		<p>questa miniatura verr� utilizzata per la galleria e i dettagli</p>
		<div class="check-photo"><img src="<%=CARNIVAL_PUBLIC & CARNIVAL_PHOTOS & CARNIVAL_PHOTOPREFIX & crnPhotoId & CARNIVAL_THUMBPOSTFIX & ".jpg?nc=" & noCache%>" alt="original photo" /></div>
		<hr/>
		<div class="check-title">immagine da visualizzare (altezza massima 480px)</div>
		<p>questa foto viene visualizzata sul photoblog</p>
		<p class="alert">ATTENZIONE: la foto NON � stata tagliata,<br/>semplicemente se &egrave; pi&ugrave; larga di 700pixel non viene visualizzata interamente!</p>
		<div class="check-photo"><img src="<%=CARNIVAL_PUBLIC & CARNIVAL_PHOTOS & CARNIVAL_PHOTOPREFIX & crnPhotoId & ".jpg?nc=" & noCache%>" alt="original photo" /></div>
		<hr/>
		<div class="check-title">immagine originale (dimensioni personalizzate, alta risoluzione)</div>
		<p>questa foto non viene visualizzata direttamente sul photoblog</p>
		<p class="alert">ATTENZIONE: la foto NON � stata tagliata,<br/>semplicemente se &egrave; pi&ugrave; larga di 700pixel non viene visualizzata interamente!</p>
		<div class="check-photo"><img src="<%=CARNIVAL_PUBLIC & CARNIVAL_PHOTOS & CARNIVAL_PHOTOPREFIX & crnPhotoId & CARNIVAL_ORIGINALPOSTFIX & crnPhotoOriginal & ".jpg?nc=" & noCache%>" alt="original photo" /></div>
	</div>
	<div class="clear"></div>