
void main(){
  // List Methods 



List<int> numbers = [1,2,3,4,6,7,8,9,10];

// 1. add() - Adds an element to the end of the list.
numbers.add(12);  
print(numbers);


  // 2. addAll() - Adds all elements from another iterable to the end of the list.
  numbers.addAll([13,14,15]);
  print(numbers);

 // 3. insert() - Inserts an element at a specified index in the list.
  numbers.insert(9,11);
  print(numbers);


  // 4. insertAll() - Inserts all elements from another iterable at a specified index in the list.
  List<int> number1=[20,21,22,23,24,];
  numbers.insertAll(14,number1); 
  print(numbers);

  // 5. remove() - Removes the first occurrence of an element from the list.
    numbers.remove(1);
    print(numbers); //Remove element 1 which has on index0


 // 6. removeAt() - Removes the element at a specified index from the list.
  numbers.removeAt(1);          //Remove elementt at specific index 1
  print(numbers);

  // 7. removeLast() - Removes the last element from the list.
   numbers.removeLast();     // Removes the last element which is   
  print(numbers);



  // 8. removeWhere() - Removes all elements that satisfy a given condition from the list.
  //numbers.removeWhere((element) => false)

  // 9. sort() - Sorts the elements of the list in ascending order.

  List<String> items=["Mangoes","Guava","Banana","Apples"];
  items.sort();
  print(items);


  // 10. indexOf() - Returns the index of the first occurrence of an element in the list.

  int myItem=items.indexOf("Guava");
  print(myItem);


   // 11. contains() - Returns true if the list contains a specific element, otherwise false.

    numbers=[1,2,3,4,5];
    bool num=numbers.contains(3);
    print(num);


    // 12. forEach() - Applies a function to each element in the list.
  numbers.forEach((element) {
      print(element);
    });

    items.forEach((items) {
      print(items);
    });

     // 13. any method
  // The any() method in Dart is used to check if at least one element in the list satisfies a given condition. It returns true if there is at least one element that meets the condition, and false otherwise. 
  bool isAny=numbers.any((element) => element<5);
  print(isAny);
  isAny=numbers.any((element) => element>5);
  print(isAny);

  
  // 14. clear methods : Removes all objects from this list; the length of the list becomes zero.
  // The list must be growable.

  numbers.clear();
  print(numbers);
  numbers.length;
  print("Numbers's Length:${numbers.length}");

   // 16. elementAt() - The elementAt() method is used to retrieve an element at a specified index in the list.

   String item=items.elementAt(3);
   print(item);



  // 17. every() - The every() method is used to check if every element in the list satisfies a given condition. It returns true if all elements meet the condition, and false otherwise.
  List<int> number2 =[0,1,2,3,4,5,6,7,8];
  bool allEvevn=number2.every((element) => element%2==0);
  print(allEvevn);

  bool allOdd=number2.every((element) => element!=0  );
  print(allOdd);





  //  // 18. expand() - The expand() method is used to transform each element of a list into zero or more elements, and then flatten the results into a single list.
  List<List<int>> expandNumbers=[[1,2],[3,4],[5,6]];
  List<int> flattenedList = expandNumbers.expand((list) => list).toList();
  print(flattenedList);
  

}