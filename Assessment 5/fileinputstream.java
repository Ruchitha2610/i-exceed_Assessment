import java.io.FileInputStream; 
class fileinputstream{
	public static void main(String args[])throws Exception{ 
		FileInputStream fin=new FileInputStream("fileinputstream.txt");
		System.out.println("Channel: "+fin.getChannel());
		System.out.println("descriptor: "+fin.getFD());
		System.out.println("How many bytes are available: "+fin.available());
		System.out.println("Skip :"+fin.skip(4));
        System.out.println("How many bytes are remaining: "+fin.available());
		int ch;
		while((ch=fin.read())!=-1){
			System.out.print((char)ch);
		}
    }
}
