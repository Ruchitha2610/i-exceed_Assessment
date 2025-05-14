import java.io.DataInputStream;
class order{
	DataInputStream din=new DataInputStream(System.in);
	order(){
	System.out.println("Welcome!");
	try{
	    System.out.println("Enter your name: ");
    	String name=din.readLine();
    	System.out.println("Enter the item: ");
    	String item=din.readLine();
    	System.out.println("Quantity and price: ");
    	int quantity=Integer.parseInt(din.readLine());
    	float price=Float.valueOf(din.readLine()).floatValue();
		float totalcost=quantity*price;
		int tc=(int)totalcost;
		System.out.println("Total cost: "+tc);
	}catch(Exception e){}
	}
}
class program1{
	public static void main(String args[]){
	    new order();
	}
}