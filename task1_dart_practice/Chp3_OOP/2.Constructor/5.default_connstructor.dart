///Default Constructor
///The constructor which is automatically created by the dart compiler if you don’t create a constructor is called a default constructor. A default constructor has no parameters. A default constructor is declared using the class name followed by parentheses ().

///Example 1: Default Constructor In Dart
///In this example below, there is a class Laptop with two properties: brand, and price. Lets create constructor with no parameter and print something from the constructor. We also have an object of the class Laptop called laptop.
///

class Laptop{
  String? brand;
  int? price;
  Laptop(){
    print("This is default constructor");
  }



}

///Challenge
///Try to create a class Person with two properties: name, and planet. Create a default constructor to initialize the values of the planet to earth. Create an object of the class Person, set the name to “Your Name” and print the name and planet.
///
class Person{
  String? name;
  String? planet;

  //default Constructor
  Person(){
    print("This is Person Challenge Class");
    planet = "Earth";
  }
}

void main(){
  Laptop laptop =Laptop();//It's will be run.

  //Person
  Person person1 =Person();
  person1.name = "Maryam";
  person1.planet ="Mars";
  print("Person Name is ${person1.name}");
  print("Planet Name is ${person1.planet}");
}