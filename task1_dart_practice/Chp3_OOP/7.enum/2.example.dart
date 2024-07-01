///Example 2: Enum In Dart
///In this example, there is an enum type named Gender. It contains three constants Male, Female, and Other. The Gender enum type is used in the Person class.
enum Gender{
  Male,Female,Other
}

class Person{
  String? firstName;
  String? lastName;
  Gender? gender;

  //constructor
  Person(this.firstName,this.lastName,this.gender);
  //method
  void display(){
    print("Your First Name is:$firstName");
    print("Your LastName is:$lastName");
    print("Your Gender is $gender");
  }
}

void main(){
  Person p1 =Person("Maryam","Fatima",Gender.Female);
  p1.display();
  
}