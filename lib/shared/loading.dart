import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(157, 221, 234, 50),
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 20.0,
        ),
      ),
    );
  }
}
