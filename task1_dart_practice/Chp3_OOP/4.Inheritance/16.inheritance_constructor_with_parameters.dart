///Example 2: Inheritance Of Constructor With Parameters In Dart
//In this example below, there is class named Laptop with a constructor with parameters. There is another class named MacBook which extends the Laptop class. The MacBook class has its own constructor with parameters


class Laptop {
  //Constructor
  Laptop(String brand,String Color){
    print("Laptop Constructor");
    print("Brand:$brand");
    print("Laptop Color:$Color");

  }
}

class MacBook extends Laptop{
  //Constructor
  MacBook(String brand,String Color):super(brand,Color){
    print("MacBook Constructor");
   
  }

}

void main(){
  MacBook mb =MacBook("Apple","Black");
  
}