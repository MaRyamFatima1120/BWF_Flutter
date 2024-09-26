

///Create a class Camera with properties: name, color, megapixel. Create a method called display which prints out the values of the three properties. Create two objects of the class Camera and call the method display.

class Camera {
  String? name;
  String? color;
  double? megapixel;
  void display(){
    print("Name: $name");
    print("Color:$color");
    print("MexaPixels:$megapixel");
  }
}

void main(){

  Camera camera1  =Camera();
  camera1.name = "DSLR";
  camera1.color = "Black";
  camera1.megapixel = 1000;
  camera1.display();

  Camera camera2  =Camera();
  camera2.name = "SLR";
  camera2.color = "Blue";
  camera2.megapixel = 2000;
  camera2.display();



//Home
Home home1 =Home();
home1.name ="Munawar House";
home1.address="55";
home1.numberOfRooms = 5;
home1.display();


}

///Create class Home with properties name, address, numberOfRooms. Create a method called display which prints out the values of the properties. Create an object of the class Home and set the values of the properties. Call the method display to print out the values of the properties.

class Home{
  String? name;
  String? address;
  int? numberOfRooms;

  void display(){
    print("Name: $name\nAddress:$address\nNumber of Rooms:$numberOfRooms ");
  }
}


