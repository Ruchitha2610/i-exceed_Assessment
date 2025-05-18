import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;

class ReadBufferedFile {
    public static void main(String[] args) throws IOException {
        FileInputStream fis = new FileInputStream("fileinputstream.txt");
        BufferedInputStream bis = new BufferedInputStream(fis);
        System.out.println("How many bytes are available: " + bis.available());
        bis.skip(2);

        System.out.print("After skipping 2 bytes, first read: ");
        System.out.println((char) bis.read());

        System.out.println("\nWhile Loop Iteration:");
        int i;
        while ((i = bis.read()) != -1) {
            System.out.print((char) i);
        }

        bis.close();
    }
}
