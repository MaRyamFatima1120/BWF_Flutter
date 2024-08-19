void main(){

   // Some More Methods 
  
  // 27. replaceRange() method:
  // The replaceRange() method is used to replace a range of elements in a list with the elements of another iterable. It modifies the original list in place

  List<dynamic> number=[1,3,4,5,6];
  number.replaceRange(2,4,[10,20,30,40]);
  print("replaceRange() Function apply here:${number}");

  //  // 28. setAll() method:
  // The setAll() method is used to update the values of a list by applying a function to each element's index. It modifies the original list in place.

  number.setAll(1, [30]);
  print("setAll() Function apply here:${number}");


  // // 29. shuffle() method:
  // The shuffle() method is used to randomly shuffle the elements of a list. It modifies the original list in place. 


  number.shuffle();
  print("Shuffle Function apply here:${number}");


    // 30. sublist() method:
  // The sublist() method is used to extract a portion of a list and create a new list containing those elements. It does not modify the original list. 

  number=[1,24,54,85,3434,454,324];
  List<dynamic> sublist=number.sublist(2,4);

  print("SublistFunction apply here:${sublist}.I creates a new list .");


   // 31. where() method:
  // The where() method is used to filter a list based on a condition and create a new list containing the elements that satisfy the condition.


  
  print( number.where((element) => element%2==0).toList());

  //// 32. skip() method:
  // The skip() method is used to create a new list that excludes the first n elements from an existing list
  List<dynamic>skipItem=number.skip(2).toList();
  print("It removes from index2 to last index element .Element's must be skip.such as ${skipItem}");

     // 33. skipWhile() method:
  // The skipWhile() method is used to create a new list that excludes elements from an existing list until a condition is no longer satisfied.

  List <int> skippedItems=[12,43,56,768,343,443,342,563];
  print(skippedItems.skipWhile((value) => value<3).toList());


  // 34. take() method:
  // The take() method is used to create a new list that includes the first n elements from an existing list


  print(skippedItems.take(2).toList());//take first 2 element from skippedItems

    // 35. whereType() method:
  // The whereType() method is used to create a new list that includes only the elements of a specific type from an existing list.

  List<dynamic> typeItem=[1,"One",2,"two",3,"three"];
  print(typeItem.whereType<String>());
  print(typeItem.whereType<int>());
}