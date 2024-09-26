///In this example below, there is class Animal with three properties: name, numberOfLegs, and lifeSpan. The class also has a method called display, which prints out the values of the three properties.

class Animal{
  //Properties
  String? name ;
  int? numberOfLegs;
  int? lifeSpan;
  //Methods
  void display(){
    print("Animal name is $name");
    print("Aminal Leg's $numberOfLegs");
    print("Animal Life year:$lifeSpan");

  }
}


///In this example below, there is class Area with two properties: length and breadth. The class also has a method called calculateArea, which calculates the area of the rectangle.
///
 class Area{
  //Properties
  int? length;
  int? breadth;

  //Methods
  void calculateArea(){
    int area =length !* breadth!;
    print("Area is $area");
  }
 }


 ///In this example below, there is class Student with three properties: name, age, and grade. The class also has a method called displayInfo, which prints out the values of the three properties.
 
 class Student{
  //Properties
  String? name;
  int? age;
  String? grade;


  //Methods

void displayInfo(){
  print("Student Name is $name");
  print("Student Age is $age");
  print("Student grade is $grade");

}

 }

 ///Create a class Book with three properties: name, author, and price. Also, create a method called display, which prints out the values of the three properties.
 ///

class Book{
  String? name;
  String? author;
  int ? price;
// methods
  void display(){
    print("Book Name is $name");
    print("Author Name is $author");
    print("Book Price is  $price");
  }
}