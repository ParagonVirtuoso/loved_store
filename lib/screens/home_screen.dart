import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loved_store/tabs/home_tab.dart';
import 'package:loved_store/tabs/orders_tab.dart';
import 'package:loved_store/tabs/places_tab.dart';
import 'package:loved_store/tabs/tab_produtos.dart';
import 'package:loved_store/widgets/cart_button.dart';
import 'package:loved_store/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(750, 1334));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
            body: HomeTab(_pageController),
            floatingActionButton: CartButton(),
            drawer: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(ScreenUtil().setSp(35)),
                  bottomRight: Radius.circular(ScreenUtil().setSp(35))),
              child: CustomDrawer(_pageController),
            )),
        Scaffold(
            appBar: AppBar(
              title: Text("Produtos"),
              centerTitle: true,
            ),
            floatingActionButton: CartButton(),
            drawer: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(ScreenUtil().setSp(35)),
                  bottomRight: Radius.circular(ScreenUtil().setSp(35))),
              child: CustomDrawer(_pageController),
            ),
            body: TabProdutos()),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Loja"),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(_pageController),
        ),
      ],
    );
  }
}
