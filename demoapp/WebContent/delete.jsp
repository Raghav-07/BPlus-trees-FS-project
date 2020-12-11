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


class BPlusTree {
int m;
InternalNode root;
LeafNode firstLeaf;

// Binary search program
private int binarySearch(DictionaryPair[] dps, int numPairs, int t) {
 Comparator<DictionaryPair> c = new Comparator<DictionaryPair>() {
   @Override
   public int compare(DictionaryPair o1, DictionaryPair o2) {
     Integer a = Integer.valueOf(o1.key);
     Integer b = Integer.valueOf(o2.key);
     return a.compareTo(b);
   }
 };
 return Arrays.binarySearch(dps, 0, numPairs, new DictionaryPair(t, 0), c);
}

// Find the leaf node
private LeafNode findLeafNode(int key) {

 Integer[] keys = this.root.keys;
 int i;

 for (i = 0; i < this.root.degree - 1; i++) {
   if (key < keys[i]) {
     break;
   }
 }

 Node child = this.root.childPointers[i];
 if (child instanceof LeafNode) {
   return (LeafNode) child;
 } else {
   return findLeafNode((InternalNode) child, key);
 }
}

// Find the leaf node
private LeafNode findLeafNode(InternalNode node, int key) {

 Integer[] keys = node.keys;
 int i;

 for (i = 0; i < node.degree - 1; i++) {
   if (key < keys[i]) {
     break;
   }
 }
 Node childNode = node.childPointers[i];
 if (childNode instanceof LeafNode) {
   return (LeafNode) childNode;
 } else {
   return findLeafNode((InternalNode) node.childPointers[i], key);
 }
}

// Finding the index of the pointer
private int findIndexOfPointer(Node[] pointers, LeafNode node) {
 int i;
 for (i = 0; i < pointers.length; i++) {
   if (pointers[i] == node) {
     break;
   }
 }
 return i;
}

// Get the mid point
private int getMidpoint() {
 return (int) Math.ceil((this.m + 1) / 2.0) - 1;
}

// Balance the tree
private void handleDeficiency(InternalNode in) {

 InternalNode sibling;
 InternalNode parent = in.parent;

 if (this.root == in) {
   for (int i = 0; i < in.childPointers.length; i++) {
     if (in.childPointers[i] != null) {
       if (in.childPointers[i] instanceof InternalNode) {
         this.root = (InternalNode) in.childPointers[i];
         this.root.parent = null;
       } else if (in.childPointers[i] instanceof LeafNode) {
         this.root = null;
       }
     }
   }
 }

 else if (in.leftSibling != null && in.leftSibling.isLendable()) {
   sibling = in.leftSibling;
 } else if (in.rightSibling != null && in.rightSibling.isLendable()) {
   sibling = in.rightSibling;

   int borrowedKey = sibling.keys[0];
   Node pointer = sibling.childPointers[0];

   in.keys[in.degree - 1] = parent.keys[0];
   in.childPointers[in.degree] = pointer;

   parent.keys[0] = borrowedKey;

   sibling.removePointer(0);
   Arrays.sort(sibling.keys);
   sibling.removePointer(0);
   shiftDown(in.childPointers, 1);
 } else if (in.leftSibling != null && in.leftSibling.isMergeable()) {

 } else if (in.rightSibling != null && in.rightSibling.isMergeable()) {
   sibling = in.rightSibling;
   sibling.keys[sibling.degree - 1] = parent.keys[parent.degree - 2];
   Arrays.sort(sibling.keys, 0, sibling.degree);
   parent.keys[parent.degree - 2] = null;

   for (int i = 0; i < in.childPointers.length; i++) {
     if (in.childPointers[i] != null) {
       sibling.prependChildPointer(in.childPointers[i]);
       in.childPointers[i].parent = sibling;
       in.removePointer(i);
     }
   }

   parent.removePointer(in);

   sibling.leftSibling = in.leftSibling;
 }

 if (parent != null && parent.isDeficient()) {
   handleDeficiency(parent);
 }
}

private boolean isEmpty() {
 return firstLeaf == null;
}

private int linearNullSearch(DictionaryPair[] dps) {
 for (int i = 0; i < dps.length; i++) {
   if (dps[i] == null) {
     return i;
   }
 }
 return -1;
}

private int linearNullSearch(Node[] pointers) {
 for (int i = 0; i < pointers.length; i++) {
   if (pointers[i] == null) {
     return i;
   }
 }
 return -1;
}

private void shiftDown(Node[] pointers, int amount) {
 Node[] newPointers = new Node[this.m + 1];
 for (int i = amount; i < pointers.length; i++) {
   newPointers[i - amount] = pointers[i];
 }
 pointers = newPointers;
}

private void sortDictionary(DictionaryPair[] dictionary) {
 Arrays.sort(dictionary, new Comparator<DictionaryPair>() {
   @Override
   public int compare(DictionaryPair o1, DictionaryPair o2) {
     if (o1 == null && o2 == null) {
       return 0;
     }
     if (o1 == null) {
       return 1;
     }
     if (o2 == null) {
       return -1;
     }
     return o1.compareTo(o2);
   }
 });
}

private Node[] splitChildPointers(InternalNode in, int split) {

 Node[] pointers = in.childPointers;
 Node[] halfPointers = new Node[this.m + 1];

 for (int i = split + 1; i < pointers.length; i++) {
   halfPointers[i - split - 1] = pointers[i];
   in.removePointer(i);
 }

 return halfPointers;
}

private DictionaryPair[] splitDictionary(LeafNode ln, int split) {

 DictionaryPair[] dictionary = ln.dictionary;

 DictionaryPair[] halfDict = new DictionaryPair[this.m];

 for (int i = split; i < dictionary.length; i++) {
   halfDict[i - split] = dictionary[i];
   ln.delete(i);
 }

 return halfDict;
}

private void splitInternalNode(InternalNode in) {

 InternalNode parent = in.parent;

 int midpoint = getMidpoint();
 int newParentKey = in.keys[midpoint];
 Integer[] halfKeys = splitKeys(in.keys, midpoint);
 Node[] halfPointers = splitChildPointers(in, midpoint);

 in.degree = linearNullSearch(in.childPointers);

 InternalNode sibling = new InternalNode(this.m, halfKeys, halfPointers);
 for (Node pointer : halfPointers) {
   if (pointer != null) {
     pointer.parent = sibling;
   }
 }

 sibling.rightSibling = in.rightSibling;
 if (sibling.rightSibling != null) {
   sibling.rightSibling.leftSibling = sibling;
 }
 in.rightSibling = sibling;
 sibling.leftSibling = in;

 if (parent == null) {

   Integer[] keys = new Integer[this.m];
   keys[0] = newParentKey;
   InternalNode newRoot = new InternalNode(this.m, keys);
   newRoot.appendChildPointer(in);
   newRoot.appendChildPointer(sibling);
   this.root = newRoot;

   in.parent = newRoot;
   sibling.parent = newRoot;

 } else {

   parent.keys[parent.degree - 1] = newParentKey;
   Arrays.sort(parent.keys, 0, parent.degree);

   int pointerIndex = parent.findIndexOfPointer(in) + 1;
   parent.insertChildPointer(sibling, pointerIndex);
   sibling.parent = parent;
 }
}

private Integer[] splitKeys(Integer[] keys, int split) {

 Integer[] halfKeys = new Integer[this.m];

 keys[split] = null;

 for (int i = split + 1; i < keys.length; i++) {
   halfKeys[i - split - 1] = keys[i];
   keys[i] = null;
 }

 return halfKeys;
}

public void insert(int key, double value) {
 if (isEmpty()) {
   LeafNode ln = new LeafNode(this.m, new DictionaryPair(key, value));
   this.firstLeaf = ln;
 } else {
   LeafNode ln = (this.root == null) ? this.firstLeaf : findLeafNode(key);
   if (!ln.insert(new DictionaryPair(key, value))) {
     ln.dictionary[ln.numPairs] = new DictionaryPair(key, value);
     ln.numPairs++;
     sortDictionary(ln.dictionary);
     int midpoint = getMidpoint();
     DictionaryPair[] halfDict = splitDictionary(ln, midpoint);
     if (ln.parent == null) {
       Integer[] parent_keys = new Integer[this.m];
       parent_keys[0] = halfDict[0].key;
       InternalNode parent = new InternalNode(this.m, parent_keys);
       ln.parent = parent;
       parent.appendChildPointer(ln);
     } else {
       int newParentKey = halfDict[0].key;
       ln.parent.keys[ln.parent.degree - 1] = newParentKey;
       Arrays.sort(ln.parent.keys, 0, ln.parent.degree);
     }
     LeafNode newLeafNode = new LeafNode(this.m, halfDict, ln.parent);
     int pointerIndex = ln.parent.findIndexOfPointer(ln) + 1;
     ln.parent.insertChildPointer(newLeafNode, pointerIndex);
     newLeafNode.rightSibling = ln.rightSibling;
     if (newLeafNode.rightSibling != null) {
       newLeafNode.rightSibling.leftSibling = newLeafNode;
     }
     ln.rightSibling = newLeafNode;
     newLeafNode.leftSibling = ln;
     if (this.root == null) {
       this.root = ln.parent;
     } else {
       InternalNode in = ln.parent;
       while (in != null) {
         if (in.isOverfull()) {
           splitInternalNode(in);
         } else {
           break;
         }
         in = in.parent;
       }
     }
   }
 }
}

public Double search(int key) {
 if (isEmpty()) {
   return null;
 }
 LeafNode ln = (this.root == null) ? this.firstLeaf : findLeafNode(key);
 DictionaryPair[] dps = ln.dictionary;
 int index = binarySearch(dps, ln.numPairs, key);
 if (index < 0) {
   return null;
 } else {
   return dps[index].value;
 }
}
public ArrayList<Double> search(int lowerBound, int upperBound) {
 ArrayList<Double> values = new ArrayList<Double>();
 LeafNode currNode = this.firstLeaf;
 while (currNode != null) {
   DictionaryPair dps[] = currNode.dictionary;
   for (DictionaryPair dp : dps) {
     if (dp == null) {
       break;
     }
     if (lowerBound <= dp.key && dp.key <= upperBound) {
       values.add(dp.value);
     }
   }
   currNode = currNode.rightSibling;
 }
 return values;
}

public BPlusTree(int m) {
 this.m = m;
 this.root = null;
}

