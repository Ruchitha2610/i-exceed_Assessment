//Getters and Setters
//variables are accessible within the library only. Even this dart library is imported in another library the variables are not accessible.
class Student{
  String _name="";// to remove null error initialize
  int _roll=0;
  String _dept="";

  void setName(String name){
    this._name=name;
  }
  void setRoll(int roll){
    this._roll=roll;
  }
  void setDept(String dept){
    this._dept=dept;
  }

  String get getName=>_name;//get keyword is used to say that this is getter function
  
  int get getRoll=>_roll;// arrow function is used.
  
  String get getDept=>_dept;
}
void main(){
  Student s1=Student();// new keyword need not be used in dart.
  s1.setName('Anjali');
  s1.setRoll(45);
  s1.setDept("cse");

  print(s1.getName);
  print(s1.getRoll);
  print(s1.getDept);
}