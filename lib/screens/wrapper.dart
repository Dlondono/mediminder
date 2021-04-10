import 'package:flutter/material.dart';
import 'package:mediminder/models/userLocal.dart';
import 'package:mediminder/screens/authenticate/authenticate.dart';
import 'package:mediminder/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //user para provider
    final user=Provider.of<UserLocal>(context);
    print(user);

    // return either Home or Authentic widget
    if(user==null) {
      return Authenticate();
    }else{
      return Home();
    }
  }
}