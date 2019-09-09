import 'package:flutter/material.dart';
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

  LoadingFlag loadingFlag = LoadingFlag.loading;
  CancelToken cancelToken;

  @override
  void initState() {
    cancelToken = CancelToken();
    if(widget.globalModel.weatherBean == null){
      getWeatherNow(widget.globalModel);
    }
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
    final WeatherBean weatherBean = globalModel.weatherBean;
    if (globalModel.weatherBean == null) {
      return Padding(
        padding: EdgeInsets.all(10),
        child: LoadingWidget(
          size: 80,
          flag: loadingFlag,
          errorCallBack: (){
            setState(() {
              loadingFlag = LoadingFlag.loading;
            });
            getWeatherNow(globalModel);
          },
        ),
      );
    }
    final BasicBean basicBean =
        weatherBean.heWeather6[weatherBean.heWeather6.length - 1].basic;
    final NowBean nowBean =
        weatherBean.heWeather6[weatherBean.heWeather6.length - 1].now;
    return Container(
      margin: EdgeInsets.only(left: 5, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Image.asset(
              "images/weather/${nowBean.condCode}.png",
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
                  "${nowBean.tmp} ℃   ${nowBean.condTxt}",
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


  void getWeatherNow(GlobalModel globalModel) {
    final position = globalModel.currentPosition;
    final languageCode = globalModel.currentLocale.languageCode;
    ApiService.instance.getWeatherNow( success : (WeatherBean weatherBean) {
      globalModel.weatherBean = weatherBean;
      SharedUtil.instance.saveString(Keys.currentPosition, position);
      SharedUtil.instance.saveBoolean(Keys.enableWeatherShow, true);
      setState(() {
        loadingFlag = LoadingFlag.success;
      });
    },failed: (WeatherBean weatherBean) {
      setState(() {
        loadingFlag = LoadingFlag.error;
      });
    },error: (error) {
      setState(() {
        loadingFlag = LoadingFlag.error;
      });
    },params: {
      "key": "d381a4276ed349daa3bf63646f12d8ae",
      "location": position,
      "lang": languageCode
    },token: CancelToken());
  }
}
