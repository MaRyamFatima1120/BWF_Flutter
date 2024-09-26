///Hierarchical Inheritance In Dart
//In this example below, there is class named Shape with two properties diameter1 and diameter2. There is sub class named Rectangle with method area to calculate the area of the rectangle. There is another subclass named Triangle with method area to calculate the area of the triangle.

class Shape{
  double? diameter1;
  double? diameter2;

}
class  Rectangle extends Shape{
  //method
  double area(){
    return diameter1! * diameter2!;
  }
}

class Triangle extends Rectangle{
  double area(){
    return 0.5*diameter1!*diameter2!;
  }

}

void main(){
  Rectangle rect =Rectangle();
  rect.diameter1=5;
  rect.diameter2 =10;
  print("Rectangle is ${rect.area()}");

  //Triangle
  Triangle tri =Triangle();
  tri.diameter1 =10;
  tri.diameter2 =5;
  print("Triangle  is ${tri.area()}");
}