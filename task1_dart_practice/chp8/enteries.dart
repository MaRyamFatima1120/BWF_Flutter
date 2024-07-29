

void main(){
    // Map<K, V>.fromEntries constructor

  // The fromEntries constructor in the Map class in Dart creates a new map from a sequence of key-value pairs called entries. It takes an iterable of entries and returns a map where each entry's key-value pair is added to the map.
// The fromEntries constructor is useful when you have a sequence of key-value pairs and want to create a map from them. It can be used

var enteries=[
  MapEntry("Apple", 5),
  MapEntry("Mangoes", 7),
  MapEntry("orange", 3)
];
var fruitItems=Map.fromEntries(enteries);
print(fruitItems);
print(Map.fromEntries(enteries));

final planetItems=<String,int> {
  "Mercury":54,
  "Mars":42,
  "Venus":67,
  "Earth":92,
  "Saturn":83,
  
};

final newplanet=Map.fromEntries(planetItems.entries);
print(newplanet);



  // In the above example, we have a list of MapEntry objects representing key-value pairs. We use the fromEntries constructor to create a new map called map from these entries. The resulting map contains the key-value pairs from the entries list.

  // The fromEntries constructor is useful when you have a collection of key-value pairs and want to convert them into a map. It provides a convenient way to initialize a map from existing entries or dynamically create a map based on specific conditions or transformations.







}


