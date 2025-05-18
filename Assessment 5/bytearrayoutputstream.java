import java.io.*;

public class bytearrayoutputstream{
    public static void main(String[] args) {
        try {
            
            FileOutputStream fileOut = new FileOutputStream("logs.txt");

            
            ByteArrayOutputStream baos = new ByteArrayOutputStream();

           
            String log1 = "INFO: Application started\n";
            String log2 = "DEBUG: Initializing components\n";
            String log3 = "ERROR: Failed to load configuration\n";

           
            baos.write(log1.getBytes());
            baos.write(log2.getBytes());
            baos.write(log3.getBytes());

            
            baos.writeTo(fileOut);

            
            baos.flush();
            baos.close();
            fileOut.close();

            System.out.println("Logs have been written to logs.txt");

        } catch (Exception e) {
            
        }
    }
}
