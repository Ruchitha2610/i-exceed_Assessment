//Method overloading
public class demooverloading {
    public static void main(String args[]) {
        Multiply obj = new Multiply();
        System.out.println(obj.multiply(4, 5));
    }
}

class Multiply {
    public int multiply(int x, int y) {
        return x * y;
    }

    public int multiply(int x, int y, int z) {
        return x * y * z;
    }

    public float multiply(float a, float b) {
        return a * b;
    }
}
