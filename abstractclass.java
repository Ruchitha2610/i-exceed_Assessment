public class abstractclass {
    public static void main(String[] args) {
        Rectangle rectangle = new Rectangle(4, 6);
        System.out.println("Area of Rectangle: " + rectangle.calculateArea());
    }
}
abstract class Shape {
    public void display() {
        System.out.println("This is a shape.");
    }
    abstract public double calculateArea();
}
class Rectangle extends Shape {
     int  length, width;

    Rectangle(int length, int width) {
        this.length = length;
        this.width = width;
    }
    @Override
    public double calculateArea() {
        return length * width;
    }
}
 