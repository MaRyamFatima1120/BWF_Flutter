import 'dart:io';
void main(){


print("Enter your Destination Zone:");
String? destinationZone =stdin.readLineSync();

print("Enter Weight:");
//int weightINKgs=6;
int weightINKgs =int.parse(stdin.readLineSync()!);
/*
if(destinationZone =="PQR"){
  var cost = 10* weightINKgs;

  print("The total Shipping cost is $cost");

}
else if(destinationZone=="XYZ"){
  print("The total Shippig Cost is ${weightINKgs*5}");
}
else if(destinationZone =="ABC"){
  print("The total Shipping cost is ${weightINKgs*7}");
}
else {
  print("You enter wrong entry");
  
}
*/
//Do it with Switch Statement
switch(destinationZone){
  case "PQR":
  print("Shipping Cost is ${10* weightINKgs}");
  break;
  case "ABC":
  print("Shipping Cost is ${7* weightINKgs}");
  break;
  case "XYZ":
  print("SHipping Cost is ${5*weightINKgs}");
  break;
  default:
  print("Wrong USer input");
}
}