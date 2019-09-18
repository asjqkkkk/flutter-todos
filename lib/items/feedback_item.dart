import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_list/pages/main/background/image_page.dart';

class FeedbackItem extends StatelessWidget {
  final String userName;
  final String avatarUrl;
  final String submitTime;
  final String suggestion;
  final String emoji;
  final int index;

  const FeedbackItem({
    Key key,
    this.userName,
    this.avatarUrl,
    this.submitTime,
    this.suggestion, this.emoji, this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 12),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(new MaterialPageRoute(builder: (ctx){
                        return ImagePage(
                          imageUrls: [avatarUrl],
                          heroTag: "avatar_$index",
                        );
                      }));
                    },
                    child: Hero(
                      tag: "avatar_$index",
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.only(left: 12),
                        child: ClipRRect(
                          child: avatarUrl == null ? Image.asset(
                            "images/icon.png",
                          ) : CachedNetworkImage(
                            imageUrl: avatarUrl,
                            errorWidget:  (context, url, error) => Icon(Icons.error, color: Colors.redAccent,),

                          ),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          userName ?? "default",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Text(
                          submitTime ?? "unkown time",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(216, 216, 216, 1.0),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          suggestion ?? "nothing",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: SvgPicture.asset(
                      "svgs/mood_$emoji.svg",
                      width: 25,
                      height: 25,
                    )
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
