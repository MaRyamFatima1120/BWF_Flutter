///Example 3: Inheritance Of Constructor
///In this example below, there is class named Person with properties name and age. There is another class named Student which extends the Person class. The Student class has additional property rollNumber. Lets see how to create a constructor for the Student class.

class Person{
  String? name;
  int? age;

  //Constructor
  Person(this.name,this.age);
}
class Student extends Person{
  int? RollNumber;

  Student(String name,int age,this.RollNumber):super(name,age);

}

void main(){
  Student  std = Student("John", 10, 20);
  print("Student Name is ${std.name}");
  print("Student Age is ${std.age}");
  print("Student's Roll number ${std.RollNumber}");
}