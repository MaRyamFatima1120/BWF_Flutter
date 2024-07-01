void main(){
  //Function
  /// Function is a block of code  which divides the program into smallers parts 
  /// it is reusable code.
   greet();
   singASong();  
   print(sum(8,12));
   isEven();
   multiplication(10);
}

/*
  < datatype > fnName (){

  }
 */

//Example with greet  Function
void greet(){
  print("Good Morning");


}

//  // example 2: singASong

void singASong(){
  print("Twinkle Twinkle a little Star");
}

  // Function with parameters and return value
int sum(int a,int b){
    return a + b;
}

 // Check weather a number is even or odd
  void isEven(){
    int a=2;
    if(a%2==0){
      print("$a is Even.");
    }
    else{
      print("$a is Odd.");
    }
  }
  


 // print multiplication table

void multiplication(int t){
  print("----------------Table Number:$t----------------------");
  for(int i=1;i<=10;i++){
    print("$t * $i =${t*i}");
  }
}
