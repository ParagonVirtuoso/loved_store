import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loved_store/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formkey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            height: 170.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.asset(
                                'recursos/lovedLogo.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 35.h, bottom: 10.h),
                              child: Text(
                                "Insira suas informações para o cadastro",
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 30.sp),
                              )),
                          Container(
                              margin: EdgeInsets.only(
                                  top: 35.h, right: 320.w, bottom: 10.h),
                              child: Text(
                                "Nome Completo",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                    fontSize: 32.sp),
                              )),
                          Container(
                              margin: EdgeInsets.only(bottom: 20.h),
                              width: 620.w,
                              height: ScreenUtil().setHeight(65),
                              child: TextFormField(
                                controller: _nameController,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 34.sp,
                                    color: Colors.grey[700]),
                                keyboardType: TextInputType.name,
                                validator: (text) {
                                  if (text!.isEmpty || !text.contains(" ")) {
                                    return null;
                                  } else
                                    return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Seu nome e sobrenome',
                                  contentPadding:
                                      EdgeInsets.fromLTRB(50.w, 1.h, 50.w, 1.h),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.sp)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
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
                              margin:
                                  EdgeInsets.only(right: 500.w, bottom: 10.h),
                              child: Text(
                                "CPF",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                    fontSize: 32.sp),
                              )),
                          Container(
                              margin: EdgeInsets.only(bottom: 20.h),
                              width: 620.w,
                              height: ScreenUtil().setHeight(65),
                              child: TextFormField(
                                controller: _cpfController,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 34.sp,
                                    color: Colors.grey[700]),
                                keyboardType: TextInputType.number,
                                validator: (text) {
                                  if (text!.isEmpty || text.length < 11) {
                                    return null;
                                  } else
                                    return null;
                                },
                                decoration: InputDecoration(
                                  hintText: '000.000.000-00',
                                  contentPadding:
                                      EdgeInsets.fromLTRB(50.w, 1.h, 50.w, 1.h),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.sp)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
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
                              margin:
                                  EdgeInsets.only(right: 430.w, bottom: 10.h),
                              child: Text(
                                "Endereço",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                    fontSize: 32.sp),
                              )),
                          Container(
                              margin: EdgeInsets.only(bottom: 20.h),
                              width: 620.w,
                              height: ScreenUtil().setHeight(65),
                              child: TextFormField(
                                controller: _enderecoController,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 34.sp,
                                    color: Colors.grey[700]),
                                keyboardType: TextInputType.streetAddress,
                                validator: (text) {
                                  if (text!.isEmpty) {
                                    return null;
                                  } else
                                    return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'seu endereço completo',
                                  contentPadding:
                                      EdgeInsets.fromLTRB(50.w, 1.h, 50.w, 1.h),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.sp)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
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
                              margin:
                                  EdgeInsets.only(right: 460.w, bottom: 10.h),
                              child: Text(
                                "E-mail",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                    fontSize: 32.sp),
                              )),
                          Container(
                              margin: EdgeInsets.only(bottom: 20.h),
                              width: 620.w,
                              height: ScreenUtil().setHeight(65),
                              child: TextFormField(
                                controller: _emailController,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 34.sp,
                                    color: Colors.grey[700]),
                                keyboardType: TextInputType.emailAddress,
                                validator: (text) {
                                  if (text!.isEmpty || !text.contains("@")) {
                                    return null;
                                  } else
                                    return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'seuemail@email.com',
                                  contentPadding:
                                      EdgeInsets.fromLTRB(50.w, 1.h, 50.w, 1.h),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.sp)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
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
                                    fontSize: 32.sp),
                              )),
                          Container(
                              margin: EdgeInsets.only(bottom: 50.h),
                              width: 620.w,
                              height: ScreenUtil().setHeight(65),
                              child: TextFormField(
                                controller: _senhaController,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.sp,
                                    color: Colors.grey[700]),
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: '*******',
                                  contentPadding:
                                      EdgeInsets.fromLTRB(50.w, 1.h, 50.w, 1.h),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(30.sp)),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
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
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formkey.currentState!.validate()) {
                                    Map<String, dynamic> userData = {
                                      "name": _nameController.text,
                                      "cpf": _cpfController.text,
                                      "endereco": _enderecoController.text,
                                      "email": _emailController.text,
                                    };

                                    model.signUp(
                                      userData: userData,
                                      pass: _senhaController.text,
                                      onSuccess: _onSuccess,
                                      onFail: _onFail,
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.sp),
                                  ),
                                ),
                                child: Text(
                                  'Criar Conta',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                        ]),
                  );
              })
            ],
          ),
        ],
      ),
    );
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Falha ao entrar!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }

  void _onSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Usuário criado com sucesso!"),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
    Future.delayed(Duration(seconds: 2)).then((_) {
      Navigator.of(context).pop();
    });
  }
}
