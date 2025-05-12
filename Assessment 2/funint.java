@FunctionalInterface
interface Notification {
    void alert(); 
}
interface Reminder {
    void remind();
}
public class funint{
    public static void main(String[] args) {
        Reminder waterReminder = new Reminder() {
            @Override
            public void remind() {
                System.out.println("Reminder: Drink water every 2 hours!");
            }
        };
        waterReminder.remind();


         new Notification() {
            @Override
            public void alert() {
                System.out.println("Alert: Battery low! Please charge your phone.");
            }
        }.alert();
    }

}