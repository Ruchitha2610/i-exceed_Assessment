import java.io.DataInputStream;
import java.io.IOException;

class StudentMarks {
    public static void main(String[] args) throws IOException {
        DataInputStream dis = new DataInputStream(System.in);


        System.out.print("Enter the number of subjects: ");
        int n = Integer.parseInt(dis.readLine());

        int[] marks = new int[n];
        int total = 0;
       
        for (int i = 0; i < n; i++) {
            System.out.print("Enter marks for each subject " + (i + 1) + ": ");
            marks[i] = Integer.parseInt(dis.readLine());
            total += marks[i];
        }
  
        System.out.println("\nSubject Marks:");
        for (int i = 0; i < n; i++) {
            System.out.println("Subject " + (i + 1) + ": " + marks[i]);
        }

        System.out.println("Total Marks: " + total);
    }
}
