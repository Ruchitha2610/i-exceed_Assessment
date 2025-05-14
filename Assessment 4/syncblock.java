class Printer {
    public void printDocument(String docName) {
        System.out.print("[Printing ");
        System.out.print(docName);
        System.out.println("]");
    }

    public void prepareDocument(String user) {
        for (int i = 1; i <= 3; i++) {
            System.out.println(user + " is preparing page " + i);
            try { Thread.sleep(300); } catch (InterruptedException e) {}
        }
    }
}

class Employee extends Thread {
    Printer printer;
    String docName;
    String user;

    Employee(Printer printer, String user, String docName) {
        this.printer = printer;
        this.user = user;
        this.docName = docName;
        start();
    }

    public void run() {
        printer.prepareDocument(user);
        synchronized (printer) {
            printer.printDocument(docName);
        }
    }
}

public class syncblock{
    public static void main(String[] args) {
        Printer sharedPrinter = new Printer();

        Employee e1 = new Employee(sharedPrinter, "Alice", "Report_A.pdf");
        Employee e2 = new Employee(sharedPrinter, "Bob", "Design_B.pdf");
        Employee e3 = new Employee(sharedPrinter, "Charlie", "Invoice_C.pdf");
    }
}
