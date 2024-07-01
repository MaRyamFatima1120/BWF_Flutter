void main(){

  Student std1 = Student();
  std1.name = "John";
  std1.age = 25;

  std1.rollNo = 98;
  std1.subject = "CS";
  std1.totalMarks = 100;
  std1.obtainMarks = 78;

  // std1.display();

  std1.display();


}


class Person {
  // Properties
  String? name;
  int? age;

  // Method
  void display() {
    print("Name: $name");
    print("Age: $age");
  }
}

class Student extends Person {

  int? rollNo;
  String? subject;
  double? totalMarks;
  double? obtainMarks;

  @override
  void display(){
    print("Name: $name");
    print("Age: $age");
    print("Roll No: $rollNo");
    print("Subject: $subject");
    print("totalMarks: $totalMarks");
    print("obtainMarks: $obtainMarks");
  }


}


class A {

}

class B extends A {

}

class C extends B{

}

class vehicle {

}

class Toyota extends vehicle{

}


class Honda extends vehicle{
  
}