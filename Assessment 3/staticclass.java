class Product {
    String productName;
    double price;

    static String storeName = "TechZone";

    Product(String name, double price) {
        this.productName = name;
        this.price = price;
        System.out.println("Product created.");
    }

    void showProduct() {
        System.out.println("Product: " + productName + ", Price: $" + price);
    }

    static class Category {
        String categoryName;

        Category(String name) {
            this.categoryName = name;
        }

        void showCategory() {
            System.out.println("Store: " + storeName);
            System.out.println("Category: " + categoryName);
        }
    }
}

public class staticclass {
    public static void main(String[] args) {
        Product p = new Product("Smartphone", 35000);
        p.showProduct();

        Product.Category c = new Product.Category("Electronics");
        c.showCategory();
    }
}
