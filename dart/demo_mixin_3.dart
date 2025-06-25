abstract class Animal{
  void move();
}

mixin canFly on Animal{   //this mixin can be applied to only the classes that extends Animal class
  void fly(){
    print("Flying");
  }
}

class Bird extends Animal with canFly{
  void move(){
    print("Bird is moving");
    fly();
  }
}

void main(){
  Bird b=Bird();
  b.move();
}