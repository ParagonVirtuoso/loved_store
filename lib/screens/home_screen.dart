import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:loved_store/tabs/home_tab.dart';
import 'package:loved_store/tabs/tab_produtos.dart';
import 'package:loved_store/widgets/cart_button.dart';
import 'package:loved_store/widgets/custom_drawer.dart';
import 'package:web_scraper/web_scraper.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();
  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(context,designSize: Size(750,1334));
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
                bottomRight: Radius.circular(ScreenUtil().setSp(35))
            ),
            child: CustomDrawer(
                _pageController
            ),
          )
        ),
        Scaffold(
          appBar: AppBar(
            title: Text(
              "Produtos"
            ),
            centerTitle: true,
          ),
            floatingActionButton: CartButton(),
          drawer: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(ScreenUtil().setSp(35)),
                bottomRight: Radius.circular(ScreenUtil().setSp(35))
            ),
            child: CustomDrawer(
                _pageController
            ),
          ),
          body: TabProdutos(

          )
        ),
        Container(color: Colors.pink),
        Container(color: Colors.deepOrange),
        Container(color: Colors.blue)
      ],
    );
  }

}
