

void main(){
   // more about fixed length list 

  // Filled Method: List.filled(3, [])

  final shared =List.filled(3, []);
  print(shared);

  shared[0].add(444);
  print(shared);

  // List<E>.generate constructor

  final unique =List.generate(3, (index) => null);
  print(unique);

  // again
  final unique1 =List.generate(3, (index) => []);
  print(unique1);
  unique1[1].add(444);
  print(unique1);


   // take another example with growable: true

   List<int> growableList =List.generate(3, (index) => index*index,growable: true);
   print(growableList);
  List <int> newLst = List.from(growableList);
  print("New List : $newLst");

// take another example with growable: false
List<int> growableList1 =List.generate(3, (index) => index*index,growable: false);
   print(growableList1);
   List <int> newLst1 = List.from(growableList1);
  print("New List : $newLst1");

  
  // List<E>.unmodifiable constructor
  // Creates an unmodifiable list containing all elements.
  // An unmodifiable list cannot have its length or elements changed. If the elements are themselves immutable, then the resulting list is also immutable.

final number =<int> [1,2,3];
final unmodified=List.unmodifiable(number);
//unmodified[2]=84;// // Throws.
print(unmodified);

}