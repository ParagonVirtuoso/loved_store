import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel extends Model{

  FirebaseAuth _auth = FirebaseAuth.instance;


  Map<String, dynamic> userData = Map();

  bool isLoading = false;

  User firebaseUser;

  static UserModel of(BuildContext context) => 
      ScopedModel.of<UserModel>(context);

  @override
  void addListener(VoidCallback listener){
    super.addListener(listener);

    _loadCurrentUser();
  }

  Future<void> signUp({ @required Map<String, dynamic> userData, @required String pass, @required VoidCallback onSuccess,  @required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    firebaseUser = (await _auth.createUserWithEmailAndPassword(
    email: userData["email"],
    password: pass,
    )).user;

    await _saveUserData(userData);

    if (firebaseUser != null) {
      onSuccess();
      isLoading = false;
      notifyListeners();
    } else {
      onFail();
      isLoading = false;
      notifyListeners();
    }

    /*

    _auth.createUserWithEmailAndPassword(email: userData["email"] , password: pass).then((user) async {
      firebaseUser = user;

      await _saveUserData(userData);

      onSuccess();
      isLoading = false;
      notifyListeners();
    }).catchError((e){
      onFail();
      isLoading = false;
      notifyListeners();

    });
    */

}

  Future<void> signIn({@required String email,@required String pass,@required VoidCallback onSuccess,@required VoidCallback onFail}) async {
    isLoading = true;
    notifyListeners();

    try{
      firebaseUser = (await FirebaseAuth.instance.
      signInWithEmailAndPassword(email: email, password: pass))
          .user;
      await _loadCurrentUser();
      onSuccess();
      isLoading = false;
      notifyListeners();


    }catch (e){
      onFail();
      print(e.toString());
      isLoading = false;
      notifyListeners();
    }

  }

  void recoverPass(String email){

    _auth.sendPasswordResetEmail(email: email);

  }

  bool isLoggedIn(){

    return firebaseUser != null;

  }

  Future<Null> _saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await FirebaseFirestore.instance.collection("usuarios").doc(firebaseUser.uid).set(userData);
  }

  void signOut() async {
    await _auth.signOut();

    userData = Map();
    firebaseUser = null;
    notifyListeners();

  }

  Future<Null> _loadCurrentUser() async{
    if(firebaseUser == null){
      firebaseUser = _auth.currentUser;
    }
    if(firebaseUser != null){
      if(userData["name"] == null){
        DocumentSnapshot docUser = await FirebaseFirestore.instance.collection("usuarios").doc(firebaseUser.uid).get();
        userData = docUser.data();
      }
    }
    notifyListeners();

  }

}