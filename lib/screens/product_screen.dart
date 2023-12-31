import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loved_store/datas/cart_product.dart';
import 'package:loved_store/datas/product_data.dart';
import 'package:loved_store/models/cart_model.dart';
import 'package:loved_store/models/user_model.dart';
import 'package:loved_store/screens/login_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'cart_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;
  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;
  String? size;
  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title!),
        centerTitle: true,
        leading: IconButton(
          iconSize: 50.sp,
          padding: EdgeInsets.only(left: 40.w),
          icon: FaIcon(FontAwesomeIcons.caretLeft, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: [
          AspectRatio(
              aspectRatio: 0.9,
              child: CarouselSlider.builder(
                itemCount: product.images!.length,
                itemBuilder:
                    (BuildContext context, int index, int pageViewIndex) {
                  final url = product.images![index];
                  return Image.network(
                    url,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                },
                options: CarouselOptions(
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  autoPlay: false,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                ),
              )),
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setSp(25.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.title!,
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(40),
                      fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${product.preco!.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(44),
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(18),
                ),
                Text(
                  "Tamanho",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(35),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(70),
                  child: GridView(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setWidth(8)),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: ScreenUtil().setWidth(20),
                        childAspectRatio: 0.5),
                    children: product.sizes!.map((s) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            size = s;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setSp(10))),
                              border: Border.all(
                                  color: s == size
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey[500]!,
                                  width: ScreenUtil().setSp(4))),
                          width: ScreenUtil().setWidth(80),
                          alignment: Alignment.center,
                          child: Text(s),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Descrição",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(35),
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  product.description!,
                  style: TextStyle(fontSize: 33.sp),
                ),
                SizedBox(
                  height: 26.h,
                ),
                SizedBox(
                    height: ScreenUtil().setHeight(80),
                    child: ElevatedButton(
                      onPressed: () {
                        if (UserModel.of(context).isLoggedIn()) {
                          if (size != null) {
                            CartProduct cartProduct = CartProduct();
                            cartProduct.size = size!;
                            cartProduct.quantity = 1;
                            cartProduct.pid = product.id!;
                            cartProduct.category = product.category!;
                            cartProduct.productData = product;

                            CartModel.of(context).addCartItem(cartProduct);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CartScreen(),
                            ));
                          }
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            size != null && UserModel.of(context).isLoggedIn()
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35.sp),
                        ),
                      ),
                      child: Text(
                        UserModel.of(context).isLoggedIn()
                            ? "Adicionar ao carrinho"
                            : "Entre para comprar",
                        style: TextStyle(
                          fontSize: 33.sp,
                        ),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
