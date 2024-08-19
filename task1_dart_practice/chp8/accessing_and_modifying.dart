void main(){
  
  // Accessing and Modifying Map Elements

  
  // Accessing Values using Keys:
  // To access the value associated with a specific key in a map, you can use the square bracket notation ([]) or the forEach method.
   

  // 1: Using square bracket notation
  //Working on it using with ages
  Map<String,int> ages={
  "Ahmad":23,"Noor":30,"Munawar":63
  };

  int? ageMunawar=ages['Munawar'];
  print(ageMunawar);

  // we can print these values direct using print function
  print(ages['Ahmad']);
  print(ages['Noor']);
  print(ages['Munawar']);

  // 2: Using forEach method
  ages.forEach((key, value) {
    if(key=="Ahmad"){
      print("Ahmad's age is :$value");
    }
  });

  //  // Modifying Values Associated with Keys:
  // To modify the value associated with a key in a map, you can use the square bracket notation ([]).

ages['Munawar']=65;
print(ages['Munawar']);


 // Adding New Key-Value Pairs to a Map:
  // To add a new key-value pair to a map, you can use the square bracket notation ([]) with a new key.


  ages["Raiz"]=43;
  print(ages);

    // Note one thing: Map dosen't allow duplicate keys. If key is already have in map then its value is updated other wise new key is added to the map 


  // Removing Key-Value Pairs from a Map:
  // To remove a key-value pair from a map, you can use the remove method or the removeWhere method.
    // 1: Using remove method
 ages.remove('Munawar');
 print(ages);


 //2.Using removeWhere Method

 ages.removeWhere((key, value) => key=="Noor");
 print(ages);








}