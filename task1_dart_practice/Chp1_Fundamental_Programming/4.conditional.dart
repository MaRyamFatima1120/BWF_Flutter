
import 'dart:io';
void main(){
  
  int age =20;

  if(age>=18){
    print('Adult');
    
  }else if(age >=50){
    print("Aged");
  }
  
  else{
    print('Child');
  }

  //Ternary Operator/Conditional Operator

  String someValue='Hi';
  print(someValue.startsWith('H') ? 'Wow':'Nan');


  //switch Statement
  print("Enter your Day:");
  String day =stdin.readLineSync()!;
  
  
  switch(day){
    case 'Sun':
    print("It's may be Sunday.");
    break;
    case 'Sat':
    print("It's may be Saturday.");
    break;
    case 'Mon':
    print("It's may be Monday.");
    break;
    case 'Tues':
    print("It's may be Tuesday.");
    break;
    case 'Wed':
    print("It's may be Wednesday.");
    break;
    case 'Thu':
    print("It's may be Thursday.");
    break;
    case 'Fri':
    print("It's may be Friday.");
    break;
    default:
    print("It's not a dat.May be it is any Month Name.");

    
  
  }


}