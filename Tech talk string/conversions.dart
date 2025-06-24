void main(){
  //Conversions
  //string to int
  int? age = int.tryParse('25') ;  
  print(age);         
  double price = double.parse('19.99'); 
  print(price);
  int? safe = int.tryParse('abc') ?? 0;     
  print(safe);

  //int to string
  int aage = 25;
  String? ageStr = aage.toString();  
  print(ageStr);            

  double pi = 3.14159;
  String piStr = pi.toStringAsFixed(2);     
  print(piStr); 

  //extension
  print('hello'.capitalize());
}
extension StringUtils on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}
