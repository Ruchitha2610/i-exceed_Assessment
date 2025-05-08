public class constructor_overloading{
	public static void main(String args[])
	{
		Rectangle r1=new Rectangle(7,8);
		r1.area();
	
	}
}
class Rectangle{
	int length;
	int breadth;
	Rectangle()
	{
		length=0;
		breadth=0;
	}
	Rectangle(int side)
	{
		length=side;
		breadth=side;
	}
	Rectangle(int length,int breadth)
	{
		this.length=length;
		this.breadth=breadth;
	}
	public void area()
	{
		System.out.println("Area: "+(length*breadth));
	}
}
