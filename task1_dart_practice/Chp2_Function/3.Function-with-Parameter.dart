 
  // Function with Parameter

  // A function with parameters allows you to pass values or variables as arguments when calling the function. The function can then use these parameters to perform specific operations. 


void main(){
  greet("Ali"); //Here I am passing argument
  sumNum(5, 10);
  Num(5);
  multiplication(10);

 } 

 // Here's an example:
 void greet(String name){
  print("Hello,$name");
 }
  


   // Example 2: 

  // Function with parameters and return value

  int sumNum(int a,int b){
    return a + b; // returns 10
  }

   // Example 3: Check weather a number is even or odd

   void Num(int num){
    if(num%2 == 0){
      print("It is Even.");
    }
    else{
      print("It is Odd.");
    }
   }

    // print multiplication table

void multiplication(int t){
  print("----------------Table Number:$t----------------------");
  for(int i=1;i<=10;i++){
    print("$t * $i =${t*i}");
  }
}
