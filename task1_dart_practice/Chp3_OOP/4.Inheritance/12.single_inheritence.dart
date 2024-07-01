///In this example below, there is super class named Car with two properties name and price. There is sub class named Tesla which inherits the properties of the super class. The sub class has a method display to display the values of the properties.

class Car{
  String? name;
  int? price;

}
class Tesla extends Car{
  void  display(){
    print("Tesla Details");
   print("Name:$name");
   print("Price:$price");
  }
  
}
void main(){
  Tesla car =Tesla();
  car.name="Tesla Model S";
  car.price=100000000000;
  car.display();
}
