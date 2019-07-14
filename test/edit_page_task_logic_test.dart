import 'package:test/test.dart';

void main(){




  test("测试时间转换", (){
    String time = DateTime.now().toIso8601String();

    print("转换前:${time}");

    DateTime after = DateTime.parse(time);
    print("转换后:${after}");
  });
}