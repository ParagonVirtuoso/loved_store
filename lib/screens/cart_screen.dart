import 'package:flutter/material.dart';
import 'package:loved_store/models/cart_model.dart';
import 'package:loved_store/models/user_model.dart';
import 'package:loved_store/screens/login_screen.dart';
import 'package:loved_store/screens/order_screen.dart';
import 'package:loved_store/tiles/cart_tile.dart';
import 'package:loved_store/widgets/cart_price.dart';
import 'package:loved_store/widgets/discount_card.dart';
import 'package:loved_store/widgets/ship_card.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 20.w),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int p = model.products.length;
                return Text(
                  "$p ${p == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(fontSize: 31.sp),
                );
              },
            ),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(builder: (context, child, model) {
        if (model.isLoading && UserModel.of(context).isLoggedIn()) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!UserModel.of(context).isLoggedIn()) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.remove_shopping_cart,
                  size: 80.0,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Faça o login para adicionar produtos!",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: Text(
                    "Entrar",
                    style: TextStyle(fontSize: 18.0),
                  ),
                )
              ],
            ),
          );
        } else if (model.products.length == 0) {
          return Center(
            child: Text(
              "Nenhum produto no carrinho!",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return ListView(
            children: <Widget>[
              Column(
                children: model.products.map((product) {
                  return CartTile(product);
                }).toList(),
              ),
              DiscountCard(),
              ShipCard(),
              CartPrice(() async {
                String orderId = await model.finishOrder();
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => OrderScreen(orderId)));
              }),
            ],
          );
        }
      }),
    );
  }
}