 class Node {
 InternalNode parent;
}

 class InternalNode extends Node {
 int maxDegree;
 int minDegree;
 int degree;
 InternalNode leftSibling;
 InternalNode rightSibling;
 Integer[] keys;
 Node[] childPointers;

 private void appendChildPointer(Node pointer) {
   this.childPointers[degree] = pointer;
   this.degree++;
 }

 private int findIndexOfPointer(Node pointer) {
   for (int i = 0; i < childPointers.length; i++) {
     if (childPointers[i] == pointer) {
       return i;
     }
   }
   return -1;
 }

 private void insertChildPointer(Node pointer, int index) {
   for (int i = degree - 1; i >= index; i--) {
     childPointers[i + 1] = childPointers[i];
   }
   this.childPointers[index] = pointer;
   this.degree++;
 }

 private boolean isDeficient() {
   return this.degree < this.minDegree;
 }

 private boolean isLendable() {
   return this.degree > this.minDegree;
 }

 private boolean isMergeable() {
   return this.degree == this.minDegree;
 }

 private boolean isOverfull() {
   return this.degree == maxDegree + 1;
 }

 private void prependChildPointer(Node pointer) {
   for (int i = degree - 1; i >= 0; i--) {
     childPointers[i + 1] = childPointers[i];
   }
   this.childPointers[0] = pointer;
   this.degree++;
 }

