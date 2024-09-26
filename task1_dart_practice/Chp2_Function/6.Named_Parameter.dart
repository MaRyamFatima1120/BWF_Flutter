  // Named Parameter

  // Named parameters allow you to specify arguments using their parameter names when calling a function. This gives you more flexibility in passing arguments and improves code readability. 
  void main(){
  // Here's an example:
  InfoUser(name:"Maryam",age:19);
  Area(width: 10, height: 5);
 
  }

   void InfoUser({required String name,required int age}){
    print("Name:$name");
    print("Age:$age");
    

  }


    // Example 2: Function to calculate the area of a rectangle (with named parameters)



    void Area({required int width,required int height}){
      print(width*height);
    }
  
