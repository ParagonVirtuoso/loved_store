import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loved_store/models/user_model.dart';
import 'package:loved_store/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          iconSize: 58.sp,
          padding: EdgeInsets.only(left: 40.w),
          icon: FaIcon(FontAwesomeIcons.caretLeft,
              color: Theme.of(context).primaryColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Flex(
            direction: Axis.vertical,
            children: <Widget>[
              ScopedModelDescendant<UserModel>(
                builder: (context, child, model) {
                  if (model.isLoading) {
                    return Center(
                      heightFactor: 30.w,
                      child: CircularProgressIndicator(),
                    );
                  } else
                    return Form(
                      key: _formkey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 230.h,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  'recursos/lovedLogo.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    top: 50.h,
                                    right: ScreenUtil().setWidth(460),
                                    bottom: 10.h),
                                child: Text(
                                  "E-mail",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                      fontSize: 35.sp),
                                )),
                            Container(
                                margin: EdgeInsets.only(bottom: 30.h),
                                width: 620.w,
                                height: ScreenUtil().setHeight(80),
                                child: TextFormField(
                                  controller: _emailController,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 37.sp,
                                      color: Colors.grey[700]),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (text) {
                                    if (text!.isEmpty || !text.contains("@")) {
                                      return null;
                                    } else
                                      return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Digite seu E-mail',
                                    contentPadding: EdgeInsets.fromLTRB(
                                        50.w, 1.h, 50.w, 1.h),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.sp)),
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.sp)),
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 244, 43, 75)),
                                    ),
                                  ),
                                )),
                            Container(
                                margin: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(460),
                                    bottom: 10.h),
                                child: Text(
                                  "Senha",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[700],
                                      fontSize: 35.sp),
                                )),
                            Container(
                                margin: EdgeInsets.only(bottom: 50.h),
                                width: 620.w,
                                height: ScreenUtil().setHeight(80),
                                child: TextFormField(
                                  controller: _senhaController,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 37.sp,
                                      color: Colors.grey[700]),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Digite sua senha',
                                    contentPadding: EdgeInsets.fromLTRB(
                                        50.w, 1.h, 50.w, 1.h),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.sp)),
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(30.sp)),
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 244, 43, 75)),
                                    ),
                                  ),
                                  obscureText: true,
                                  validator: (text) {
                                    if (text!.isEmpty || text.length < 6)
                                      return null;
                                    else
                                      return null;
                                  },
                                )),
                            Container(
                                width: 400.w,
                                height: 80.h,
                                child: RaisedButton(
                                  child: Text('ENTRAR',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255))),
                                  color: Theme.of(context).primaryColor,
                                  onPressed: () {
                                    if (_formkey.currentState!.validate()) {}
                                    model.signIn(
                                        email: _emailController.text,
                                        pass: _senhaController.text,
                                        onSuccess: _onSuccess,
                                        onFail: _onFail);
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.sp),
                                  ),
                                )),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(50),
                                      left: ScreenUtil().setWidth(40)),
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignUpScreen()));
                                    },
                                    child: Text(
                                      'Cadastrar-se',
                                      style: TextStyle(
                                          fontSize: 27.sp,
                                          color: Color.fromARGB(
                                              255, 150, 150, 150)),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(50),
                                      left: ScreenUtil().setWidth(230)),
                                  child: FlatButton(
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      if (_emailController.text.isEmpty) {
                                        _scaffoldKey.currentState!
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Insira o email para recuperação!"),
                                          backgroundColor: Colors.redAccent,
                                          duration: Duration(seconds: 2),
                                        ));
                                      } else {
                                        model
                                            .recoverPass(_emailController.text);
                                        _scaffoldKey.currentState!
                                            .showSnackBar(SnackBar(
                                          content: Text(
                                              "Recuperação enviada ao seu Email!"),
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          duration: Duration(seconds: 2),
                                        ));
                                      }
                                    },
                                    child: Text(
                                      'Esqueci a senha',
                                      style: TextStyle(
                                          fontSize: 27.sp,
                                          color: Color.fromARGB(
                                              255, 150, 150, 150)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(50),
                                      left: ScreenUtil().setWidth(30)),
                                  width: ScreenUtil().setWidth(210),
                                  height: ScreenUtil().setHeight(3),
                                  color: Color.fromARGB(255, 244, 43, 75),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(50)),
                                    child: Text('Entrar com',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 170, 170, 170)))),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setHeight(50),
                                      right: ScreenUtil().setWidth(30)),
                                  width: ScreenUtil().setWidth(210),
                                  height: ScreenUtil().setHeight(3),
                                  color: Color.fromARGB(255, 244, 43, 75),
                                ),
                              ],
                            ),
                            Container(
                              height: 40.h,
                            ),
                            Column(
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(40)),
                                          width: ScreenUtil().setWidth(250),
                                          height: ScreenUtil().setHeight(55),
                                          child: RaisedButton(
                                            padding: EdgeInsets.fromLTRB(
                                                20.0, 2.5, 2.5, 5.0),
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  child: Image.asset(
                                                    "recursos/logoGoogle.png",
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: ScreenUtil()
                                                          .setWidth(40)),
                                                  child: Text('Google',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              104,
                                                              104,
                                                              104))),
                                                )
                                              ],
                                            ),
                                            onPressed: () {},
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        18.0),
                                                side: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 104, 104, 104))),
                                          )),
                                      Container(),
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: ScreenUtil().setHeight(40)),
                                          width: ScreenUtil().setWidth(250),
                                          height: ScreenUtil().setHeight(55),
                                          child: RaisedButton(
                                            padding: EdgeInsets.fromLTRB(
                                                20.0, 2.5, 2.5, 5.0),
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  child: Image.asset(
                                                    "recursos/logoFacebook.png",
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      right: ScreenUtil()
                                                          .setWidth(25)),
                                                  child: Text('Facebook',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color.fromARGB(
                                                              255,
                                                              104,
                                                              104,
                                                              104))),
                                                )
                                              ],
                                            ),
                                            onPressed: () {},
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        18.0),
                                                side: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 104, 104, 104))),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ]),
                    );
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  void _onFail() {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text("Falha ao entrar, verifique o email ou senha!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }

  void _onSuccess() {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text("Login realizado com sucesso!"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 1)).then((_) {
      Navigator.of(context).pop();
    });
  }
}
