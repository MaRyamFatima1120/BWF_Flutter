void main(){
  // Growable List

  // Creating an Empty Growable List:
  // There are multiple ways to create an empty growable list in Dart:

  List list1 =List.empty();
  print(list1);
  // 1. Using the List constructor: List<dynamic> myList = List.empty(growable: true);
  List list2 =List.empty(growable: true);
  print(list2.runtimeType);


   // You can also create type specifi List 

  // dynamic list creation using var keyword

  var list3 =["1","2","3",1,2,3];
  print("${list3.runtimeType}:$list3");


    // Create String type List 
  List<String> fruits = []; 
  print(fruits);
  print(fruits.runtimeType);

fruits.add("Apple");
fruits.add("Mangoes");
print(fruits);
  
  
}