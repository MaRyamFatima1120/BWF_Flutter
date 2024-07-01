void main(){
  var someValue ='10';
  final someValue2 =20;
  const pi=3.14;
  print(someValue);
  print(someValue2);
  print(pi);
  print(
    '--------------------------'
  );

  someValue ='10000';
  print(someValue);
  /*It's give error 
  someValue2=42;
  print(someValue2);

  pi=4.31;
  print(pi);
  */


  //null 
  String? someValue3; // nullable
  print(someValue3);

  final num=null ;
  print(num);
  ///print(num.Length);
  ///print(num!.Length);
print(num?.length);

}