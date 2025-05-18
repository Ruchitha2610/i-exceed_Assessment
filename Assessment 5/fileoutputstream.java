import java.io.FileOutputStream;
class fileoutputstream{
	public static void main(String args[])throws Exception{
		FileOutputStream fout=new FileOutputStream("fileoutputstream.txt");
		String str="Hello, Welcome to file output stream";
		byte[] b=str.getBytes();
		fout.write(b);
		fout.close();
		System.out.println("Data written successfully");
	}
}