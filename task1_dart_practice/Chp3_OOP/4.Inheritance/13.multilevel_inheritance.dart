///In this example below, there is super class named Car with two properties name and price. There is sub class named Tesla which inherits the properties of the super class. The sub class has a method display to display the values of the properties. There is another sub class named Model3 which inherits the properties of the sub class Tesla. The sub class has a property color and a method display to display the values of the properties.
///
class Car{
  String? name;
  double? price;

}
class  Tesla extends Car{
  void display(){
    print("Details");
    print("Name is:$name");
    print("Price is:$price");
  }

}
class Model3 extends Tesla{
  String? Color;
  void display(){
    super.display();
    print("Color is $Color");
  }

}
void main()
{
  Model3 md3 =Model3();
  md3.name="Tesla Model 3";
  md3.price = 110000000;
  md3.Color = 'Golden';
  md3.display();
}