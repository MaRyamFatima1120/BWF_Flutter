///// Write a function calculateAverage that takes in a list of numbers as a parameter and returns the average of those numbers.
///
void calculateAverage(List<dynamic> numbers){
  
  double sum=0.0;
  for (int number in numbers){
    sum +=number;
  }
  double average = sum/numbers.length;
  print(average);
}
void main(){
  calculateAverage([10,20,30,40,50]);
}