import 'package:flutter_test/flutter_test.dart';



class Walker{
  void todo(){
    print("\n我能走路\n");
  }
}

class Pilot{
  void todo(){
    print("\n我能飞\n");
  }
}

class Jumper{
  void todo(){
    print("\n我能跳\n");
  }
}

class PersonOne with Pilot, Jumper{
  PersonOne(){
    print("${this.runtimeType}");
  }
}

class PersonTwo with Walker, Jumper{
  PersonTwo(){
    print("${this.runtimeType}");
  }
}

class PersonThree with Walker, Pilot{
  PersonThree(){
    print("${this.runtimeType}");
  }
}

void main(){
  test(("测试mixin机制:\n"), (){

    print(DateTime.now().millisecondsSinceEpoch);

    // PersonOne personOne = PersonOne()..todo();
    // PersonTwo personTwo = PersonTwo()..todo();
    // PersonThree personThree = PersonThree()..todo();
  });

}