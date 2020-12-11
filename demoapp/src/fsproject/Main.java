package fsproject;
import java.util.*;

import fsproject.BTree.Node;

public class Main {

		  public static void main(String args[]) {
					Scanner sc=new Scanner(System.in);
					
					int ch;
					int flag=1;
					int key,g=0;
					int sft[]=new int[100];
					int mainkey[]=new int[4];
					String name=new String();
					String no=new String();
					treenode tr=new treenode();
					//System.out.println("ENTER THE NUMBER OF RECORDS YOU WANT TO INSERT");
			          //int rate=sc.nextInt();
					 String fkey[]=new String[5];
			          String fname[]=new String[5];
			          String fcno[]=new String[5];
			          String combo=null,combo2=null,combo3=null,combo4=null,combo5=null;
			          int flag2=1;
					while(flag==1) {
					System.out.println("ENTER YOUR CHOICE");
					System.out.println("1.INSERT AND SEARCH    2.DISPLAY ALL RECORDS    3.EXIT   ");
					ch=sc.nextInt();		
					if(ch<5) {
					switch(ch) {
					case 1: {
				int choice;
					do {
					System.out.println("enter ur inner choice 1.insert    2.search");
					choice=sc.nextInt();
					switch(choice) {
					case 1: {
						
					for(int i=0;i<5;i++) {
					System.out.println("ENTER THE KEY,NAME AND NUMBER");
					key=sc.nextInt();
					name=sc.next();
					no=sc.next();
					g++;
		          tr.treerootm(key,name,no);
		          
		         /* String ipkey=String.valueOf(key);
		 //         String comb=ipkey+name+no;
		          BTree b = new BTree(3);	
				  b.Insert(key);*/
				 
				 // Node h=b.Contain2(key);
		          int arr[]=new int[10];
		          int k;
		          for( k=0;k<5;k++)
		        	  arr[k]=key;
		         
				 			  

					}
		         // System.out.println("ENTER YES IF YOU WANT TO MAP VALUES");
		        	 
		        	  
		        	 
		        	  
		        for(int i=0;i<5;i++) {
		        	  System.out.println("Enter the values for map(key,name,no)");
		        	  fkey[i]=sc.next();
		        	  fname[i]=sc.next();
		        	  fcno[i]=sc.next();
		          }
				  
		          combo=fkey[0]+"|"+fname[0]+"|"+fcno[0];
		          combo2=fkey[1]+"|"+fname[1]+"|"+fcno[1];
		          combo3=fkey[2]+"|"+fname[2]+"|"+fcno[2];
		          combo4=fkey[3]+"|"+fname[3]+"|"+fcno[3];
		          combo5=fkey[4]+"|"+fname[4]+"|"+fcno[4];
		         // String madein2=h.toString();
					
		       /*   System.out.println("enter the key in map you want to find");
		          String gkey=sc.next();
		          special sp=new special(fkey[0],combo,fkey[1],combo2,gkey);
		            flag2=1;*/
		          for(int l=0;l<5;l++) {
		         // System.out.println("Enter the bkey");
		         // int key5=sc.nextInt();
		        	  int ffkey=Integer.parseInt(fkey[l]);
	        	  sft[l]=ffkey;
	        	  
		          }
		          
		          BTree b = new BTree(3);
		          for(int i=0;i<5;i++)
				  b.Insert(sft[i]);
				  System.out.println("happeneiung here");
				  b.Show();
		            break;
					}
					
					
					case 2: {
						 System.out.println("ENTER THE KEY");
				          String gkey=sc.next(); 
				          Boolean bool;
				          special sp=new special(fkey[0],combo,fkey[1],combo2,fkey[2],combo3,fkey[3],combo4,fkey[4],combo5,gkey);
				          flag2=1;
				          
					break;
					}
					
					
					case 3 : {
					flag2=0;
					break;
					}
					} 
					}while(flag2==1);
					System.out.println("END OF FUNCTION!!");
			         flag=1;
		            break;
					
					}
					case 2: {
					tr.display();
					flag=1;
					break;
					}
				
					case 3: 
					{
					System.out.println("THANKYOU!!");
					flag=0;
					break;
					}
					}
					}
					}
				}
		}