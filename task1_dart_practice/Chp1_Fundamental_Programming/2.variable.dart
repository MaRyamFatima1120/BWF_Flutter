void main() {
  //Variables
  //<datatype> < variable name>= value;
  double firstValue = 10.5;
  int secondValue = 20;
  print(firstValue + secondValue);
  print(firstValue.runtimeType);
  //bool
  bool firstValue1 = true;
  print(firstValue1);

  //dynamic It can take any type of data
  dynamic thirdValue = 10;
  print(thirdValue.runtimeType);

  //int
  int a = 13;
  print(a.isEven);
  print(a.isOdd);

  print(a.abs);

  //String
  String name = "Sachin";
  print(name);

  String number = "10";
  print(number);

  int num = 76;
  print(num);
  num = 643;
  print(num);
  num = -89;
  print(num);

  String greeting = "Hello";
  print(greeting);
  greeting = "$greeting,Maryam Fatima";
  print(greeting);
  greeting = '\$12';

  print(greeting);
  greeting = '''

  Hello World;
''';
  print(greeting);
  greeting = "Hello\n Noora";
  print(greeting);
}
