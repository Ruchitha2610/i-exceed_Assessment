import java.io.DataInputStream;
import java.io.IOException;

class dowhile {
    public static void main(String[] args) throws IOException {
        DataInputStream dis = new DataInputStream(System.in);
        int correctPIN = 1234;
        int pin;
        int attempts = 0;
        boolean accessGranted = false;

        do {
            System.out.print("Enter your ATM PIN: ");
            pin = Integer.parseInt(dis.readLine());
            attempts++;

            if (pin == correctPIN) {
                accessGranted = true;
                break;
            } else {
                System.out.println("Incorrect PIN. Try again.");
            }
        } while (attempts < 3);

        if (accessGranted) {
            System.out.println("Access granted. Welcome!");
        } else {
            System.out.println("Too many incorrect attempts. Your card is blocked.");
        }
    }
}
