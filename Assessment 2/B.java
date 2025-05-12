import homepack.Shape;
class B {
	public static void main(String args[]){
		Square b=new Square("red","square",20);
		b.display();
		b.show();
	}
}
class Square extends Shape{
	int side;
	Square(String color,String shape,int side)
	{
		super(color,shape);
		this.side=side;
	}
	public void show(){
		System.out.println("Side: "+side);
	}
}




