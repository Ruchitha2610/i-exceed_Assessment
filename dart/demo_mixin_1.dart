mixin logger{
  void log(String str){
    print(str);
  }
}

class Sample with logger{
  /*void display(){
    log("Welcome, hello");
  }*/
  Sample(){
    log("Welcome, hello");
  }
}

void main(){
  Sample obj=Sample();
  //obj.display();
}