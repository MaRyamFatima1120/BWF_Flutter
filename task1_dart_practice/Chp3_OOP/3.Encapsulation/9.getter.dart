
///Example 1: Getter In Dart
///In this example below, there is a class named Person. The class has two properties firstName and lastName. There is getter fullName which is responsible to get full name of person.

class Person {
  String? firstName;
  String? lastName;

  Person(this.firstName, this.lastName);

  String get fullName {
    return '$firstName $lastName';
  }
}

///In this example below, there is a class named NoteBook. The class has two private properties _name and _prize. There are two getters name and price to access the value of the properties. If you provide a blank name, then it will return No Name.

class NoteBook {
  String _name;
  double _prize;
  //Constructor
  NoteBook(this._name, this._prize);
  //getter
  String get name {
    if (_name == "") {
      return "No Name";
    }
    return this._name;
  }
  //getter
  double get price {
    return _prize;
  }


}

///Example 4: Getter In Dart
///In this example below, there is a class named Doctor. The class has three private properties _name, _age and _gender. There are three getters name, age, and gender to access the value of the properties. It has map getter to get Map of the object.
///
class Doctor{
  String _name;
  int _age;
  String _gender;

  Doctor(this._name,this._age,this._gender);

  //getter
  String get name => this._name;
  int get age => this._age;
  String get gender => this._gender;

  Map <String , dynamic > get map{
    return {"name":_name,"Age":_age,"Gender":_gender};
  }
}

void main() {
  //Doctor
  Doctor doctor =Doctor("Dr.Abid", 20, "Male");
  print(doctor.map);
  

  //NoteBook
  NoteBook nb = NoteBook("",1000.0);
  print(nb.name);
  print(nb.price);

  //Person
  Person person = Person("John", "Doe");
  print(person.fullName);
}