 private void removeKey(int index) {
   this.keys[index] = null;
 }

 private void removePointer(int index) {
   this.childPointers[index] = null;
   this.degree--;
 }

 private void removePointer(Node pointer) {
   for (int i = 0; i < childPointers.length; i++) {
     if (childPointers[i] == pointer) {
       this.childPointers[i] = null;
     }
   }
   this.degree--;
 }

 private InternalNode(int m, Integer[] keys) {
   this.maxDegree = m;
   this.minDegree = (int) Math.ceil(m / 2.0);
   this.degree = 0;
   this.keys = keys;
   this.childPointers = new Node[this.maxDegree + 1];
 }

 private InternalNode(int m, Integer[] keys, Node[] pointers) {
   this.maxDegree = m;
   this.minDegree = (int) Math.ceil(m / 2.0);
   this.degree = linearNullSearch(pointers);
   this.keys = keys;
   this.childPointers = pointers;
 }
}

 class LeafNode extends Node {
 int maxNumPairs;
 int minNumPairs;
 int numPairs;
 LeafNode leftSibling;
 LeafNode rightSibling;
 DictionaryPair[] dictionary;

 public void delete(int index) {
   this.dictionary[index] = null;
   numPairs--;
 }

 public boolean insert(DictionaryPair dp) {
   if (this.isFull()) {
     return false;
   } else {
     this.dictionary[numPairs] = dp;
     numPairs++;
     Arrays.sort(this.dictionary, 0, numPairs);

     return true;
   }
 }

 public boolean isDeficient() {
   return numPairs < minNumPairs;
 }

 public boolean isFull() {
   return numPairs == maxNumPairs;
 }

 public boolean isLendable() {
   return numPairs > minNumPairs;
 }

 public boolean isMergeable() {
   return numPairs == minNumPairs;
 }

