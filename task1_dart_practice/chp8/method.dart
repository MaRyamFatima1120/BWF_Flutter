void main(){
    // Map Methods
  
  // Here's an explanation of the methods available for a Map in Dart, along with examples:

  // 1. addAll: The addAll method adds all the key-value pairs from another map to the current map.
  // Example:

  Map<String,int>planetCount={
    "Mercury":1,
    "Venus":2,
    "Mars":3,
  };
 planetCount.addAll({"Earth":5});
  print(planetCount); // Output: {Mercury: 1, Venus: 2, Mars: 3, Earth:5

  // 2. addEntries: The addEntries method adds multiple entries to the current map.\

  Map<String,int>map={};

  MapEntry<String, int>entry1 =MapEntry("Mahreen", 2);
  MapEntry<String, int>entery2 =MapEntry("Pagal Mahreen", 3);
  map.addEntries([entry1,entery2]);
  print(map);

  // // 3. cast: The cast method returns a new map with the same keys and values as the original map but with a different type.

  Map<Object, Object> newMap = {'apple': 1, 'banana': 2};

  Map<String, int> castedMap = newMap.cast<String, int>();
  print(castedMap); // Output: {apple: 1, banana: 2}

}