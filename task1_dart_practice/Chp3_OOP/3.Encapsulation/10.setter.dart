///In this example below, there is a class named NoteBook. The class has two private properties _name and _prize. There are two setters name and price to update the value of the properties. There is also a method display to display the value of the properties.


class NoteBook{
  String? _name;
  double? _prize;

  //setter
  set name(String name){
    this._name =name;
  }

  set price(double price){
    this._prize =price;
  }

  //method
  void display(){
    print("NoteBook Name:$_name");
    print("NoteBook Price is $_prize");
  }
  
}
void main(){
  NoteBook noteBook = NoteBook();
  noteBook.name ="English";
  noteBook.price = 1000;
  noteBook.display();
}