 public LeafNode(int m, DictionaryPair dp) {
   this.maxNumPairs = m - 1;
   this.minNumPairs = (int) (Math.ceil(m / 2) - 1);
   this.dictionary = new DictionaryPair[m];
   this.numPairs = 0;
   this.insert(dp);
 }

 public LeafNode(int m, DictionaryPair[] dps, InternalNode parent) {
   this.maxNumPairs = m - 1;
   this.minNumPairs = (int) (Math.ceil(m / 2) - 1);
   this.dictionary = dps;
   this.numPairs = linearNullSearch(dps);
   this.parent = parent;
 }
}

 class DictionaryPair implements Comparable<DictionaryPair> {
 int key;
 double value;

 public DictionaryPair(int key, double value) {
   this.key = key;
   this.value = value;
 }

 public int compareTo(DictionaryPair o) {
   if (key == o.key) {
     return 0;
   } else if (key > o.key) {
     return 1;
   } else {
     return -1;
   }
 }
}
}
 class newbplus  {
String ngk=null;
int h=0,l=0;

String method123(int x) throws IOException {
 BPlusTree bpt = null;
 bpt = new BPlusTree(3);
 
 String st4;
 int o=0;
 String[] st3=new String[100];
 File file2 = new File("C:\\Users\\ragha\\eclipse-workspace\\demoapp\\WebContent\\data.txt"); 
 Scanner sc2 = new Scanner(file2);
 BufferedReader br2 = new BufferedReader(new FileReader(file2)); 
 while ((st4 = br2.readLine()) != null) {
	 st3[o]=st4.toString();
	o++;
 }
 int arr1[]=new int[100];

 for(int i=0;i<o;i++)
 	 arr1[i]=Integer.parseInt(st3[i]);	
 
 for(int i=0;i<o;i+=2) {
	 for(int j=i;j<i+1;j++) {
		 bpt.insert(arr1[j],arr1[j+1]);
	 }
 }



Scanner sc1=new Scanner(System.in);
String st;
int y=0,k=0;
String[] st2=new String[100];
File file = new File("C:\\Users\\ragha\\eclipse-workspace\\demoapp\\WebContent\\data.txt"); 
long sze=file.length();
	    Scanner sc = new Scanner(file); 
	    BufferedReader br = new BufferedReader(new FileReader(file)); 
	    while ((st = br.readLine()) != null) {
st2[y]=st.toString();
y++;
	    }
	    
	   
for(int i=0;i<y;i++) {
 if (bpt.search(arr1[i]) != null) {
   System.out.println("Found");
   l++;
   double dd=bpt.search(x);
    ngk=Double.toString(dd);

 } else {
   System.out.println("Not Found");
   h++;
 } 
}
return ngk;
}
}
%>

<%
 class StringExample {
	void method(String a) { 
		try {
	File inputFile = new File("C:\\Users\\ragha\\eclipse-workspace\\demoapp\\WebContent\\data.txt");
	File tempFile = new File("C:\\Users\\ragha\\eclipse-workspace\\demoapp\\WebContent\\myTempFile.txt");

	BufferedReader reader = new BufferedReader(new FileReader(inputFile));
	BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile));
	System.out.println("hereeeeeee"+a);
	String lineToRemove = a;
	String currentLine;

	while((currentLine = reader.readLine()) != null) {
	    // trim newline when comparing with lineToRemove
	    String trimmedLine = currentLine.trim();
	    if(trimmedLine.equals(lineToRemove)) continue;
	    writer.write(currentLine + System.getProperty("line.separator"));
	}
	writer.close(); 
	reader.close(); 
	boolean successful = tempFile.renameTo(inputFile);
	}
	
	catch(Exception e) {
		System.out.println("occoured");
	}
}	
	
	}
	

%>

<%
 class StringExample123 {
	void method() { 
			

				String sourceFileName = "C:\\Users\\ragha\\eclipse-workspace\\demoapp\\WebContent\\myTempFile.txt";
				String destinationFileName = "C:\\Users\\ragha\\eclipse-workspace\\demoapp\\WebContent\\data.txt";

				
				    BufferedReader br = null;
				    PrintWriter pw = null; 
				    try {
				         br = new BufferedReader(new FileReader(sourceFileName));
				         pw =  new PrintWriter(new FileWriter(destinationFileName));
				         String line;
				         while ((line = br.readLine()) != null) {
				                pw.println(line);
				                pw.flush();

				                Thread.sleep(1000);
				         }
				         br.close();
				         pw.close();
				    }catch (Exception e) {
				         e.printStackTrace();
				    }
				}
	
	
}
%>
<% //SECOND %>

