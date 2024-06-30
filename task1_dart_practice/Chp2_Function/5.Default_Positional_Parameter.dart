void main(){
    // Default Value Parameter

  // Default value parameters are similar to optional positional parameters, but they have a default value specified directly in the parameter declaration. If no argument is provided when calling the function, the default value is used. Here's an example:

  greetUser("Iqra",);
  
}

//greetAge

void greetUser(String name ,{int age =20}){
  print("Hello,$name.I am Maryam.I'm $age year old.");
}