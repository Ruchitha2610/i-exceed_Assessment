//functional programming
//In dart function is treated as first class citizen.

//Assigning the fuction to a variable.
void main()
{
 var res=display;
 res("anjali","goa");
}

void display(String name,String city){
  print("Name: $name, City: $city");
}