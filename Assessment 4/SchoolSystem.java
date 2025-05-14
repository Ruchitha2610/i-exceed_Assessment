class Bell extends Thread {
    Thread t=new Thread(this);
    
    public void run() {
        System.out.println("Ringing the bell...");
        System.out.println("Child thread name: "+t.getName());
        System.out.println("Child thread priority: "+t.getPriority());
    }
}

public class SchoolSystem {
    public static void main(String[] args) {
        Thread mainThread = Thread.currentThread();
        Bell bellThread = new Bell();
        int MAX_PRIORITY=10;
        bellThread.start();

        System.out.println("Main thread name: " + mainThread.getName());
        mainThread.setName("Announcement System");
        System.out.println("After setting name: " + mainThread.getName());
        System.out.println("Priority of main thread: "+MAX_PRIORITY);
    }
}
