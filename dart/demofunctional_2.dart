//functional programing

//passing function as a argument to another function

void main(){
  var res=greeting(upper);
  print("Upper: $res");
  dynamic res1=greeting(lower);
  print("Lower: $res1");


}
String upper(String str){
  return str.toUpperCase();
}
String lower(String str){
  return str.toLowerCase();
}

String greeting(Function callfun){
  return callfun("Hello");
}