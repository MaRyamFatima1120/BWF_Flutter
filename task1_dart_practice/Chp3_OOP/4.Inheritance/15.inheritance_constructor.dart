///Example 1: Inheritance Of Constructor In Dart
//In this example below, there is class named Laptop with a constructor. There is another class named MacBook which extends the Laptop class. The MacBook class has its own constructor.

class Laptop{
  //Constructor
  Laptop(){
    print("Laptop COstructor");
  }


}

class MacBook extends Laptop{
  //Constructor
  MacBook(){
    print("MacBook Constructor");
  }
}

void main(){
  MacBook mb = MacBook();
}



