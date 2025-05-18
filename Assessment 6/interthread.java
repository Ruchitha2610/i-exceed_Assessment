import java.io.DataInputStream;
class MovieTicket{
	DataInputStream din=new DataInputStream(System.in);
	String movie_name;
	int seat_no;
	synchronized public void booking(String movie_name,int seat_no){
		System.out.println("Booking:");
		this.movie_name=movie_name;
		this.seat_no=seat_no;
		try{
			wait();
		}catch(Exception e){}
	}
	synchronized public void confirming() {
		System.out.println("Confirming:");
		System.out.println("Say yes or no:");
		try{
			String str=din.readLine();
				//System.out.println("Said yes or no: "+str);
			if(str.equals("yes")) //equals()compares the values of the string."==" checks the reference equality
				System.out.println("Confirmed for movie: "+movie_name+" seat number: "+seat_no);
			else
				System.out.println("Not confirmed");
		}catch (Exception e){}
		notify();
	}
}
class interthread{
	public static void main(String args[])
	{
		MovieTicket m=new MovieTicket();
		new Thread(){
			public void run(){
				m.booking("abc",32);
			}
		}.start();
		new Thread(){
			public void run(){
				m.confirming();
			}
		}.start();
	}
}
