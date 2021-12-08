import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/utils/my_encrypt_util.dart';



void main(){


  test("加密测试", (){

    String text = 'Flutter真好用！';
    String encrypt = EncryptUtil.instance.encrypt(text);
    print("加密后 :$encrypt");
    String decrypt = EncryptUtil.instance.decrypt(encrypt);
    print("解密后 :$decrypt");

  });
}