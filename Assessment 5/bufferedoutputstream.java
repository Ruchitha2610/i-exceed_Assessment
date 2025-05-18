import java.io.FileOutputStream;
import java.io.BufferedOutputStream;
class bufferedoutputstream{
	public static void main(String args[])throws Exception{
		FileOutputStream fout=new FileOutputStream("bufferedoutputstream.txt");
		BufferedOutputStream bout=new BufferedOutputStream(fout);
		String str="This is some data to write to the file using a BufferedOutputStream.";
		bout.write(str.getBytes());
		bout.write(65);
		bout.close();
		System.out.println("Data successfully written to the file");
		bout.flush();
		System.out.println("Buffer is flushed");
	}
}