<%
 class StringExampleone {
	void method(String a) { 
		try {
	FileWriter fw = new FileWriter("C:\\Users\\ragha\\eclipse-workspace\\demoapp\\WebContent\\myTempFile.txt",false);
	fw.close();

		}
	catch(Exception e) {
		System.out.println("occoured");
	}
}	
	
	}
	

%>

<%
 class StringExampletwo {
	void method(String a) { 
		try {
	File inputFile = new File("C:\\Users\\ragha\\eclipse-workspace\\demoapp\\WebContent\\data.txt");
	File tempFile = new File("C:\\Users\\ragha\\eclipse-workspace\\demoapp\\WebContent\\myTempFile.txt");

	BufferedReader reader = new BufferedReader(new FileReader(inputFile));
	BufferedWriter writer = new BufferedWriter(new FileWriter(tempFile));
	System.out.println("hereeeeeee"+a);
	
	String lineToRemove = a;
	String currentLine;

	while((currentLine = reader.readLine()) != null) {
	    // trim newline when comparing with lineToRemove
	    String trimmedLine = currentLine.trim();
	    if(trimmedLine.equals(lineToRemove)) continue;
	    writer.write(currentLine + System.getProperty("line.separator"));
	}
	writer.close(); 
	reader.close(); 
	boolean successful = tempFile.renameTo(inputFile);
	}
	
	catch(Exception e) {
		System.out.println("occoured");
	}
}	
	
	}
	

%>




<%
 class StringExampleone123 {
	void method() { 
			

				String sourceFileName = "C:\\Users\\ragha\\eclipse-workspace\\demoapp\\WebContent\\myTempFile.txt";
				String destinationFileName = "C:\\Users\\ragha\\eclipse-workspace\\demoapp\\WebContent\\data.txt";

				
				    BufferedReader br = null;
				    PrintWriter pw = null; 
				    try {
				         br = new BufferedReader(new FileReader(sourceFileName));
				         pw =  new PrintWriter(new FileWriter(destinationFileName));
				         String line;
				         while ((line = br.readLine()) != null) {
				                pw.println(line);
				                pw.flush();

				                Thread.sleep(1000);
				         }
				         br.close();
				         pw.close();
				    }catch (Exception e) {
				         e.printStackTrace();
				    }
				}
	
	
}
%>
<%
class paradise
{   
    void modifyFile(String filePath, String oldString, String newString)
   {
       File fileToBeModified = new File(filePath);
        
       String oldContent = "";
        
       BufferedReader reader = null;
        
       FileWriter writer = null;
        
       try
       {
           reader = new BufferedReader(new FileReader(fileToBeModified));
            
           //Reading all the lines of input text file into oldContent
            
           String line = reader.readLine();
            
           while (line != null) 
           {
               oldContent = oldContent + line + System.lineSeparator();
                
               line = reader.readLine();
           }
            
           //Replacing oldString with newString in the oldContent
            
           String newContent = oldContent.replaceAll(oldString, newString);
            
           //Rewriting the input text file with newContent
            
           writer = new FileWriter(fileToBeModified);
            
           writer.write(newContent);
       }
       catch (IOException e)
       {
           e.printStackTrace();
       }
       finally
       {
           try
           {
               //Closing the resources
                
               reader.close();
                
               writer.close();
           } 
           catch (IOException e) 
           {
               e.printStackTrace();
           }
       }
   }
}

%>




<% try {
String obj6= request.getParameter("fifth") ;
request.getParameter("pass") ;
String gb=null;
String mad=obj6.toString();
String str=obj6.toString();
int sum=Integer.parseInt(str);
newbplus nb=new newbplus();
try {
gb=nb.method123(sum);
}
	catch(Exception e) {
		out.println("RECORD NOT FOUND");
	}
StringExample st=new StringExample();
String sum3=String.valueOf(sum);
st.method(sum3);

StringExample123 st5=new StringExample123();
st5.method();



StringExampleone st8=new StringExampleone();
st8.method(gb);
String rtt=gb.substring(0, gb.length() - 2);
StringExampletwo st9=new StringExampletwo();
st9.method(rtt);
StringExampleone123 st99=new StringExampleone123();
st99.method();
 out.println("DELETED SUCCESSFULLY");
 paradise p=new paradise();
 p.modifyFile("C:\\Users\\ragha\\eclipse-workspace\\demoapp\\WebContent\\info.txt",mad,"DELT");

}
catch(Exception e) {
	out.println("NO RECORD FOUND");
}

%>


<form action="trying.html">
<br>
 <button type="submit" class="btn btn-primary">BACK</button>
</form>

</body>
</html>