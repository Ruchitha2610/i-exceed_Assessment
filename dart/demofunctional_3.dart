//functional programming

//returning function from another function

void main(){
  var res=outputFunc("hi");
  res();
  var res1=outerFunc("hello");
  res1();
}
Function outputFunc(String str)
{
  return(){
    print("Output: ${str.toUpperCase()}");
  };
} 

Function outerFunc(String str){
  print("Outer: ${str.toUpperCase()}");
  void innerFunc(String str){
   print("Inner: ${str.toLowerCase()}") ;
  }
  return (){
    innerFunc("HOW");
  };
}
