import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:transparent_image/transparent_image.dart';

class HomeTab extends StatelessWidget {
  final PageController pageController;

  HomeTab(this.pageController);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    Widget _buildBodyBack() => Container(
          height: ScreenUtil().setHeight(1334),
          width: ScreenUtil().setWidth(750),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 211, 118, 130),
            Color.fromARGB(255, 253, 181, 168)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        );

    return Stack(
      children: [
        _buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              snap: true,
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding:
                    EdgeInsets.only(bottom: ScreenUtil().setHeight(15.0)),
                title: Text(
                  "Novidades",
                  style: TextStyle(fontSize: ScreenUtil().setSp(50)),
                ),
                centerTitle: true,
              ),
            ),
            FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection("home")
                  .orderBy("pos")
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SliverToBoxAdapter(
                    child: Container(
                      height: ScreenUtil().setHeight(1000),
                      width: ScreenUtil().setWidth(750),
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: StaggeredGrid.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 1.0,
                      crossAxisSpacing: 1.0,
                      children: snapshot.data!.docs.map((doc) {
                        return StaggeredGridTile.count(
                          crossAxisCellCount: doc["x"],
                          mainAxisCellCount: doc["y"],
                          child: Container(
                            padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(22.0),
                                right: ScreenUtil().setWidth(22.0),
                                top: ScreenUtil().setHeight(15.0),
                                bottom: ScreenUtil().setHeight(15.0)),
                            child: InkWell(
                              onTap: () {
                                pageController.animateToPage(1,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease);
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenUtil().setSp(20))),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        image: doc["image"],
                                        width: double.infinity,
                                        height: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      Container(
                                        alignment: Alignment.bottomCenter,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenUtil().setSp(20))),
                                          child: Container(
                                            alignment: Alignment.center,
                                            color: Color.fromARGB(
                                                150, 231, 140, 160),
                                            height: ScreenUtil().setHeight(70),
                                            width: ScreenUtil().setWidth(230),
                                            child: Text(
                                              "R\$" + doc["valor"].toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      ScreenUtil().setSp(40)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }
              },
            )
          ],
        )
      ],
    );
  }
}
