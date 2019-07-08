import 'package:flutter/material.dart';
import 'package:todo_list/config/task_icon_config.dart';

class EditTaskPage extends StatelessWidget {

  final TaskIcon taskIcon;

  EditTaskPage(this.taskIcon);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 100),
              child: ListView(
                children: List.generate(30, (index){
                  return Text("第${index}条",style: TextStyle(fontSize: 20),);
                }),
              ),
            ),
            Positioned(left: 0,bottom: 0 ,child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: "添加任务",
                        border: InputBorder.none,
                        prefixIcon: Icon(taskIcon.iconData, color: taskIcon.color,),
                        suffixIcon: Container(
                          width: 24,height: 24,
                          margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.withOpacity(0.8)
                          ),
                          child:  Icon(Icons.arrow_upward,color: Colors.white,),
                        )
                    ),
                  ),
                  Container(
                    height: 40,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[

                      ],
                    ),
                  )
                ],
              ),
            ),)
          ],
        ),
      ),
    );
  }
}
