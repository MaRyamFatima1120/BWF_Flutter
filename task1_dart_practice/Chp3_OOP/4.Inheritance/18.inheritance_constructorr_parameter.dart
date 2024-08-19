

///Example 4: Inheritance Of Constructor With Named Parameters In Dart
//In this example below, there is class named Laptop with a constructor with named parameters. There is another class named MacBook which extends the Laptop class. The MacBook class has its own constructor with named parameters.
class Laptop{
  Laptop({String? name,String? Color}){

    print("Laptop Construct");
    print("Laptop Name:$name");
    print("Laptop Color:$Color");

  }
  
}
class MacBook extends Laptop{
  MacBook(String?name,String?Color):super(name:name,Color:Color)
  {
    print("MacBook Constructor");
  }

}

void main(){
  MacBook mb =MacBook("Apple", 'Silver');
}
