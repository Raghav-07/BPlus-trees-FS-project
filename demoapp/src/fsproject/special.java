package fsproject;
import java.util.*;

import fsproject.BTree.Node;
class special {
   

special(String key,String value,String key2,String value2,String key3,String value3,String key4,String value4,String key5,String value5,String dmat) {
	 
      Map<String, String> myMap = new HashMap<>();
      myMap.put(key,value);
     myMap.put(key2,value2);
     myMap.put(key3,value3);
     myMap.put(key4,value4);
     myMap.put(key5,value5);
   //   System.out.println("contents of the list of the values of the key::"+myMap.get(key));
    
      ArrayList<String> keyList = new ArrayList<String>(myMap.keySet());
      ArrayList<String> valueList = new ArrayList<String>(myMap.values());
   //   System.out.println("contents of the list holding keys the map ::"+keyList);
      
	  
	   if(myMap.get(dmat) == null)
			System.out.println("NOT FOUND");
	   else
		   System.out.println("FOUND -  "+myMap.get(dmat));
}  
}
