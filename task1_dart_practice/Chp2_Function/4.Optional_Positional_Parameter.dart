void main(){
    // Optional Positional Parameter

  // Optional positional parameters are denoted by enclosing them in square brackets ([]). They allow you to omit certain arguments when calling the function. If no argument is provided, the parameter will take on a default value, which can be specified. 
  

    // Here's an example:
    infoUser("Maryam");//By default value
    infoUser("Maryam","Dr.");
    print(isSum(7,4));

   
}

 void infoUser(String name,[String ? prefix ="Mr./Mrs" ]){
  print("$prefix $name"); 
 }

 /// In this example, the sum function takes three parameters a, b, and c, where b and c are optional positional parameters enclosed in square brackets. The function calculates the sum of the provided numbers a, b, and c. If b or c is not provided when calling the function, their value will be null. The function checks if b and c are not null and adds them to the result accordingly. The function can be called with different numbers of arguments: only a, a and b, or a, b, and c.
 

 int isSum(int a,[int b=6,int c=9]){
        return a + b +c;
 }