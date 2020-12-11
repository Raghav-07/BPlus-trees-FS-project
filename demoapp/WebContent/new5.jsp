<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<%@ page import="java.util.*" %>

<head>
<link rel="stylesheet" type="text/css" href="boots.css">
	<link rel="stylesheet" type="text/css" href="common.css">
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<% 

 class fire {
		 String method(String key,String value,String key2,String value2,String key3,String value3,String key4,String value4,String key5,String value5,String dmat) {
			 
		    Map<String, String> myMap = new HashMap<>();
		    myMap.put(key,value);
		   myMap.put(key2,value2);
		   myMap.put(key3,value3);
		   myMap.put(key4,value4);
		   myMap.put(key5,value5);
		 //   System.out.println("contents of the list of the values of the key::"+myMap.get(key));
		  
		    ArrayList<String> keyList = new ArrayList<String>(myMap.keySet());
		    ArrayList<String> valueList = new ArrayList<String>(myMap.values());
		 //   System.out.println("contents of thelist holding keys the map ::"+keyList);
		    
			  
			   if(myMap.get(dmat) == null) 
		return "NOTFOUND";
				else
				return myMap.get(dmat);
				
		}  
	}
%>
<% 

String gkey= request.getParameter("sixteen") ; 
String a=session.getAttribute("ab").toString();
String b=session.getAttribute("ab1").toString();
String c=session.getAttribute("ab2").toString();
String d=session.getAttribute("ab3").toString();
String e=session.getAttribute("ab4").toString();
String f=session.getAttribute("ab5").toString();
String g=session.getAttribute("ab6").toString();
String h=session.getAttribute("ab7").toString();
String i=session.getAttribute("ab8").toString();
String j=session.getAttribute("ab9").toString();



fire sp=new fire();
String s=sp.method(a,b,c,d,e,f,g,h,i,j,gkey);
out.println(s);
%>

</body>
</html>