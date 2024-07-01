///Example 1: Encapsulation In Dart
//In this example, we will create a class named Employee. The class will have two private properties _id and _name. We will also create two public methods getId() and getName() to access the private properties. We will also create two public methods setId() and setName() to update the private properties.

class Employee{
  int? _id;
  String? _name;

  //two public methods getId()
  int getId(){
    return _id!;
  }

  String getName(){
    return _name!;
  }

  int setId(int id ){
    return this._id =id;
  }

  String setName(String name){
    return this._name =name;
  }
}

void main(){
  Employee emp =Employee();
  emp.setId(1);
  emp.setName("Amber");
  print("Employee ID is ${emp.getId()}");
  print("Employee Name is ${emp.getName()}");
}