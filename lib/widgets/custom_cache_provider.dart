import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';
import 'dart:io';
ImageProvider getProvider(String url){
  if(!url.startsWith('http')){
    final file = File(url);
    if(file.existsSync()){
      return FileImage(file);
    } else return AssetImage('imags/icon_2.png');
  }

  return NetworkImage(url);
}