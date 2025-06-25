//Super constructor in dart

//Dart doesnot support constructor overloading

/*The subclass can inherit all the variables and methods of the parent with the use of extends keyword.
but it cant inherit the constructor of the parent(super) class*/

//The constructor of parent class is implicitly called when the child class is instantiated. when the child class constructor is invoked, the parent class constructor which takes no parameter(default constructor) is implicitly called.

//parameterized constructor of parent class is not called implicitly. It is called explicitly.

class Employee{ //super class
  int? emp_id;
  String? emp_name;
  String? emp_desig;

 /* Employee(){ //default Zero argument constructor

  }*/

  Employee({String? emp_name,int? emp_id,String? emp_desig}){ //any parameters can be used. here named parameted is used
    this.emp_id=emp_id;
    this.emp_name=emp_name;
    this.emp_desig=emp_desig;
  }

  void displayEmp(){
    print("${this.emp_name}-${this.emp_desig} your id is ${this.emp_id}");
  }
}

class Manager extends Employee{
  //If the parent class constructor is parameterized it is invoked or called explicitly as follows
  Manager():super(emp_name:"ruchitha",emp_id:23,emp_desig:"Software Engineer"){

  }
  void displayManager(){
    //displayEmp();
    this.emp_desig="Senior Manager";
    print("Designation of manager: $emp_desig");
  }
}

void main(){
  //Employee eobj=Employee("anjali",45,"software engineer");
  //eobj.displayEmp();
  Manager m=Manager();
  m.displayEmp();
  m.displayManager();
}