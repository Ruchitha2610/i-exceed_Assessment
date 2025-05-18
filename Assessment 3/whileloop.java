class whileloop {
    public static void main(String[] args) {
        int seconds = 5;

        System.out.println("Countdown begins!");

        while (seconds > 0) {
            System.out.println("Remaining: " + seconds + " seconds");
            try {
                Thread.sleep(1000); 
            } catch (InterruptedException e) {
                System.out.println("Timer interrupted");
            }
            seconds--;
        }

        System.out.println("Time's up!");
    }
}
