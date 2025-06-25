abstract class Performer{
  void perform();
}

mixin Dance{      //Here mixins are used to avoid Deadly Diamond of Death(DDD)problem
  void perform(){
    print("Dancing");
  }
}

mixin Singer{
  void perform(){
    print("Singing");
  }
}

class Actor extends Performer with Dance,Singer{  //here the stack is stored as first Performer,then Dance and then Singer.So the stack executes as Last in First out.So Singer perform function is called and executed.
  void displayActor(){
    perform();
  }
}

void main(){
  Actor a=Actor();
  a.displayActor();
}