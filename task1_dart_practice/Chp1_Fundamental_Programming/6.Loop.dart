void main(){

/*
///For Loop
///  //for(initialization;condition;increment/decrement){
///     //i++  -> i=i+1
///     //i--  -> i=i-1
///     //i+=2   -> i=i+2
/// 
/// }
  for(int i=1; i<=20;i++){
    print("${i}.Hello, Maryam");
    //print("${i}.Hello, Maryam".substring(3,9));

  }

  for(int i=10; i>=1;i--){
    print("${i}.Hello,Father");
    //print("${i}.Hello, Maryam".substring(3,9));
    
  }
//String substring
  String name ="Maryam";
  for(int i =0; i<name.length;i++){
    print(name[i]);
  }


  */


  ///While LOOP
  ///while(condition)

String value ="Maryam";
  int i = 0;
  while(i<value.length){
    print(value[i]);
    i++;
  }

int a=1;

while(a<=10){
  print("${a}.Hello Maryam ");
  a++;
}
/*//do while Loop

do{
  print(i<value.length);
  i++;
}while(i!=i);*/

//break
String name = "Maryam Fatima";

for(int i=0;i<name.length;i++){
  if(i==1 || i==2 || i==3 || i==4 || i==5){
    continue;
  
  }
  print(value[i]);

  
}


}



