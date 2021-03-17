import 'package:flutter/material.dart';
import 'package:mediminder/services/auth.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.red[200],
        elevation: 0.0,
        title: Text('Inicia sesión en nuestra App'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: ElevatedButton(
          child: Text('Sign in anonymous'),
          onPressed: () async{
            dynamic result = await _auth.signInAnon();
            if (result == null){
              print('error sign in');
            }else {
              print('singed in');
              print(result);
            }
          },
        ),
      ),
    );
  }
}
