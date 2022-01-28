import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class DrawerTile extends StatelessWidget {

  final IconData icon;
  final String text;
  final PageController controller;
  final int page;


  DrawerTile(this.icon,this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(750,1334));
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          Navigator.of(context).pop();
          controller.jumpToPage(page);
        },
        child: Container(
          height: ScreenUtil().setHeight(110),
          child: Row(
            children: [
              Icon(
                icon,
                size: ScreenUtil().setSp(65),
                color: controller.page.round() == page ?
                Theme.of(context).primaryColor : Colors.grey[700],
              ),
              SizedBox(
                width: ScreenUtil().setWidth(32),
              ),
              Text(text,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(33.0),
                color: controller.page.round() == page ?
              Theme.of(context).primaryColor : Colors.grey[700],
              ) ,)

            ],
          ),
        ),
      ),
    );
  }
}
