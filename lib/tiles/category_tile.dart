import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loved_store/screens/category_screen.dart';

class CategoryTile extends StatelessWidget {
  final DocumentSnapshot? snapshot;

  CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(15.0),
          ScreenUtil().setHeight(15.0),
          ScreenUtil().setWidth(20.0),
          ScreenUtil().setHeight(15.0)),
      child: ListTile(
        leading: CircleAvatar(
          radius: ScreenUtil().setSp(50),
          backgroundColor: Colors.transparent,
          child: Container(
            child: Image.network(
              snapshot!['icon'],
              color: Theme.of(context).primaryColor,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ),
        title: Text(
          snapshot!["title"],
          style: TextStyle(fontSize: ScreenUtil().setSp(40)),
        ),
        trailing: FaIcon(FontAwesomeIcons.angleRight),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CategoryScreen(snapshot!)));
        },
      ),
    );
  }
}
