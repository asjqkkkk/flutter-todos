

import 'package:flutter_test/flutter_test.dart';

void main(){


  test("测试文件名字截取", (){

    String url = "https://p0.ssl.qhimgs1.com/sdr/400__/t0161a1cd87506776d4.jpg";

    var filename = url.split("/").last;

    print("名字:$filename");
  });

}