void main()
{
  Student s1=Student();
  print(s1);
  s1.display();
}
class Student{
  String? name; // ? used for null safety.
  int? roll;
  String? dept;

  Student(){
    name="anjali";
    roll=90;
    dept="cse";
  }
  void display(){
    name='arun';
    print("Name: $name");
    print("Roll: $roll");
    print("dept: $dept");
  }
}
