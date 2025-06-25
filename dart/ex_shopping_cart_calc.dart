//example to demonstrate the use of dart variables,operators and functional programming
void main()
{
  var res=shopping;
  print(res(45.89,646.979,50));//assigning function to variable.

}

double shopping(double price1,double price2,double discountRate){
  double total=price1+price2;
  double discount=total*(discountRate/100);

  return (total-discount);
}