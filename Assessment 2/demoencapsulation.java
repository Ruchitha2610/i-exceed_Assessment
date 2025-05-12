class BankAccount {
    private String accountHolderName="Anitha";
    private int accountNumber=78722;

    public void setAccountHolderName(String name) {
        this.accountHolderName = name;
    }

    public void setAccountNumber(int number) {
        this.accountNumber = number;
    }

     public void getAccountHolderName() {
        System.out.println("Account Holder: " + accountHolderName);
    }

    public void getAccountNumber() {
        System.out.println("Account Number: " + accountNumber);
    }
}

public class demoencapsulation {
    public static void main(String[] args) {
        BankAccount account = new BankAccount();
        account.setAccountHolderName("John Doe");
        account.setAccountNumber(123456);
        account.getAccountHolderName();
        account.getAccountNumber();
    }
}
