void main() {
  // List Properties

  List<dynamic> items = ["Apples", "Mangoes", "Banana", "Gauva"];
  // 1. length: Returns the number of elements in the list.
  print("Item's Length is:${items.length}");

  // 2. isEmpty: Returns true if the list is empty (has no elements), otherwise false.
  print("List is Empty:${items.isEmpty}");
  // 3. isNotEmpty: Returns true if the list is not empty (has elements), otherwise false.
  print("isNot Empty List is:${items.isNotEmpty}");

  // 4. first: Returns the first element of the list.
  print("First Element of items:${items.first}");

  // 5. last: Returns the last element of the list.
  print("Last's Element of items:${items.last}");

  // 6. reversed: Returns an iterable with the elements of the list in reverse order.
  print("Reserved Items: ${items.reversed}");

  // 7. hashCode: Returns the hash code of the list.
  print("Hash Code of Items:${items.hashCode}");

  // 8. runtimeType: Returns the type of the list at runtime.
  print("Hash Code of Items:${items.runtimeType}");

  // 9. Single
  // The single property of the Iterable class is used to retrieve the single element from an iterable with only one element. It throws an error if the iterable is empty or contains more than one element.
    List<dynamic> singleElement=[3];
    print("Single Element is available ${singleElement.single}");


  // print("Single Element of Items:${items.single}"); //so items is empty or items  contains more than one element.

  // However, if the list has no elements or contains multiple elements, using the single property will result in an error. Here are examples of such scenarios:

 // List<dynamic> isEmpty = [];
  //print("Single Element is not available${isEmpty.single}");


}
