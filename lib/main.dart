import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loved_store/models/user_model.dart';
import 'package:loved_store/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:loved_store/models/cart_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ScopedModel<UserModel>(
        model: UserModel(),
        child:
            ScopedModelDescendant<UserModel>(builder: (context, child, model) {
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              title: 'Loved Store',
              theme: ThemeData(
                primarySwatch: Colors.pink,
                primaryColor: Color.fromARGB(255, 191, 90, 110),
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              debugShowCheckedModeBanner: false,
              home: HomeScreen(),
            ),
          );
        }));
  }
}
