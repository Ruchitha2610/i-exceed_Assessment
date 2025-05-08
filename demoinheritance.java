public class demoinheritance {
    public static void main(String args[]) {
        Car car1 = new Car("Sedan", "Blue", 2022, "Honda", 180);
        car1.displayCar();
        
    }
}
class Vehicle {
    String type, color;
    int year;
    Vehicle() {
        System.out.println("Default constructor of base class (Vehicle)");
    }
    Vehicle(String type, String color, int year) {
        this.type = type;
        this.color = color;
        this.year = year;
    }
    public void display() {
        System.out.println("Type: " + type);
        System.out.println("Color: " + color);
        System.out.println("Year: " + year);
    }
}
class Car extends Vehicle {
    String brand;
    int speed;
    Car(String type, String color, int year, String brand, int speed) {
        super(type, color, year);  
        super.display(); 
        this.brand = brand;
        this.speed = speed;
    }
    public void displayCar() {
        System.out.println("Brand: " + brand);
        System.out.println("Top Speed: " + speed + " km/h");
    }
}
