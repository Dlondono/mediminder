import 'package:flutter/material.dart';
import 'package:mediminder/screens/authenticate/register.dart';
import 'package:mediminder/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  //funcion para cambiar vistas
  void toggleView(){
    setState(()=>showSignIn=!showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView:toggleView);
    } else {
      return Register(toggleView:toggleView);
    }
  }
}