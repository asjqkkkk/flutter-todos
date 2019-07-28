import 'package:test/test.dart';

//升级测试
void main(){



  bool needUpdate(String oldVersion, String newVersion){
    final oldList = oldVersion.split(".");
    final newList = newVersion.split(".");

    bool needUpdate = false;

    for (var i = 0; i < oldList.length; i++) {
      String oldNumString = oldList[i];
      String newNumString = newList[i];
      int oldNum = int.parse(oldNumString);
      int newNum = int.parse(newNumString);
      if(newNum > oldNum){
        needUpdate = true;
        return needUpdate;
      }
    }
    return needUpdate;

  }

  test("测试版本号对比", (){

    bool update1 = needUpdate("1.0.0", "1.0.0");
    bool update2 = needUpdate("1.0.0", "1.0.1");
    bool update3 = needUpdate("1.0.2", "1.0.1");
    bool update4 = needUpdate("1.0.0", "1.1.0");
    bool update5 = needUpdate("1.0.0", "2.0.0");
    bool update6 = needUpdate("1.0.0", "1.0.11");
    bool update7 = needUpdate("1.0.0", "1.11.0");


    expect(update1, false);
    expect(update2, true);
    expect(update3, false);
    expect(update4, true);
    expect(update5, true);
    expect(update6, true);
    expect(update7, true);



  });
}