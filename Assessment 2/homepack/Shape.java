//Package
package homepack;

public class Shape{
	String color;
	String shape;
	public Shape(String color,String shape)
	{
		this.color=color;
		this.shape=shape;
	}
	public void display()
	{
		System.out.println("Color: "+color+" shape: "+shape);
	}
}

