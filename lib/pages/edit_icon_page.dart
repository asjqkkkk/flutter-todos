import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_colorpicker/material_picker.dart';

class EditIconPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("自定义图标"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FlatButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx){
                  return AlertDialog(
                    elevation: 0.0,
                    title: const Text('Pick a color!'),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: Theme.of(context).primaryColor,
                        onColorChanged: (color){

                        },
                        enableLabel: true,
                        pickerAreaHeightPercent: 0.8,
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: const Text('Got it'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }
              );
            },
            child: Text("选取颜色")),
      ),
    );
  }
}
