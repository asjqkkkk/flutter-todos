import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';

class EditDialog extends StatelessWidget {
  final VoidCallback onPositive;
  final bool positiveWithPop;
  final String title;
  final String hintText;
  final String initialValue;
  final ValueChanged<String> onValueChanged;
  final TextStyle cancelTextStyle;
  final TextStyle sureTextStyle;

  const EditDialog({
    Key key,
    this.onPositive,
    this.title,
    this.hintText,
    this.initialValue,
    this.onValueChanged,
    this.cancelTextStyle,
    this.sureTextStyle,
    this.positiveWithPop = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: Text(title ?? ""),
      content: Form(
        autovalidateMode: AutovalidateMode.always,
        child: TextFormField(
          style: TextStyle(textBaseline: TextBaseline.alphabetic),
          initialValue: initialValue ?? "",
          validator: (text) {
            if (onValueChanged != null) onValueChanged(text);
            return null;
          },
          decoration: InputDecoration(
            hintText: hintText ?? "",
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            IntlLocalizations.of(context).cancel,
            style: cancelTextStyle ?? TextStyle(color: Colors.redAccent),
          ),
        ),
        FlatButton(
          onPressed: () {
            onPositive?.call();
            if(positiveWithPop) Navigator.of(context).pop();
          },
          child: Text(IntlLocalizations.of(context).ok,
              style: sureTextStyle ?? TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
