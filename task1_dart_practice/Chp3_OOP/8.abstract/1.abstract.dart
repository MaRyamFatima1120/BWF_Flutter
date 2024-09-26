///Abstract Class
///Abstract classes are classes that cannot be initialized. It is used to define the behavior of a class that can be inherited by other classes. An abstract class is declared using the keyword abstract.
///
///Abstract Method
///An abstract method is a method that is declared without an implementation. It is declared with a semicolon (;) instead of a method body.
///
///Example 1: Abstract Class In Dart
///In this example below, there is an abstract class Vehicle with two abstract methods start() and stop(). The subclasses Car and Bike implement the abstract methods and override them to print the message.
///

abstract class Vehicle{
  start();
  stop();
}
class Car extends Vehicle{
  @override
  void start(){
    print("Car Started");
  }

  @override
  void stop(){
    print("Car Stopped");
  }

}

class Bike extends Vehicle{
  @override 
  void start(){
    print("Bike Started");
  }

  void stop(){
    print("Bike Stopped.");
  }

}

void main(){
  Car car =Car();
  car.start();
  car.stop();

  Bike b1 =Bike();
  b1.start();
  b1.stop();
  
}