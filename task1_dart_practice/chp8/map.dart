void main(){
    // Introduction to Map

  /*
  
  ***** What is a Map? *****

    A map is a collection of key-value pairs in Dart. It is also known as an associative array, dictionary, or hash table in other programming languages. Maps provide an efficient way to store and retrieve data based on a unique key.

    Key-Value Pairs:

    In a map, each element consists of a key and its corresponding value. The key acts as a unique identifier or index for the associated value. The key-value pairs are stored together and can be accessed using the key. Keys must be unique within a map, while values can be of any type.*/

  Map<String,dynamic> names={
    "name":"Maryam",
    "age":20,
    "Class":"6th Morning C",
    "Subjects":["Computer Science","python",12]
  };
  print(names);
  print(names.runtimeType);


    // How to create a Map in dart.

  // Creating an Empty Map:
  // To create an empty map in Dart, you can use the Map constructor or the map literal syntax.

  // 1. Using the Map constructor

  Map<String,String> items=Map<String,String>();
  print(items);
  print(items.runtimeType);


   // 2. Using map literal syntax

   Map<String, int> items1={};
  print(items1.toString() +' and items type is ${items1.runtimeType}');


    // Creating a Map with Initial Key-Value Pairs:
  // To create a map with initial key-value pairs, you can use the map literal syntax or the Map.from() constructor.

  // 1: Using map literal syntax


  Map<String,String> capital={
    "Pakistan":"Islamabad",
    "UK":"New york"
  };

  print("Country's Capital is:$capital and its type is ${capital.runtimeType}");


  //  // Creating a Map from a List or Another Map:
  // Dart provides a few methods to create a map from a list or another map.

    // 2. Creating a map by copying another map using the Map.from() constructor

Map<String,dynamic> anotherMap=Map.from(capital);
print(anotherMap);


  // 1: Creating a map from a list using the Map.fromIterable() constructor

  List<String> countries = ['Pakistan', 'Turkiye', 'UAE'];
  Map<String, int> countryMap = Map.fromIterable(
    countries,
    key: (country) => country,
    value: (country) => country.length,
  );
  print("\ncountryMap : $countryMap . Type ${countryMap.runtimeType}");


List<int> friendsNumber=[1,2,3,4,5];
Map<int,String> bestFriend=Map.fromIterable(
  friendsNumber,
  key: (element) => element,
  value: (element) => "is Best Friend So she is ${element%2==0?"True Friend":"Wrong Friend"} ",//conditional expression or ternary operator


);

print(bestFriend);




}