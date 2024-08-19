///Example 1: Polymorphism By Method Overriding In Dart
//In this example below, there is a class named Animal with a method named eat(). The eat() method is overridden in the child class named Dog.

class Animal {
  void eat(){
    print("The animal is eating.");
  }
}
class Dog extends Animal{
  @override
  void eat(){
    print("The Dog is Eating.");
  }
}


///Example 2: Polymorphism By Method Overriding In Dart
//In this example below, there is a class named Vehicle with a method named run(). The run() method is overridden in the child class named Bus.
class Vehicle {
  void run(){
    print("Veehicle  is running.");
  }
}
class Bus extends Vehicle{
  @override
  void run(){
    print("Bus is running");
  }
}


///Example 3: Polymorphism By Method Overriding In Dart
//In this example below, there is a class named Car with a method named power(). The power() method is overridden in two child classes named Honda and Tesla.

class Car {
  void power(){
    print("It runs on Petrol.");
  }
}

class Honda extends Car{
  @override
  void power(){
    print("It runs on electricity");
  }
}

class Tesla extends Car{
  @override
  void power(){
    print("It runs on electricity also.");
  }

}

///Example 4: Polymorphism By Method Overriding In Dart
// this example below, there is a class named Employee with a method named salary(). The salary() method is overridden in two child classes named Manager and Developer.
class Employee{
  void  salary(double? salary){
    print("The Employee Salary is $salary");
  }
}
class Manager extends Employee{
  @override
  
  void salary(double? salary){
    print("The Manager Salary is $salary");
  }
}

class Developer extends Employee{
  @override
  void salary(double? salary){
    print("The Developer Salary is $salary");
  }

}

void main(){
  //Example1

  Animal animal =Animal();
  animal.eat();
  Dog  dog =Dog();
  dog.eat();


  //Example 2

  Vehicle v1 = Vehicle();
  v1.run();

  Bus b1 =Bus();
  b1.run();
  //Example 3
  Tesla t1 =Tesla();
  t1.power();

  //Examplee4
  Developer d1 =Developer();
  d1.salary(1000000);

}