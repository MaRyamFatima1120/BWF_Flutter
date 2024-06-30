///Challenge
///Try to create a class Car with three properties name, color, and price and one method display which prints out the values of the three properties. Create a constructor, which takes all 3 parameters. Create a named constructor which takes two parameters name and color. Create an object of the class from both the constructors and call the method display.

class Car{
  String? name;
  String? color;
  int? price;

  Car({this.name,this.color, this.price});
  Car.namedConstructor(this.name,this.color);

}

void main(){
  print("Car Data Displayed!");
  Car car1 =Car(name: "BWM",color: "black");
  print("Car's name:${car1.name}\nCar's Color is ${car1.color}. ");
}