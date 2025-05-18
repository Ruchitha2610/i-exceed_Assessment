import java.util.ArrayList;
import java.util.Iterator;

class arraylist{
	public static void main(String args[]){
		ArrayList<String>playlist=new ArrayList<String>();
		playlist.add("Rainy Days");
		playlist.add("abc");
		playlist.add("pqr");
		playlist.add("qwe");
		playlist.add("tuv");
		
		System.out.println("At Index 3: "+playlist.get(3));
		System.out.println("asd present: "+playlist.contains("asd"));
		System.out.println("Rainy Days is at index: "+playlist.indexOf("Rainy Days"));
		System.out.println("Remove the value at index 2: "+playlist.remove(2)+"\n");
		
		Iterator<String> i=playlist.iterator();
		System.out.println("New list:");
		while(i.hasNext()){
			String newlist=i.next();
			System.out.println(newlist);
		}
	}
}