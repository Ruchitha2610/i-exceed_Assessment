class Number{
  int? x;
  int? y;

  Number()
  {
    print("Default constructor");
  }
  Number.add({int? x,int? y}){
    this.x=x;
    this.y=y;
    print(x!+y!);
  }
}
void main(){
  Number n=Number();
  Number.add(x:10,y:10);
}