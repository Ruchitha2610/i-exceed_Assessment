//Extension

class Person{
  String? name;
  int? age;
  String? city;

  Person(String name,int age,String city){
    this.name=name;
    this.age=age;
    this.city=city;
  }
  void display(){
    print("name: $name");
    print("age: $age");
    print("city: $city");
  }
}

extension greeting on Person{
  String greetme(String str){
    return "$str $name";
  }
}

extension  on String?{
  String trimandreplace(String str,String x,String y){
    return str.trim().replaceAll(x,y);
  }
}

void main(){
  Person p1=Person("",45,"bangalore");
  p1.display();
  print(p1.greetme("hello"));
  Person p2=Person("Anjali",56,"mysore");
  p2.display();
  print(p2.greetme("hello"));
  String? str1;
  var res=str1.trimandreplace("           Welcome to bangalore","to","hi");
  print(res);
}