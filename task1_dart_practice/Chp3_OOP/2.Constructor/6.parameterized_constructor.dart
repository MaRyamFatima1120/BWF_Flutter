
///Example 1: Parameterized Constructor In Dart
///In this example below, there is a class Student with three properties: name, age, and rollNumber. The class has one constructor. The constructor is used to initialize the values of the three properties. We also have an object of the class Student called student.
///

class Student{
  String? name;
  int?age;
  int? rollNumber;

  Student(this.name,this.age,this.rollNumber);



}


///Example 2: Parameterized Constructor With Named Parameters In Dart
///In this example below, there is a class Student with three properties: name, age, and rollNumber. The class has one constructor. The constructor is used to initialize the values of the three properties. We also have an object of the class Student called student.

class Student1 {
  String? name;
  int? age;
  int? rollNumber; 
  Student1({String?name,int?age,int?rollNumber}){
    this.name =name;
    this.age =age;
    this.rollNumber = rollNumber;
  }


}
///Example 3: Parameterized Constructor With Default Values In Dart
///In this example below, there is class Student with two properties: name, and age. The class has parameterized constructor with default values. The constructor is used to initialize the values of the two properties. We also have an object of the class Student called student.

class Student2{
  String? name;
  int? age;

  Student2({String?name ="Noor",int? age =21})
  {
      this.name=name;
      this.age =age;
  }



}

void main(){
  Student std1 =Student("John",20,1);
  print("Student Data Displayed");
  print("Name:${std1.name}");
  print("Age is ${std1.age}");
  print("Roll Number is ${std1.rollNumber}");


 print("Student Data Displayed");
 Student1 std =Student1(name:"Maryam Fatima",age: 20,rollNumber: 17 );
 print("Student Name is ${std.name}.\nHer age is ${std.age}.\nMy Roll Number is ${std.rollNumber}.");


 print("Student Data Displayed");
 Student2 std2 =Student2( );
 print("Student Name is ${std2.name}.\nHer age is ${std2.age}.");
}