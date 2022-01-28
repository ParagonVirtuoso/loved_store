import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loved_store/datas/cart_product.dart';
import 'package:loved_store/datas/product_data.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:loved_store/models/cart_model.dart';
import 'package:loved_store/models/user_model.dart';
import 'package:loved_store/screens/login_screen.dart';

import 'cart_screen.dart';

class ProductScreen extends StatefulWidget {

  final ProductData product;
  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {

  final ProductData product;
  String size;
  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
        leading: IconButton(
          iconSize: 50.sp,
          padding: EdgeInsets.only(left: 40.w),
          icon: FaIcon(FontAwesomeIcons.caretLeft,color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url){
                return Image.network(url,fit: BoxFit.cover,
                  loadingBuilder:(BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              }).toList(),
              dotSize: ScreenUtil().setSp(8),
              dotBgColor: Colors.transparent,
              dotSpacing: ScreenUtil().setWidth(30),
              autoplay: false,
              dotColor: Theme.of(context).primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ScreenUtil().setSp(25.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.title,
                  style: TextStyle(fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${ product.preco.toStringAsFixed(2) }",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(44),
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(18),
                ),
                Text(
                  "Tamanho",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(35),
                    fontWeight: FontWeight.w500
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(70),
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(8)),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: ScreenUtil().setWidth(20),
                      childAspectRatio: 0.5
                    ),
                    children: product.sizes.map((s)
                    {
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            size = s;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setSp(10))),
                            border: Border.all(
                              color: s == size ? Theme.of(context).primaryColor : Colors.grey[500],
                              width: ScreenUtil().setSp(4)
                            )
                          ),
                          width: ScreenUtil().setWidth(80),
                          alignment: Alignment.center,
                          child: Text(s),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(
                  height: 20.h
                ),
                Text(
                  "Descrição",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(35),
                      fontWeight: FontWeight.w500
                  ),
                ),
                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 33.sp
                  ),
                ),
                SizedBox(
                  height: 26.h,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(80),
                  child: RaisedButton(
                    onPressed: (){
                      if(UserModel.of(context).isLoggedIn()){
                        if(size != null){
                          CartProduct cartProduct = CartProduct();
                          cartProduct.size = size;
                          cartProduct.quantity = 1;
                          cartProduct.pid = product.id;
                          cartProduct.category = product.category;

                          CartModel.of(context).addCartItem(cartProduct);
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => CartScreen())
                          );
                        }
                      }else{
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginScreen())
                        );
                      }
                    },
                    child: Text(UserModel.of(context).isLoggedIn() ?
                      "Adcionar ao carrinho" : "Entre para comprar",style: TextStyle(
                      fontSize: 33.sp,
                    ),
                    ),
                    textColor: Colors.white,
                    color: size !=null && UserModel.of(context).isLoggedIn() ? Theme.of(context).primaryColor : Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35.sp)
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
