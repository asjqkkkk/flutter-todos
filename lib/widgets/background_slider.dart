import 'package:flutter/material.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/model/all_model.dart';
import 'package:todo_list/utils/shared_util.dart';

class BackgroundSlider extends StatefulWidget {

  final MainPageModel mainPageModel;


  BackgroundSlider(this.mainPageModel);

  @override
  _BackgroundSliderState createState() => _BackgroundSliderState();
}

class _BackgroundSliderState extends State<BackgroundSlider> {

  double transparency;
  bool enableTaskDetailOpacity;

  @override
  void initState() {
    transparency = widget.mainPageModel.currentTransparency;
    enableTaskDetailOpacity = widget.mainPageModel.enableTaskPageOpacity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(IntlLocalizations.of(context).cartOpacity),
      leading: Icon(Icons.opacity),
      children: <Widget>[
        ListTile(
          title: Slider(
            activeColor: Theme.of(context).primaryColor,
            value: transparency,
            onChanged: (value) {
              widget.mainPageModel.currentTransparency = value;
              widget.mainPageModel.refresh();
              transparency = value;
              setState(() {

              });
            },),
        ),
        SwitchListTile(
          title: Text(IntlLocalizations.of(context).enableTaskDetailOpacity),
          value: enableTaskDetailOpacity,
          activeColor: Theme.of(context).primaryColor,
          onChanged: (value) {
            widget.mainPageModel.enableTaskPageOpacity = value;
            widget.mainPageModel.refresh();
            enableTaskDetailOpacity = value;
            SharedUtil.instance.saveBoolean(Keys.enableCardPageOpacity, value);
            setState(() {

            });
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    SharedUtil.instance.saveDouble(Keys.currentTransparency, transparency);
    super.dispose();
  }
}
