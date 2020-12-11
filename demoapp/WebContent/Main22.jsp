<html>
<body >
<%@ page import="java.util.*" %>
<%@ page import="fsproject.*" %>
<%@ page import="java.io.BufferedReader"%>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileNotFoundException" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.BufferedWriter" %>
<%@ page import="java.io.FileWriter" %>

<head>
<link rel="stylesheet" type="text/css" href="boots.css">
	<link rel="stylesheet" type="text/css" href="common.css">
	</head>
<%
int ch;
int flag=1;
int g=0;
int sft[]=new int[100];
int mainkey[]=new int[4];
String name=new String();
String no=new String();
//System.out.println("ENTER THE NUMBER OF RECORDS YOU WANT TO INSERT");
  //int rate=sc.nextInt();
 String fkey[]=new String[5];
  String fname[]=new String[5];
  String fcno[]=new String[5];
  String combo=null,combo2=null,combo3=null,combo4=null,combo5=null;
  int flag2=1;
String obj1= request.getParameter("first") ;
request.getParameter("pass") ;


String obj2= request.getParameter("second") ;
request.getParameter("pass") ;


String obj3= request.getParameter("third") ;
request.getParameter("pass") ;




try (FileWriter writer = new FileWriter("C:\\Users\\ragha\\eclipse-workspace\\demoapp\\WebContent\\data.txt", true);
		 BufferedWriter bw = new BufferedWriter(writer)) {

		bw.write(obj1);
		bw.newLine();
		bw.write(obj3);
		bw.newLine();
		

	} catch (IOException e) {
		System.err.format("IOException: %s%n", e);
	}

try (FileWriter writer = new FileWriter("C:\\Users\\ragha\\eclipse-workspace\\demoapp\\WebContent\\info.txt", true);
		 BufferedWriter bw = new BufferedWriter(writer)) {
		bw.write(obj1+"|");
		bw.write(obj2+"|");
		bw.write(obj3+"000"+" ||");
		bw.newLine();
		

	} catch (IOException e) {
		System.err.format("IOException: %s%n", e);
	}



String gkey= request.getParameter("sixteen") ; %>

<h3>INSERTED SUCESSFULLY </h3>

<%

session.setAttribute("ab",obj1);
session.setAttribute("ab1",obj2);
session.setAttribute("ab2",obj3);

String a=obj1.toString();
String b=obj2.toString();
try (FileWriter writer = new FileWriter("C:\\Users\\ragha\\eclipse-workspace\\demoapp\\WebContent\\ref.txt", true);
		 BufferedWriter bw = new BufferedWriter(writer)) {

		bw.write(a+"|");
		bw.write(b+"||");
		bw.newLine();
		

	} catch (IOException e) {
		System.err.format("IOException: %s%n", e);
	}


%>



<form action="trying.html">
 <button type="submit" class="btn btn-primary">BACK</button>
</form>










</body>
</html>