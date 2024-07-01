//An enum is a special type that represents a fixed number of constant values.



///Example 1: Enum In Dart
///In this example below, there is enum type named days. It contains seven constants days. The days enum type is used in the main() function.
enum days{
  Saturday,Sunday,Monday,Tuesday,Wednesday,Thursday,Friday
}

void main(){
  var today = days.Saturday;
  switch(today){

    case days.Saturday:
    print("Today is Sartuday.");
    break;
    case days.Sunday:
    print("Today is Sunday.");
    break;
    case days.Monday:
    print("Today is Monday.");
    break;
    case days.Tuesday:
    print("Today is Tuesday.");
    break;
    case days.Wednesday:
    print("Today is Wednesday.");
    break;
    case days.Thursday:
    print("Today is Thursday.");
    break;
    case days.Friday:
    print("Today is Friday");
    break;
  }
}