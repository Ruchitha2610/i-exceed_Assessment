//Inheritance
//Dart supports single,multilevel and hybrid inheritance. doesnt support multiple inheritance.
class Employee{
  int? emp_id;
  String? emp_name;
  String? emp_desig;
  
  Employee(){
    print("Default constructor of super class");
    this.emp_name="anjali";
    this.emp_desig="testing engineer";
    this.emp_id=1;
  }
  void displayEmp(){  //public method
    print("${this.emp_name}-${this.emp_desig} your id is ${this.emp_id}");
  }
}

class Manager extends Employee{//derived class can access the properties and methods of parent class
  Manager(){
    print("Default constructor of child class");
  }
  void displayManager(){
    this.emp_name="ruchitha";
    this.emp_desig="Software engineer";
    this.emp_id=2;
    print("${this.emp_name}-${this.emp_desig} your id is ${this.emp_id}");
  }
}

void main(){
  Manager m=Manager();//the object of derived class implicitly call the constructor of super class
  m.displayEmp();//by the object of derived class we can access the method of super class.
  m.displayManager();
}