class University {
    String name;
    String location;

    University(String name, String location) {
        this.name = name;
        this.location = location;
    }

    public void display(Professor p) {
        System.out.println("University Name: " + name);
        System.out.println("Location: " + location);
        System.out.println("Professor Name: " + p.profName);
        System.out.println("Department: " + p.dept);
        System.out.println("Experience: " + p.experience + " years");
    }
}

class Professor {
    String profName;
    String dept;
    int experience;

    Professor(String profName, String dept, int experience) {
        this.profName = profName;
        this.dept = dept;
        this.experience = experience;
    }
}

class demoAgg {
    public static void main(String[] args) {
        University u = new University("SCE", "Bangalore");
        Professor p = new Professor("Anitha", "CSE", 12);
        u.display(p);
    }
}
