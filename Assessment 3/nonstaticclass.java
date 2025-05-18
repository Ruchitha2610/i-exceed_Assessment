class Customer {
    String customerName;

    Customer(String name) {
        this.customerName = name;
        System.out.println("Customer created.");
    }

    class Order {
        int orderId;
        double amount;

        Order(int orderId, double amount) {
            this.orderId = orderId;
            this.amount = amount;
            System.out.println("Order created.");
        }

        void showOrder() {
            System.out.println("Customer: " + customerName);
            System.out.println("Order ID: " + orderId);
            System.out.println("Amount: $" + amount);
        }
    }
}

class nonstaticclass {
    public static void main(String[] args) {
        Customer c = new Customer("abcs");
        Customer.Order order = c.new Order(101, 250.75);
        order.showOrder();
    }
}
