import 'package:flutter/material.dart';
import 'package:mediminder/screens/authenticate/authenticate.dart';

class Inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
      title: Text("Mediminder supervisor"),
      backgroundColor: Colors.blue,

    ),
      body: Container(
        child: ElevatedButton(
          child: Text("Supervisor"),


        )
        ,
    ),
      );
  }
}
