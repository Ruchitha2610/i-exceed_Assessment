void main()
{
  var res=add(10,10);
  print("Res: $res");
  var res1=add1(67,3);//the function is assigned to the variable
  print("Res1: $res1");
  var res2=add2(45,9);
  print("Res2: $res2");

  //without assigning the function to a variable
  print("w/o assigning to variable: ${(int x,int y){
    return x+y;
  }(100,100)}");

  String str="BANGALORE";//separately declare the str
  var res3=useme(con,str);//here useme function returns func i.e con, so con function is assigned to res3. res3 is used to pass string str to con function.
  print("res3:${res3(str)}");//str is passed through variable 
  //either pass str the above way or pass it in the below way
  //var res3=useme(con,str)(str);
  //print(res3);
   
}

//normal function
int add(int x,int y){
  return x+y;
}

//closure function: function which doesnt have name. the name is used as the variable.
var add1=(int x,int y){
  return x+y;
};

//lambda function or arrow function
var add2=(int x,int y)=>x+y;

//returning function and taking parameter as the function(higher order function)
var con=(String str){
  return str.toLowerCase();
};

Function useme(Function func,String str){
   return func; //dont pass the str here 
}
 

