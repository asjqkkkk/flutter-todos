import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo_list/config/api_service.dart';
import 'package:todo_list/i10n/localization_intl.dart';
import 'package:todo_list/json/upload_avatar_bean.dart';
import 'package:todo_list/model/avatar_page_model.dart';
import 'package:todo_list/model/main_page_model.dart';
import 'package:todo_list/utils/file_util.dart';
import 'package:todo_list/utils/shared_util.dart';
import 'package:todo_list/widgets/custom_animated_switcher.dart';
import 'package:todo_list/widgets/net_loading_widget.dart';

class AvatarHistoryPage extends StatefulWidget {
  final String currentAvatarUrl;
  final AvatarPageModel avatarPageModel;

  const AvatarHistoryPage(
      {Key key, @required this.currentAvatarUrl, this.avatarPageModel})
      : super(key: key);

  @override
  _AvatarHistoryPageState createState() => _AvatarHistoryPageState();
}

class _AvatarHistoryPageState extends State<AvatarHistoryPage> {
  List<String> avatarPaths = [];
  bool isDeleting = false;
  CancelToken cancelToken = CancelToken();

  @override
  void dispose() {
    cancelToken?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DemoLocalizations.of(context).avatarHistory),
        actions: <Widget>[
       avatarPaths.isNotEmpty ? CustomAnimatedSwitcher(
            firstChild: Icon(
              Icons.border_color,
              size: 20,
            ),
            secondChild: Icon(
              Icons.check,
              size: 20,
              color: Colors.greenAccent,
            ),
            hasChanged: isDeleting,
            onTap: () {
              isDeleting = !isDeleting;
              setState(() {});
            },
          ) : SizedBox(),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          padding: EdgeInsets.all(10),
          children: List.generate(avatarPaths.length, (index) {
            final path = avatarPaths[index];
            final name = path.split("/").last;

            return Stack(
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    final account =
                        await SharedUtil.instance.getString(Keys.account);
                    if (account == "default" || account == null) {
                      await onAvatarSelect(path, context);
                    } else {
                      final token =
                          await SharedUtil.instance.getString(Keys.token);
                      String fileName = path
                          .substring(path.lastIndexOf("/") + 1, path.length)
                          .replaceAll(" ", "");
                      String transFormName =
                          Uri.encodeFull(fileName).replaceAll("%", "");
                      uploadAvatar(
                          account, token, path, transFormName, context);
                    }
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Image.file(
                      File(avatarPaths[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                isDeleting
                    ? ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Container(
                          color: Colors.grey.withOpacity(0.5),
                        ))
                    : SizedBox(),
                isDeleting && name != "icon.png"
                    ? Container(
                        alignment: Alignment.center,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          iconSize: 80,
                          icon: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            File file = File(avatarPaths[index]);
                            file.delete().then((value) {
                              getAvatarFiles();
                            });
                          },
                        ),
                      )
                    : SizedBox(),
              ],
            );
          }),
        ),
      ),
    );
  }

  Future onAvatarSelect(String url, BuildContext context) async {
    final avatarPageModel = widget.avatarPageModel;
    final mainPageModel = avatarPageModel.mainPageModel;
    mainPageModel.currentAvatarUrl = url;
    mainPageModel.currentAvatarType = CurrentAvatarType.local;
    await SharedUtil.instance.saveString(Keys.localAvatarPath, url);
    await SharedUtil.instance
        .saveInt(Keys.currentAvatarType, CurrentAvatarType.local);
    mainPageModel.refresh();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void uploadAvatar(String account, String token, String filePath,
      String fileName, BuildContext context) async {
    _showLoadingDialog(context);
    ApiService.instance.uploadAvatar(
      params: FormData.from({
        "avatar": new UploadFileInfo(new File(filePath), fileName),
        "account": account,
        "token": token
      }),
      success: (UploadAvatarBean bean) {
        Navigator.pop(context);
        onAvatarSelect(filePath, context);
      },
      failed: (UploadAvatarBean bean) {
        Navigator.pop(context);
        _showTextDialog(bean.description, context);
      },
      error: (msg) {
        Navigator.pop(context);
        _showTextDialog(msg, context);
      },
      token: cancelToken,
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return NetLoadingWidget();
        });
  }

  void _showTextDialog(String text, BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Text(text),
          );
        });
  }

  void getAvatarFiles() async {
    final avatarPath = await FileUtil.getInstance().getSavePath('/avatar/');
    final children = await FileUtil.getInstance().getDirChildren(avatarPath);
    avatarPaths.clear();
    avatarPaths.addAll(children);
    avatarPaths.remove(widget.currentAvatarUrl);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    getAvatarFiles();
  }
}
