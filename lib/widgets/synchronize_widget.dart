import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:todo_list/i10n/localization_intl.dart';

class SynchronizeWidget extends StatefulWidget {
  @override
  _SynchronizeWidgetState createState() => _SynchronizeWidgetState();
}

class _SynchronizeWidgetState extends State< SynchronizeWidget> {

  SynFlag synFlag = SynFlag.notSynchronized;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Container(
        width: 60,
        height: 60,
        alignment: Alignment.center,
        child: getSynWidget(synFlag),
      ),
    );
  }


  Widget getSynWidget(SynFlag synFlag){
    switch(synFlag){
      case SynFlag.notSynchronized:
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  value: 1.0,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
              Text(DemoLocalizations.of(context).clickToSyn,style: TextStyle(color: Colors.white),)
            ],
          ),
        );
        break;
      case SynFlag.synchronizing:
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              ),
              Text(DemoLocalizations.of(context).synchronizing,style: TextStyle(color: Colors.white),)
            ],
          ),
        );
        break;
      case SynFlag.synced:
        return FlareActor('flrs/success.flr',animation: 'success',fit: BoxFit.contain,callback: (animName){
          if(animName == 'success'){

          }
        },);
        break;
      default:
    }
    return Container();
  }
}

enum SynFlag{
  notSynchronized,
  synchronizing,
  synced
}
