public class demooverriding {
    public static void main(String args[]) {
        Vehicle ref; 
        Vehicle obj2 = new Vehicle("Vehicle");
        Bike obj1 = new Bike("abcs", "TVS");
        ref = obj1;
        ref.start(); 
    }
}
class Vehicle {
    String name;

    Vehicle(String name) {
        this.name = name;
    }

    public void start() {
        System.out.println("Vehicle starts");
    }

    public void fuel() {
        System.out.println("Vehicle uses fuel");
    }
}
class Bike extends Vehicle {
    String brand;

    Bike(String name, String brand) {
        super(name);
        this.brand = brand;
        start();
        fuel();
    }

    public void start() {
        System.out.println("Bike starts with a key");
    }

    public void fuel() {
        System.out.println("Bike uses petrol");
    }

    public void display() {
        System.out.println("Bike Name: " + name);
        System.out.println("Brand: " + brand);
    }
}
