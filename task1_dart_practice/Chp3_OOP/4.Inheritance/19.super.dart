import 'dart:math';

///Example 1: Super In Dart
//In this example below, the show() method of the MacBook class calls the show() method of the parent class using the super keyword.
class Laptop{
  void show(){
    print("Laptop Constructs");
  }
}

class MacBook extends Laptop{
  //method
  //override
  void show(){
    super.show();
    print("MacBook Constructs");
  }
}

void main(){
  //Example1
  MacBook mb =MacBook();
  mb.show();

  //Example 2
  Tesla t1 =Tesla();
  
  t1.display();

  //Example 3
  Manager emp =Manager("Ali", 200000000);

  //Exammple4:
  Manager1 m1 = Manager1.manager();


  ///Example5
  MacBookPro macbook =MacBookPro();
  macbook.display();
  
}

///Example 2: Accessing Super Properties In Dart
//In this example below, the display() method of the Tesla class calls the noOfSeats property of the parent class using the super keyword.

class Car{
  int noOfSeats =4;
}
class Tesla extends  Car{
  //override
  int noOfSeats = 3;

  void display(){
    print("The number of Seats in Tesla ${noOfSeats}");
    print("The number of Seats in Cars ${super.noOfSeats}");
  }
}


///Example 3: Super With Constructor In Dart
///In this example below, the Manager class constructor calls the Employee class constructor using the super keyword.
///
class Employee{

  Employee (String name,int salary){
    print("Employee Data");
    print("Name:$name");
    print("Salary:$salary");

    

  }
}

class Manager extends Employee{
  Manager(String name,int salary):super(name,salary){
    print("Manager Name:$name and Manager Salary:$salary");
  }
}


///Example 4: Super With Named Constructor In Dart
///In this example below, the Manager class named constructor calls the Employee class named constructor using the super keyword

class Employee1{
  //Named COnstructor
  Employee1.manager(){
    print("Employee Named Constructor");
  }

}
class Manager1 extends Employee1{
  Manager1.manager():super.manager(){
    print("Manager Constructs");
  }
}


///Example 5: Super With Multilevel Inheritance In Dart
//In this example below, the MacBookPro class method display calls the display method of the parent class MacBook using the super keyword. The MacBook class method display calls the display method of the parent class Laptop using the super keyword.

class Laptop1{
  void display(){
    print("Laptop is displayed");
  }
}
class MacBook1 extends Laptop1{
  void display(){
    super.display();
    print("MAcBOok is Displayed!");
  }
}

class MacBookPro extends MacBook1{
  void display(){
    super.display();
    print("MacBookPro is displayed.");
  }
}