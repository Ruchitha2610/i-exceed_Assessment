public class demointerface2 {
    public static void main(String args[]) {
        Employee emp = new Employee();
        emp.display();
    }
}

interface PersonInfo {
    String COMPANY_NAME = "TechNova Inc"; 
    int EMPLOYEE_ID = 101;
    void display(); // abstract method
}

class Employee implements PersonInfo {
    @Override
    public void display() {
        System.out.println("Company: " + COMPANY_NAME + ", Employee ID: " + EMPLOYEE_ID);
    }
}
