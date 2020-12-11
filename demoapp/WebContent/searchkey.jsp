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
<%@ page import="java.util.*" %>
<%@ page import="fsproject.*" %>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileNotFoundException" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.BufferedWriter" %>
<%@ page import="java.io.FileWriter" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileNotFoundException" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.BufferedWriter" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.BufferedWriter" %>                
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.FileWriter" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.InputStreamReader" %>
<%
String obj6= request.getParameter("sixteen") ;
request.getParameter("pass") ;
String map=obj6.toString();
File file =new File("C:\\Users\\ragha\\eclipse-workspace\\demoapp\\WebContent\\ref.txt");
Scanner in = null;
try {
    in = new Scanner(file);
    while(in.hasNext())
    {
        String line=in.nextLine();
        if(line.contains(map))
            out.println(line);
    }
} catch (FileNotFoundException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
}

   
%>
<form action="login3.html">
<br>
 <button type="submit" class="btn btn-primary">BACK</button>
</form>
</body>
</html>