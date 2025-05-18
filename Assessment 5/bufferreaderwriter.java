import java.io.*;

class bufferreaderwriter {
    public static void main(String args[]) throws Exception {

        String s = "The FileWriter class of the java.io package can be used to write data (in characters) to files.";

        
        FileWriter fw = new FileWriter("filereaderwriter.txt");
        BufferedWriter bw = new BufferedWriter(fw);

        bw.write(s);  
        bw.close();   

        
        FileReader fr = new FileReader("filereaderwriter.txt");
        BufferedReader br = new BufferedReader(fr);

        System.out.println("Is there data in the stream? :" + br.ready());
        System.out.println("Data in the Stream:");
        
        String line;
        while ((line = br.readLine()) != null) {
            System.out.println(line);
        }

        br.close();
    }
}
