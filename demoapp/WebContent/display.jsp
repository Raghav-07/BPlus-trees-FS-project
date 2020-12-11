<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%@ page import="java.util.*" %>
<%@ page import="fsproject.*" %>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileNotFoundException" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.BufferedWriter" %>
<%@ page import="java.io.FileWriter" %>

<%

Scanner sc1=new Scanner(System.in);
String st;
int y=0,k=0;
String[] st2=new String[100];
File file = new File("C:\\Users\\ragha\\eclipse-workspace\\demoapp\\WebContent\\info.txt"); 
long sze=file.length();
	    Scanner sc = new Scanner(file); 
	    BufferedReader br = new BufferedReader(new FileReader(file)); 
	    while ((st = br.readLine()) != null)
out.println(st);
%>

<form action="trying.html">
<br>
 <button type="submit" class="btn btn-primary">BACK</button>
</form>


</body>
</html>