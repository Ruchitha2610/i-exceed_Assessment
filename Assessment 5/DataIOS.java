import java.io.*;

class DataIOS {
    public static void main(String[] args) throws IOException {
        // Writing data to a file
        FileOutputStream fos = new FileOutputStream("simpledata.txt");
        DataOutputStream dos = new DataOutputStream(fos);

        dos.writeInt(10);          
        dos.writeDouble(25.75);     
        dos.writeBoolean(true);     

        dos.close();

        
        FileInputStream fis = new FileInputStream("simpledata.txt");
        DataInputStream dis = new DataInputStream(fis);

        int num = dis.readInt();
        double value = dis.readDouble();
        boolean flag = dis.readBoolean();

        System.out.println("Integer: " + num);
        System.out.println("Double: " + value);
        System.out.println("Boolean: " + flag);

        dis.close();
    }
}
