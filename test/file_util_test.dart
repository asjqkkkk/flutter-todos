import 'package:test/test.dart';
import 'dart:io';



void main(){




  test("测试文件copy", (){
    File file = new File("/Users/lichen/Downloads/images.jpeg");
    expect(file.existsSync(), true);


    File copyFile =  file.copySync("/Users/lichen/Downloads/copy.jpeg");
    print("copy:${copyFile.path}");

  });
}