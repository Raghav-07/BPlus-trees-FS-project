package fsproject;
import fsproject.BTree.Node;

public class treenode {
grp root;
public void treerootm(int a,String b,String c) {
	if(root==null)
		root=new grp(a,b,c);
	else {
		try {
		root.treerootm(a,b,c);
		}
catch(NumberFormatException ex) {
ex.printStackTrace();
}
		
	}
}
public void display() {
	if(root!=null)
		root.display();
}
}
//package fsproject;

//import fsproject.BTree.Node;

