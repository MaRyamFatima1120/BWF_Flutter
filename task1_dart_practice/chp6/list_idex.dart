void main(){
    // Accessing List Items Individual :
  // You can access individual items in the list using their index (starting from 0):

  // first create a list with items 

  List <dynamic> myList = ["Apples","Mangoes","Stawbery","Banana"];

  //Acess Items with Variables
  String firstItems= myList[0]; //camelCase Style
  String secondItems =myList[1];
  //print()function
  print(firstItems);
  print(secondItems);
  //Acess Items  // YOu can  print this direct 
  print(myList[0]);
  print(myList[1]);
  print(myList[2]);

  // // Updating an myList's Value:
  // You can update the value of an item in the list by assigning a new value to the corresponding index:

  myList[0]="Kawi Guava";
  print(myList[0]);

  // You can check the length of the list

  print("My List length is:${myList.length}");


  //this will return the last index of list 
  print(myList.length-1);

  // Access Last element/item of the list

  print(myList[myList.length-1]);

 // Removing an Item from the List:
  // To remove an item from the list, you can use the remove() method and pass the item value:

myList.remove("Mangoes");
print(myList);

myList.removeAt(2);
print(myList);

//  // Remove last item of the list

print("Remove Last Element:${myList.removeLast()}");


  // Remove a range of items
  
//List<dynamic> items =["Laptop","SmartPhone","Mobile"];
//---------------_Facing Error--------------------->
//Give Error
//print("Remove Last Element:${items.removeRange(0, 1)}");

// Remove element from the list on the basis of some condition

//items.removeWhere((index) =>index*2) ;
//print("Remove :$items");


}