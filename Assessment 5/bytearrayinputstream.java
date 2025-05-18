import java.io.ByteArrayInputStream;
class bytearrayinputstream{
	public static void main(String args[]){
		byte[] b={65,67,68,69,70,71,72};
		ByteArrayInputStream bai=new ByteArrayInputStream(b);
		System.out.println("How many bytes are there: "+bai.available());
		int ch;
		while((ch=bai.read())!=-1){
			System.out.print((char)ch);
		}
		
		bai.reset();
		System.out.println("\nHow many bytes are there after resetting: "+bai.available());
		for(int i=0;i<b.length;i++){
			System.out.println(bai.read());
		}
	}
}