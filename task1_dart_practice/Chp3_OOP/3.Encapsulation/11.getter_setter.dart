///Example 1: Getter And Setter In Dart
///In this example below, there is a class named Student with three private properties _firstName, _lastName and _age. There are two getters fullName and age to get the value of the properties. There are also three setters firstName, lastName and age to update the value of the properties. If age is less than 0, it will throw an error.

class Student{
  String? _firstName;
  String? _lastName;
  int? _age;

  //two getters
  String get fullName{
    return '$_firstName $_lastName';
  }

  int get age{
    return _age!;
  }

  set firstName (String firstname){
    this._firstName =firstname;
  }

  set lastName(String lastName){
    this._lastName=lastName;
  }


  // Setter to update private property _age

  set age(int age){
    if(age <=0 ){
      throw new Exception("This age is not valid");
    }
    this._age =age;
  }

}
  void main(){
    Student std1 =Student();
    std1.firstName ="Maryam";
    std1.lastName ="Fatima";
    std1.age=20;
    print(std1.fullName);
    print("Age:${std1.age}");
  }


