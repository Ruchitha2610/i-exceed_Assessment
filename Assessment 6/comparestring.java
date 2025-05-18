class comparestring{
	public static void main(String args[])
	{
		long start_time1=System.currentTimeMillis();
		StringBuilder sb1=new StringBuilder("hi");
		for(int i=0;i<100000;i++)
		{
			sb1.append("jay");
            sb1.append("hello");
            sb1.append("How are you?");
		}
		System.out.println("String builder" );
		System.out.println(System.currentTimeMillis()-start_time1+"ms");
		
		long start_time2=System.currentTimeMillis();
		StringBuffer sb2=new StringBuffer("hello");
		for(int i=0;i<100000;i++)
		{
			sb2.append("ajay");
            sb2.append("hello");
            sb2.append("How are you?");
		}
		System.out.println("String buffer");
		System.out.println(System.currentTimeMillis()-start_time2+"ms");
	}
	
}