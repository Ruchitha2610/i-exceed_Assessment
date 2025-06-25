//Abstract class
import 'dart:math' show pi;

abstract class Shape{
  double area();
  void display(){
    print("Concrete method from abstract class");
  }
}

class Circle extends Shape{
  dynamic radius;
  Circle({this.radius});
  double area(){
    var a=pi*radius*radius;
    return a;
  }
}

class Square extends Shape{
  dynamic length;
  Square({this.length});
  double area(){
    var b=length*length;
    return b;
  }
}

void main(){
  Circle cobj=Circle(radius:30.0);
  print('area of circle: ${cobj.area()}');
  Square sobj=Square(length:10.0);
  print('area of square: ${sobj.area()}');
  cobj.display();
}