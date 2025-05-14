class BankAccount {
    private int balance = 1000; 

    
    synchronized public void withdraw(String name, int amount) {
        System.out.println(name + " is trying to withdraw $" + amount);

        if (balance >= amount) {
            System.out.println(name + " is processing the withdrawal...");
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) { }
            balance -= amount;
            System.out.println(name + " completed the withdrawal. Remaining balance: $" + balance);
        } else {
            System.out.println(name + " cannot withdraw due to insufficient balance. Current balance: $" + balance);
        }
    }
}

class Customer extends Thread {
    BankAccount account;
    String name;
    int amount;

    Customer(BankAccount account, String name, int amount) {
        this.account = account;
        this.name = name;
        this.amount = amount;
        start(); // Start the thread
    }

    public void run() {
        account.withdraw(name, amount);
    }
}

public class sync {
    public static void main(String[] args) {
        BankAccount sharedAccount = new BankAccount();

        Customer c1 = new Customer(sharedAccount, "Alice", 600);
        Customer c2 = new Customer(sharedAccount, "Bob", 500);
        Customer c3 = new Customer(sharedAccount, "Charlie", 400);
    }
}
