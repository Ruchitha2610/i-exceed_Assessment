class multiplethreads {
    public static void main(String[] args) throws Exception {
        Thread uploadThread = new Thread() {
            public void run() {
                System.out.println("Uploading file...");
                try {
                    Thread.sleep(2000); 
                } catch (InterruptedException e) {}
                System.out.println("File uploaded successfully.");
            }
        };
        uploadThread.start();
        uploadThread.join(); 
       
        new Thread() {
            public void run() {
                 for (int i = 0; i < 3; i++) {
                    System.out.println("Waiting to send notification to user " + i);
                }
                System.out.println("Sent  upload notification to user...");
            }
        }.start();
    }
}

