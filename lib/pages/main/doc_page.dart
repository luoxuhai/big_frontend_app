import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluro/fluro.dart';
import 'package:big_frontend/routes.dart';
import 'package:big_frontend/api/api.dart';

class DocPage extends StatefulWidget {
  @override
  _DocPageState createState() => _DocPageState();
}

class _DocPageState extends State<DocPage> {
  List docs = [];

  @override
  void initState() {
    super.initState();
    Api.getDocs({'page': 1, 'per_page': 5}).then((res) {
      setState(() {
        docs = res['docs'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: GridView.builder(
            itemCount: docs.length,
            padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                mainAxisSpacing: 20.0,
                crossAxisSpacing: 10.0),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  var bytes = utf8.encode(docs[index]['url']);
                  var url = base64Encode(bytes);
                  Routes.router.navigateTo(
                      context, "${Routes.docDetilPage}?url=$url", //跳转路径
                      transition: TransitionType.native //过场效果
                      );
                },
                child: Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFFF0000), width: 0.5)),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: ExtendedImage.network(
                          docs[index]['logo'],
                          cache: true,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: ScreenUtil().setWidth(30)),
                        child: Text(
                          docs[index]['title'],
                          style: TextStyle(fontSize: ScreenUtil().setSp(40)),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: ScreenUtil().setWidth(15)),
                        child: Text(
                          docs[index]['describe'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        child: Text(
                          docs[index]['intro'],
                          maxLines: 3,
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
