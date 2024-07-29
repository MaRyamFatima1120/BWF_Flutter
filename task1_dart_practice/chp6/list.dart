void main(){
  /*
  ******** What is a List? ********

    A list is an ordered collection of items in Dart. It allows you to store and manipulate multiple values of different types under a single variable name and access them by their index.*/

    List <dynamic> stdName =["Amber",19,923176468955,"BWP"];
    print("Student Data:$stdName and its type is ${stdName.runtimeType}");
/*
  ******** Index: ********

    Each element has its index number that tells the element position in the list. The index number is used to access the particular element from the list, such as list_name[index]. 
*/

     print("Student Data:${stdName[0]} and its type is ${stdName.runtimeType}");

     /*
    The list indexing starts from 0 to length-1 where length denotes the numbers of the element present in the list. For example, - The length of the above list is 4.*/

     print("Student Data:${stdName.length} and its type is ${stdName.runtimeType}");


    /*
   
  ******** Usage of Lists with Real-Life Examples: ********

    Imagine you have a shopping list where you need to keep track of various items you want to buy. You can use a list to store all the items in a structured and ordered manner.
    
    Similarly, you can use a list to store a series of student names, temperatures recorded throughout a day, or any other set of related data.*/

  //Another way of List
  var stdData = <String> ["1","2","3"];
  print(stdData.runtimeType);


 }