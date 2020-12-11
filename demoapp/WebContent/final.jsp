<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="boots.css">
	<link rel="stylesheet" type="text/css" href="common.css">
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<% 

String gkey= request.getParameter("sixteen") ; 
String ar=session.getAttribute("ab").toString();
String br=session.getAttribute("ab1").toString();
String cr=session.getAttribute("ab2").toString();
String dr=session.getAttribute("ab3").toString();
String er=session.getAttribute("ab4").toString();
String fr=session.getAttribute("ab5").toString();
String gr=session.getAttribute("ab6").toString();
String hr=session.getAttribute("ab7").toString();
String ir=session.getAttribute("ab8").toString();
String jr=session.getAttribute("ab9").toString();

%>
<h3 style="color:#F26600;"> RECORDS </h3>

<%
out.println(br);
%>
<br>
<% out.println(dr); %>
<br>
<% out.println(fr); %>
<br>
<% out.println(hr); %>
<br>
<% out.println(jr);
%>


</body>
</html>