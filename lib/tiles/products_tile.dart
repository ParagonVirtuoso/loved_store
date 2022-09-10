import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:loved_store/datas/product_data.dart';
import 'package:loved_store/screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  final ProductData product;
  ProductTile(this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductScreen(product)));
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 0.8,
              child: Image.network(
                product.images[0],
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(15.0),
                    ScreenUtil().setHeight(15.0),
                    ScreenUtil().setWidth(15.0),
                    ScreenUtil().setHeight(15.0)),
                child: Column(
                  children: [
                    Text(
                      product.title,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil().setSp(22)),
                    ),
                    Text(
                      "R\$ ${product.preco.toStringAsFixed(2)}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: ScreenUtil().setSp(38),
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
