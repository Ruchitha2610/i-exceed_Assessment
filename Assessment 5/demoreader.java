import java.io.*;
class demoreader
{
    public static void main(String args[]) throws Exception
    {
        char a[]=new char[1000];
        Reader r=new FileReader("samplereader.txt");

        System.out.println("Is there data in the stream? :"+r.ready());

        System.out.println("Data in the Stream:");
        r.read(a);

        System.out.println(a);

    }
}