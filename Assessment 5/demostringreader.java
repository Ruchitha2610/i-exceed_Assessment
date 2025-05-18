import java.io.*;

class demostringreader {
    public static void main(String args[]) throws Exception {
        String data = "This is a sample string for StringReader.";

        StringReader sr = new StringReader(data);

        System.out.println("Reading from String using StringReader:");

        int i;
        while ((i = sr.read()) != -1) {
            System.out.print((char) i);
        }

        sr.close();
    }
}
