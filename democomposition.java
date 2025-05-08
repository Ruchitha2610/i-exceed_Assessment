public class democomposition {
    public static void main(String args[]){
        heart h=new heart("normal",72);
        person p=new person("aman",56,h);
        p.showDetails();

    }
}
class person{
    String name;
    int age;
    heart h;

    person(String name, int age, heart h) {
        this.name = name;
        this.age = age;
        this.h = h;
    }

    void showDetails() {
        System.out.println("Name: " + name);
        System.out.println("Age: " + age);
        h.details();
    }
}

