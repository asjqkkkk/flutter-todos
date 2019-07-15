import 'package:test/test.dart';

void main(){


  //将当前item置于顶层
  void moveToTop(int index, List list){
    final item = list[index];
    list.removeAt(index);
    list.insert(0, item);
  }


  test("测试时间转换", (){
    String time = DateTime.now().toIso8601String();

    print("转换前:${time}");

    DateTime after = DateTime.parse(time);
    print("转换后:${after}");
  });

  test("置于顶层", (){
    moveToTop(3, [1,2,3,4,5,6]);
  });
}