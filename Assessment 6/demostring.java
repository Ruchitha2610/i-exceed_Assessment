class demostr {
    public static void main(String args[]) {
        String message = "User: Hello";
        System.out.println(message);
       
        String  str=new String("good morning\n");
        System.out.println("hi " +str);
        
        StringBuilder sbuild = new StringBuilder("String builder:\n");
        sbuild.append("User1: Hello 👋\n");
        sbuild.append("User2: Hi there!\n");
        sbuild.append("User1: How are you?\n");
        System.out.println(sbuild);

        StringBuffer sbuffer = new StringBuffer("String buffer (efficient):\n");
        sbuffer.append("User1: Hello 👋\n");
        sbuffer.append("User2: Hi there!\n");
        sbuffer.append("User1: How are you?\n");
        System.out.println(sbuffer);
    }
}