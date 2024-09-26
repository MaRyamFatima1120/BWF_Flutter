///Example 2: Abstract Class In Dart
///In this example below, there is an abstract class Shape with one abstract method area() and two subclasses Rectangle and Triangle. The subclasses implement the area() method and override it to calculate the area of the rectangle and triangle, respectively
///
abstract class Shape{
  int dim1;
  int dim2;
  Shape(this.dim1,this.dim2);
  void area();
}

class Rectangle extends Shape{

  Rectangle(int dim1,int dim2):super(dim1,dim2);

  @override
  void area() {
    print("The Area of the rectangle is ${dim1 * dim2}");
  }
}

class Trinangle extends Shape{
  Trinangle(int dim1,int dim2):super(dim1,dim2);
  @override
  void area() {
    print("The area of Triangle is ${0.5 * dim1 *dim2 }");
  }
}

void main(){
  Rectangle rectangle =Rectangle(10, 20);
  rectangle.area();
}