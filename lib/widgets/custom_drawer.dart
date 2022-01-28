import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:loved_store/models/user_model.dart';
import 'package:loved_store/screens/login_screen.dart';
import 'package:loved_store/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(750,1334));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Widget _buildDrawerBack() => Container(
          height: ScreenUtil().setHeight(1334),
          width: ScreenUtil().setWidth(750),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 246, 164, 175)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        );
    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(32.0),
                top: ScreenUtil().setHeight(16.0)),
            children: [
              Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(8.0)),
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(0.0),
                    ScreenUtil().setHeight(43.0),
                    ScreenUtil().setWidth(16.0),
                    ScreenUtil().setHeight(8.0)),
                height: ScreenUtil().setHeight(370.0),
                child: Stack(
                  children: [
                    Positioned(
                      top: ScreenUtil().setHeight(20.0),
                      left: ScreenUtil().setWidth(0.0),
                      child: Text(
                        "Loved \n     Store",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(55.0),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0.0,
                      bottom: ScreenUtil().setHeight(50.0),
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: ScreenUtil().setWidth(220),
                                child: Text("Bem Vindo,",style: TextStyle(
                                    fontSize: ScreenUtil().setSp(32.0),
                                    fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(520),
                                child: Text("${!model.isLoggedIn() ? "" : model.userData["name"]} ",style: TextStyle(
                                    fontSize: ScreenUtil().setSp(32.0),
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                              ),
                              GestureDetector(
                                child: Text(
                                  !model.isLoggedIn() ?
                                  "Cadastre-se ou faça login" : "Sair",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: ScreenUtil().setSp(32.0),
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                onTap: (){
                                  if(!model.isLoggedIn()){
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => LoginScreen()
                                  ));}
                                  else{
                                    model.signOut();

                                  }
                                },
                              )
                            ],
                          );
                        },
                      )
                    )
                  ],
                ),
              ),
              Divider(

              ),
              DrawerTile(Icons.home, "Inicio", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(Icons.check, "Meus Pedidos", pageController, 2),
              DrawerTile(Icons.location_on, "A Loja", pageController, 3),
            ],
          )
        ],
      ),
    );
  }
}
