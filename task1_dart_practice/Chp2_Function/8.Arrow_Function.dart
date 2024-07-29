void main(){
  sayHello();
  Sum(a: 10, b: 5);

}

void sayHello() =>print("Hello,Marry");

void Sum({required int a, required int b}) => print("Sum:${a+b}");
