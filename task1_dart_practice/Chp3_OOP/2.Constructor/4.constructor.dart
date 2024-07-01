

///In this example below, there is a class Student with three properties: name, age, and rollNumber. The class has one constructor. The constructor is used to initialize the values of the three properties. We also created an object of the class Student called student.

class Student{
  //Properties
  String? name;
  int? age;
  int? rollNumber;

  //Constructor

  Student(String myname,int myage,int myrollNumber){
    this.name =myname;
    this.age =myage;
    this.rollNumber = myrollNumber;

  }
  void display(){
    print("Student's Name:${this.name}");
    print("Age is ${this.age}");
    print("Roll Number is ${this.rollNumber}");
  }
}

void main(){
  Student std =Student("Maryam",20,17);
  std.display();

  //Teacher1
  Teacher teacher1 =Teacher("Miss Maryam", 20, "Computer Science", 10000000 );
  teacher1.display();

  Teacher teacher2 =Teacher("Miss Amna",30,"IT",60000);
  teacher2.display();


  //Person data
  Person p1 =Person("Ali", 37, "Physics", 200000);
  p1.display();

  //Employee
  Employee emp=Employee("Ateeq", 40,"IT",40000);
  emp.display();
}


///In this example below, there is a class Teacher with four properties: name, age, subject, and salary. Class has one constructor for initializing the values of the properties. Class also contain method display() which is used to display the values of the properties. We also created 2 objects of the class Teacher called teacher1 and teacher2.

class Teacher{
  String? name;
  int? age;
  String?  subject;
  double? salary;

  Teacher(String name,int age,String subject,double salary){
    this.name =name;
    this.age =age;
    this.subject =subject;
    this.salary = salary;

  }
  void display(){
    print("Teacher's  Details");
    print("Teacher's Name is ${this.name}.\nHer age is ${this.age}.\nHer SUbject is ${this.subject}.\nHer salary is ${this.salary}");

  }

}

///Example 5: Write Constructor Single Line 
///In the avobe section, you have written the constructor in long form. You can also write the constructor in short form. You can directly assign the values to the properties. For example, the following code is the short form of the constructor in one line.
///
 class Person{
  String? name;
  int? age;
  String? subject;
  double? salary;

  Person(this.name,this.age,this.subject,this.salary);

display(){
  print("Person Data");
  print("Person's Name is ${this.name}\nHer age is ${this.age}\n Her subject is ${this.subject}\nHer salary is ${this.salary}");
}
}


///Example 6: Constructor With Optional Parameters
///In the example below, we have created a class Employee with four properties: name, age, subject, and salary. Class has one constructor for initializing the all properties values. For subject and salary, we have used optional parameters. It means we can pass or not pass the values of subject and salary. The Class also contain method display() which is used to display the values of the properties. We also created an object of the class Employee called employee.
class Employee{
  String? name;
  int?age;
  String? subject;
  double? salary;

  //Constructor
  Employee(this.name,this.age,[this.subject="NA",this.salary=0.0]);

  //method

  void display(){
    print("Employee Data");
    print("Employee Name is ${this.name}.\nHis age is ${this.age}.\nHis subject is ${this.subject}.\nHis salary is ${this.salary}");
  }


}








