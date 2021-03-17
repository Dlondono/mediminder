import 'package:flutter/material.dart';
import 'package:mediminder/screens/authenticate/authenticate.dart';
import 'package:mediminder/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // return either Home or Authentic widget
    return Authenticate();
  }
}
