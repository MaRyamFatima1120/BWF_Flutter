void main(){
   // More List Methods

  // 19. fillRange method
  
  // The fillRange() method in Dart is used to replace a range of elements in a list with a specified value. It allows you to specify the start and end indices (inclusive) of the range to be filled with the given value

  final words=List<String>.filled(5, 'old');
  print(words);
 // 19. fillRange method
  words.fillRange(0,3,'new');
  print(words);
    /*

    The fillRange() method modifies the original list in place. It takes three arguments:

    The start index (inclusive) specifying where to start replacing elements.
    The end index (inclusive) specifying where to stop replacing elements.
    The value that will replace the elements within the specified range.

  */

    // 20. firstWhere method

  // The firstWhere() method in Dart is used to find the first element in a list that satisfies a given condition. It returns the first element that matches the condition or a default value if no element is found. Here's an explanation of the firstWhere()


List<int> value=[1,2,3,4,5];
//if we keep condition
int first=value.firstWhere((pickItem) => pickItem%2==0, orElse:()=> -1 );
print(first);//output:2

 // The firstWhere() method returns the first element that satisfies the condition, which in this case is 2. If no element satisfies the condition, it returns a default value specified using the orElse parameter. In our example, we specify -1 as the default value. However, since the list contains an even number, the method returns 2.
 //if we keep condition
first=value.firstWhere((pickItem) => pickItem%2!=0, orElse:()=> -1 );
print(first);//output:1


  // 21. The fold() method in Dart is used to combine the elements of a list into a single value. It iterates over the elements of the list, applying a given function to each element and accumulating the result.

 value=[1,2,3,4,5,6,7,8,9,10];
int sum=value.fold(0, (previousValue, element) => previousValue +element);
print(sum);


 // 22. followedBy method
  // Creates the lazy concatenation of this iterable and other.
  // The returned iterable will provide the same elements as this iterable, and, after that, the elements of other, in the same order as in the original iterables.


  var friends=<String>["Laiba Batool,Iqra Naeem"];
  var family=friends.followedBy(["Maryam Naseem","Roman"]);
  print(family.toString().toUpperCase());
  // 23. getRange method
  // The getRange() method in Dart is used to get a sublist of a list. It takes two arguments:

final bestFriend=<String>["Laiba Batool","Iqra Naeem","Maryam Fatima","Maryam Naseem","Roman"];
final bestFriend2=bestFriend.getRange(0, 2);
 // 25. join method

  // Converts each element to a String and concatenates the strings.
  // Iterates through elements of this iterable, converts each one to a String by calling Object.toString, and then concatenates the strings, with the separator string interleaved between the elements.

print(bestFriend2.join(", "));

print(bestFriend2);


 // 24. indexWhere method

  /*

    The first index in the list that satisfies the provided test.

    Searches the list from index start to the end of the list. The first time an object o is encountered so that test(o) is true, the index of o is returned.
  
  */


  List<String> name=["Maryam","Laiba","Marrena","Amber","Maryam Naseem"];

  print(name.indexWhere((element) => element.startsWith("Maryam")));
  print(name.indexWhere((element) => element.startsWith("Maryam"),2));

      // 26. lastWhere method
      print(name.lastWhere((element) => element==name[4]));

      

}


// 26. lastWhere method

