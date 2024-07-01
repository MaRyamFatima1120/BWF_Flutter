import 'dart:math';

///In Dart, the static keyword is used to declare class-level variables and methods. This means that static variables and methods belong to the class itself, not to instances of the class. They can be accessed directly using the class name, without creating an instance of the class. This is useful when you have data or methods that aren't tied to specific objects, but rather to the class as a whole

//How To Declare & intialized A Static Variable In Dart

///class ClassName{
///static datatype variableName = value;}
///
///
///Example 1: Static Variable In Dart
///In this example below, there is a class named Employee. The class has a static variable count to count the number of employees.

class Employee {
  static int count = 0;

//method

  void total_Employee() {
    count++;
    print("Total Employees are $count.");
  }
}

////Example 2: Static Variable In Dart
//In this example below, there is a class named Student. The class has a static variable schoolName to store the name of the school. If every student belongs to the same school, then it is better to use a static variable.

class Student{
  int? id;
  String? name;
  static String? schoolName ="ABC,School";

  //Constructor
  Student(this.id,this.name);

  //method
  
  void display(){
    print("Student id is ${this.id} and Student Name is ${this.name} and SchoolName is ${Student.schoolName}");
  }
}


///Dart Static Method
//A static method is shared by all instances of a class. It is declared using the static keyword. You can access a static method without creating an object of the class.

//Example 3: Static Method In Dart
///In this example, we will create a static method calculateInterest() which calculates the simple interest. You can call SimpleInterest.calculateInterest() anytime without creating an instance of the class.

class SimpleInterest{
  static double calculateInterest(double principal,double rate,double time){
    return  (principal * rate * time)/100;
  }
  
}


///Example 4: Static Method In Dart
///In this example below, there is static method generateRandomPassword() which generates a random password. You can call PasswordGenerator.generateRandomPassword() anytime without creating an instance of the class.
///
class PasswordGenerator{
  static String generateRandomPassword(){
    List<String> alphabets ="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".split('');
    List<int > numbers = [0,1,2,3,4,5,6,7,8,9];
    List <String> specialCharacters =["!","@","#","%","^","&","*","(",")"];
    List<String> password =[];
    for(int i =0; i<3; i++){
      password.add(alphabets[Random().nextInt(alphabets.length)]);
      password.add(numbers[Random().nextInt(numbers.length)].toString());
      password.add(specialCharacters[Random().nextInt(specialCharacters.length)]);
    }
    return password.join();
  }
}






void main() {
  //Example 1

  // Creating objects of Employee class

  Employee e1 = Employee();

  Employee e2 = Employee();
  Employee e3 = Employee();
  Employee e4 = Employee();

  e1.total_Employee();
  e2.total_Employee();
  e3.total_Employee();
  e4.total_Employee();


  //Example2

  Student st1 =Student(17, "Maryam");
  st1.display();

  Student st2 =Student(20, "Noora");
  st2.display();


  //Example3 without calling object with the help of static
  print("Simple Interest is ${SimpleInterest.calculateInterest(10, 15, 12)}");


  //Example4 
  print("Password is ${PasswordGenerator.generateRandomPassword()}");
}
