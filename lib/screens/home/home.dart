import 'package:flutter/material.dart';
import 'package:mediminder/services/auth.dart';
class Home extends StatelessWidget {
  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: ,
      appBar: AppBar(
        title: Text("Mediminder"),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text("Salir"),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.black),
            ),
            onPressed: ()async{
              await _auth.signOut();
            },
          )
        ],
      ),
    );

  }
}
