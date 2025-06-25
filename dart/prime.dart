void main(){
  bool a=isPrime(76278632582869289);
  if(a==true)
  print("Prime");
  else
  print("Not Prime");
   
}

bool isPrime(int n)
{
  if(n<=1){
    return false;//not prime
  }
  if(n==2){
    return true;//prime
  }
  for(int i=3; i*i<=n; i++) //Instead of checking all numbers up to n, we check up to sqrt(n), which optimizes the search for factors.
  {
    if (n%i==0){
      return false;//not prime  //If any divisor is found, return false; runs, immediately stopping the function.
    }
  }
  //If the loop completes without finding a divisor, it means n is prime.

//Therefore, after exiting the loop, we return true, confirming the number is prime.
  return true;//prime
}