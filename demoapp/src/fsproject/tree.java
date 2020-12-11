package fsproject;
import java.util.*;
class grp {
	 int Pkey;
	String Dname;
	 String Cno;
	int q;
	grp(int Pkey,String Dname,String Cno) {
		this.Pkey=Pkey;
		this.Dname=Dname;
		this.Cno=Cno;
	}
	grp() {	
	}
grp d1[]=new grp[4];
grp left,right;
grp root;

public void treerootm(int a,String b,String c) {
	
	if(a<Pkey) {
		if(left==null) {
			left=new grp(a,b,c);
		}
		else
			left.treerootm(a, b,c);
	}
	else if(a>=Pkey) {
		if(right==null) {
			right=new grp(a,b,c);
		}
		else
			right.treerootm(a, b,c);
	}
	}

public void display() {
if(left!=null) {
	left.display();
}
System.out.println("data  "+Pkey+Dname+Cno);
if(right!=null) {
	right.display();
}
}
}