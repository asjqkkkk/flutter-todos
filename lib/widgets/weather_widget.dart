import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/json/weather_bean.dart';
import 'package:todo_list/model/global_model.dart';
import 'package:todo_list/utils/shared_util.dart';

import 'loading_widget.dart';


class WeatherWidget extends StatefulWidget {

  final GlobalModel globalModel;

  const WeatherWidget({Key key, this.globalModel}) : super(key: key);

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {

  LoadingFlag loadingFlag = LoadingFlag.error;
  WeatherBean weatherBean;
  CancelToken cancelToken;

  @override
  void initState() {
    cancelToken = CancelToken();
    getWeatherNow(widget.globalModel.currentPosition,
        widget.globalModel.currentLocale.languageCode);
    super.initState();
  }

  @override
  void dispose() {
    cancelToken?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final globalModel = widget.globalModel;
    final color = globalModel.logic.isDarkNow() ? Colors.white : Colors.grey;
    if (weatherBean == null) {
      return Padding(
        padding: EdgeInsets.all(10),
        child: LoadingWidget(
          size: 80,
          flag: loadingFlag,
          errorCallBack: (){
            setState(() {
              loadingFlag = LoadingFlag.loading;
            });
            getWeatherNow(globalModel.currentPosition ?? "",
                globalModel.currentLocale.languageCode);
          },
        ),
      );
    }
    final BasicBean basicBean =
        weatherBean.HeWeather6[weatherBean.HeWeather6.length - 1].basic;
    final NowBean nowBean =
        weatherBean.HeWeather6[weatherBean.HeWeather6.length - 1].now;
    return Container(
      margin: EdgeInsets.only(left: 5, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Image.asset(
              "images/weather/${nowBean.cond_code}.png",
              color: color,
              width: 60,
              height: 60,
            ),
          ),
          Container(
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    "${basicBean.location}",
                    style: TextStyle(
                      fontSize: 16,
                      color: color,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Text(
                  "${nowBean.tmp} ℃   ${nowBean.cond_txt}",
                  style: TextStyle(
                    fontSize: 16,
                    color: color,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


  void getWeatherNow(String position, String languageCode) {
    ApiService.instance.getWeatherNow((WeatherBean weatherBean) {
      this.weatherBean = weatherBean;
      SharedUtil.instance.saveString(Keys.currentPosition, position);
      SharedUtil.instance.saveBoolean(Keys.enableWeatherShow, true);
      setState(() {
        loadingFlag = LoadingFlag.success;
      });
    }, (WeatherBean weatherBean) {
      setState(() {
        loadingFlag = LoadingFlag.error;
      });
    }, (error) {
      setState(() {
        loadingFlag = LoadingFlag.error;
      });
    }, {
      "key": "d381a4276ed349daa3bf63646f12d8ae",
      "location": position,
      "lang": languageCode
    }, CancelToken());
  }
}
