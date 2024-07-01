void main(){
  //  // The properties of a Map

  // 1. entries: The entries property of a Map returns an iterable of key-value pairs, represented as MapEntry objects. Each MapEntry contains the key and value of a pair in the Map.

  Map <String,int> toys={
    'ball': 1,
    'doll': 2,
    'car': 3,
     
  };
  print(toys.entries);
  Iterable <MapEntry<String,int>> itemsToys=toys.entries;
  itemsToys.forEach((element) {
    print("${element.key}:${element.value}");
  });
   // 2. hashCode: The hashCode property returns the hash code value for the Map, which is based on the content and structure of its key-value pairs. It is used for hash-based operations and data structures in Dart.

   int hashcode=toys.hashCode;
   print("Hash Code:$hashcode");

   //is empty
   print("isEmptyItems:${toys.isEmpty}");//false

   //isNoEmpty
   print("isNotEmpty${toys.isNotEmpty}");//true

   // keys: The keys property returns an iterable of the keys in the Map.
   print("Keys:${toys.keys}");// print("isNotEmpty${toys.isNotEmpty}");//true


  //  // values: The values property returns an iterable of the values in the Map.
  print("values:${toys.values}");



  // // lets take one more example 
  Iterable<String> items= toys.keys;
  items.forEach((element){
    print("${element}");
  });

// length: The length property returns the number of key-value pairs in the Map.

print(toys.length);

 // runtimeType: The runtimeType property returns the Type object representing the runtime type of the Map.

print(toys.runtimeType);

// // These properties provide useful information and allow you to work with the keys, values, and structure of a Map in Dart.









}