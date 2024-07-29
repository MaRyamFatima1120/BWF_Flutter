import '1.Class.dart';

void main(){
  // Here animal is object of class Animal.

  Animal animal = Animal();
  animal.name ="Elephant";
  animal.numberOfLegs =4;
  animal.lifeSpan= 5;
  animal.display();


  //Area

  Area area = Area();
  area.breadth =10;
  area.length =5;
  area.calculateArea();
  


  // Student
  Student std = Student();

  std.name ="Ali";
  std.age =18;
  std.grade ="A+";

  std.displayInfo();


//Book
  Book book1=Book();
  book1.name ="Story OF Life";
  book1.author = "Written by Maryam ";
  book1.price = 1000;
  
  book1.display();
}
