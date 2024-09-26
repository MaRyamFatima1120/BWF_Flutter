void main(){
  // Fixed length list

  // Creating a Fixed-Length List
  // There are multiple ways to create a fixed-length list in Dart:

  // 1. Using the List.filled() constructor:
  List<dynamic> myList=List.filled(3, null);  // Creates fixed-length list.
  print(myList);



  List myList1=List.filled(3, 0);  // Creates fixed-length list.
  print(myList1);

  //if we use nestedList in List.filled
  List<dynamic>nestedList =List.filled(4, [1,2,3,5]);
  print(nestedList);

  //setAll

 nestedList[0] =87;
 nestedList.setAll(1, [3,8]);
 print(nestedList);


  // 2. Using the List.generate() constructor: 

  List<dynamic> myFixedValue=List.generate(2, (index) => null);
  print(myFixedValue);
  print(myFixedValue.runtimeType);


  /*
  
    2 represents the length of the list you want to create. In this case, the list will have 2 elements.

    (index) => null is a function that defines how each element of the list will be generated. The index parameter represents the index of the current element being generated.

    In this specific case, the function (index) => null simply returns null for each element. It means that the resulting list will have 2 elements, and all elements will be null.

  */


  // Here's an example to demonstrate the usage of List.generate():

  List<int> newList = List.generate(5, (index) => index * 2);
  print(newList);

  /*

    In this example, the List.generate() method creates a list of length 5. 
    The function (index) => index * 2 is used to generate each element. 
    
    The function takes the index as a parameter and multiplies it by 2. 
    So, the resulting list will be [0, 2, 4, 6, 8].
  
    You can customize the function inside List.generate() to generate elements based on any desired logic or calculations.

  */


 
}