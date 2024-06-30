  
  // Anonymous Function

  // An anonymous function, also known as a lambda or closure, is a function without a name. It can be assigned to a variable and used as a value or passed as an argument to another function. 
  
  // Here's an example:

  // Anonymous function assigned to a variable

  void main(){
      name("Maryam");
      greet(name:"Maryam",greeting: "Good AfterNoon");
  }

  var name=(String name){
    print("Hello,$name");
  };


  //Function with Named Parameter

  var greet = ({required String name,required String greeting}){
        print("$greeting,$name");
  };