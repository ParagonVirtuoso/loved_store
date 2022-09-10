import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loved_store/datas/product_data.dart';
import 'package:loved_store/tiles/products_tile.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;
  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            iconSize: 50.sp,
            padding: EdgeInsets.only(left: 40.w),
            icon: FaIcon(FontAwesomeIcons.caretLeft, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0.0,
          title: Text(snapshot.data()["title"]),
          centerTitle: true,
        ),
        body: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection("produtos")
                .doc(snapshot.id)
                .collection("items")
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else
                return GridView.builder(
                    padding: EdgeInsets.all(ScreenUtil().setSp(10.0)),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: ScreenUtil().setSp(10),
                      crossAxisSpacing: ScreenUtil().setSp(10),
                      childAspectRatio: 0.65,
                    ),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      ProductData data =
                          ProductData.fromDocument(snapshot.data.docs[index]);

                      data.category = this.snapshot.id;

                      return ProductTile(data);
                    });
            }));
  }
}
