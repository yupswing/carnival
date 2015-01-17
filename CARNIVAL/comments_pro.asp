<!--#include file = "includes/inc.first.asp"--><%
'-----------------------------------------------------------------
' <IVT>
' IVT@package		Carnival
' IVT@packver		1.0b.0 <20080312>
' IVT@author		Simone Cingano <simonecingano@imente.org>
' IVT@copyright		(c) 2008 Simone Cingano
' IVT@licence		GNU GPL v2 <http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt>
' IVT@version		comments_pro.asp 0 20080312120000
' </IVT>
'
'  >>> QUESTO FILE E' PARTE INTEGRANTE DEL PACCHETTO "CARNIVAL"
'  >>> E' possibile utilizzare, modificare e ridistribuire CARNIVAL
'  >>> liberamente a patto che si mantenga la licenza originale e
'  >>> che non venga utilizzato per scopi commerciali.
'  >>> L'applicazione � inoltre distribuita senza alcun tipo di garanzia.
'
'-----------------------------------------------------------------
%>
<!--#include file = "includes/inc.md5.asp"-->
<!--#include file = "includes/inc.wbsecurity.asp"-->
<!--#include file = "includes/inc.admin.checklogin.asp"--><%
	
dim crn_isadmin
crn_isadmin = crnFunc_AdminLoggedIn()

dim crn_commentId,crn_commentName, crn_commentContent, crn_commentEmail, crn_commentUrl,crn_commentPhoto,crn_commentDate

dim crn_viaJs, crn_errorPage, crn_errorUrl
crn_viaJs = false
if trim(request.form("js")) = "1" then crn_viaJs = true
if cstr(request.querystring("js")) = "1" then crn_viaJs = true
crn_errorUrl = ""
crn_errorPage = "errors.asp"
if crn_viaJs then crn_errorPage = "inner.errors.asp"

'**** START WBSECURITY ****************************************************
dim wbs_securitycode, wbs_currentsecuritycode, wbs_isvalid
wbs_securitycode = request.form("securitycode")
if session("wbsecurity-generator") = "" then
	'cookie non attivi
	wbs_isvalid = false
else
	wbs_currentsecuritycode = getSecurityCode(session("wbsecurity-generator"))
	session("wbsecurity-generator") = getSecurityCodeGenerator()
	wbs_isvalid = (wbs_currentsecuritycode = wbs_securitycode)
end if
'**** END WBSECURITY ******************************************************

dim crn_action
crn_action = request.QueryString("action")
if crn_action <> "delete" then crn_action = "post"

select case crn_action
	case "post"
		crn_commentPhoto = cleanLong(request.form("photoid"))
		
		SQL = "SELECT photo_id FROM tba_photo WHERE photo_id = " & crn_commentPhoto & " AND photo_active = 1"
		set rs = conn.execute(SQL)
		if rs.eof then
			crn_errorUrl = crn_errorPage & "?c=comment0" & "&id=" & crn_commentPhoto & "&js=" & cbyte(crn_viaJs)
			if crn_viaJs then
				response.write("redirect>" & crn_errorUrl)
				response.end
			else
				response.Redirect(crn_errorUrl)
			end if
		end if
		
		response.Cookies(CARNIVAL_CODE & "comment")("name") = request.form("name")
		response.Cookies(CARNIVAL_CODE & "comment")("email") = request.form("email")
		response.Cookies(CARNIVAL_CODE & "comment")("url") = request.form("url")
		response.Cookies(CARNIVAL_CODE & "comment")("id") = crn_commentPhoto
		response.Cookies(CARNIVAL_CODE & "comment")("comment") = request.form("comment")
		response.Cookies(CARNIVAL_CODE & "comment").expires = now + 365
		
		if wbs_isvalid then
			crn_commentName = cleanString(request.form("name"),0,25)
			crn_commentContent = createCode(cleanString(request.form("comment"),0,5000))
			crn_commentEmail = cleanString(request.form("email"),0,250)
			crn_commentUrl = cleanString(request.form("url"),0,250)
			if crn_commentUrl = "http://" then crn_commentUrl = ""
			crn_commentDate = formatDBDate(now,"mdb")
			
			if (crn_commentName = "") or (crn_commentContent = "") or (not isValidEmail(crn_commentEmail)) then 
				crn_errorUrl = crn_errorPage & "?c=comment2" & "&id=" & crn_commentPhoto & "&js=" & cbyte(crn_viaJs)
				if crn_viaJs then
					response.write("redirect>" & crn_errorUrl)
					response.end
				else
					response.Redirect(crn_errorUrl)
				end if
			end if
			
			SQL = "INSERT INTO tba_comment (comment_name, comment_email, comment_url, comment_content, comment_photo, comment_date) VALUES " & _
				  "('" & crn_commentName & "','" & crn_commentEmail & "','" & crn_commentUrl & "','" & crn_commentContent & "'," & crn_commentPhoto & "," & crn_commentDate & ")"
			conn.execute(SQL)
			response.Cookies(CARNIVAL_CODE & "comment")("id") = 0
			response.Cookies(CARNIVAL_CODE & "comment")("comment") = ""
		else
			crn_errorUrl = crn_errorPage & "?c=comment1" & "&id=" & crn_commentPhoto & "&js=" & cbyte(crn_viaJs)
			if crn_viaJs then
				response.write("redirect>" & crn_errorUrl)
				response.end
			else
				response.Redirect(crn_errorUrl)
			end if
		end if
	case "delete"
	
		crn_commentId = request.QueryString("id")
	
		SQL = "SELECT comment_photo FROM tba_comment WHERE comment_id = " & crn_commentId
		set rs = conn.execute(SQL)
		
		if not rs.eof then
			crn_commentPhoto = rs("comment_photo")
		end if
		
		if crn_isadmin then
			SQL = "DELETE * FROM tba_comment WHERE comment_id = " & crn_commentId
			conn.execute(SQL)
		end if
	
end select

if crn_viaJs then
	response.write("redirect>" & "inner.comments.asp?id=" & crn_commentPhoto & "&js=1")
	response.end
else
	response.redirect("comments.asp?id=" & crn_commentPhoto)
end if
%>