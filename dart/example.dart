void main(){
  print("Welcome");
  var res=discount_percentage(10.0);
  print("Grand total: ${res("dress",5)}");
}
Function discount_percentage(double discount_percent){
  return (String type,int quantity)=>product(type,quantity,discount_percent);
  
}

double product(String type,int quantity,double discount_percent){
  double price=0.0;
  switch(type){
    case "dress":
    price=3000.0;
    break;

    case "watch":
    price=2000.0;
    break;

    case "footwear":
    price=1000.0;
  }
  double total=price*quantity;
  double discount=total*(discount_percent/100);
  double grand_total=total-discount;
  return grand_total;

}