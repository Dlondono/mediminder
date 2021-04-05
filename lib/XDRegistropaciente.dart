import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class XDRegistropaciente extends StatelessWidget {
  XDRegistropaciente({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Transform.translate(
            offset: Offset(-14.0, -22.7),
            child:
                // Adobe XD layer: 'Fondo' (group)
                SizedBox(
              width: 1382.0,
              height: 940.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 1382.0, 939.5),
                    size: Size(1382.0, 939.5),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child:
                        // Adobe XD layer: 'woman-1245817_1920' (shape)
                        Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage('assets/Fondo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(65.5, 124.8, 310.0, 48.0),
                    size: Size(1382.0, 939.5),
                    pinLeft: true,
                    pinTop: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'Registro paciente',
                      style: TextStyle(
                        fontFamily: 'Neo Sans',
                        fontSize: 40,
                        color: const Color(0xff000000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(105.5, 60.8, 230.0, 48.0),
                    size: Size(1382.0, 939.5),
                    pinLeft: true,
                    pinTop: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'MEDIMINDER',
                      style: TextStyle(
                        fontFamily: 'Neo Sans',
                        fontSize: 40,
                        color: const Color(0xff000000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(150.0, 194.8, 140.0, 140.0),
                    size: Size(1382.0, 939.5),
                    pinLeft: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child:
                        // Adobe XD layer: 'Medico' (shape)
                        Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage('assets/Medico.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(108.0, 552.0),
            child:
                // Adobe XD layer: 'Completar registro' (group)
                SizedBox(
              width: 196.0,
              height: 40.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 196.0, 40.0),
                    size: Size(196.0, 40.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: SvgPicture.string(
                      _svg_3v31ds,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(5.0, 8.0, 186.0, 25.0),
                    size: Size(196.0, 40.0),
                    pinLeft: true,
                    pinRight: true,
                    fixedHeight: true,
                    child: Text(
                      'Completar registro',
                      style: TextStyle(
                        fontFamily: 'Sitka Display',
                        fontSize: 25,
                        color: const Color(0xffff0000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(25.0, 338.0),
            child:
                // Adobe XD layer: 'Documento de indent…' (group)
                SizedBox(
              width: 319.0,
              height: 35.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 35.0, 35.0),
                    size: Size(319.0, 35.0),
                    pinLeft: true,
                    pinTop: true,
                    pinBottom: true,
                    fixedWidth: true,
                    child:
                        // Adobe XD layer: 'cedula-de-identidad…' (shape)
                        Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage('assets/cedula-de-identidad-con-foto-de-mujer.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(43.0, 2.0, 276.0, 30.0),
                    size: Size(319.0, 35.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff707070)),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(70.5, 8.0, 222.0, 23.0),
                    size: Size(319.0, 35.0),
                    pinRight: true,
                    pinBottom: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'Documento de identidad',
                      style: TextStyle(
                        fontFamily: 'Sitka Display',
                        fontSize: 23,
                        color: const Color(0xff000000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(25.0, 395.0),
            child:
                // Adobe XD layer: 'Codigo' (group)
                SizedBox(
              width: 316.0,
              height: 35.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(40.0, 0.0, 276.0, 30.0),
                    size: Size(316.0, 35.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff707070)),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(149.5, 8.0, 63.0, 23.0),
                    size: Size(316.0, 35.0),
                    pinBottom: true,
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'Código',
                      style: TextStyle(
                        fontFamily: 'Sitka Display',
                        fontSize: 23,
                        color: const Color(0xff000000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 35.0, 35.0),
                    size: Size(316.0, 35.0),
                    pinLeft: true,
                    pinTop: true,
                    pinBottom: true,
                    fixedWidth: true,
                    child:
                        // Adobe XD layer: 'promocion' (shape)
                        Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage('assets/Codigo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(25.0, 452.0),
            child:
                // Adobe XD layer: 'Repetir codigo' (group)
                SizedBox(
              width: 316.0,
              height: 35.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(40.0, 2.0, 276.0, 30.0),
                    size: Size(316.0, 35.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffffffff),
                        border: Border.all(
                            width: 1.0, color: const Color(0xff707070)),
                      ),
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(118.5, 7.0, 125.0, 22.0),
                    size: Size(316.0, 35.0),
                    fixedWidth: true,
                    fixedHeight: true,
                    child: Text(
                      'Repetir código',
                      style: TextStyle(
                        fontFamily: 'Sitka Display',
                        fontSize: 22,
                        color: const Color(0xff000000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 35.0, 35.0),
                    size: Size(316.0, 35.0),
                    pinLeft: true,
                    pinTop: true,
                    pinBottom: true,
                    fixedWidth: true,
                    child:
                        // Adobe XD layer: 'promocion' (shape)
                        Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage('assets/Codigo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(108.0, 629.0),
            child:
                // Adobe XD layer: 'Regresar' (group)
                SizedBox(
              width: 196.0,
              height: 40.0,
              child: Stack(
                children: <Widget>[
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(0.0, 0.0, 196.0, 40.0),
                    size: Size(196.0, 40.0),
                    pinLeft: true,
                    pinRight: true,
                    pinTop: true,
                    pinBottom: true,
                    child: SvgPicture.string(
                      _svg_tzn9fk,
                      allowDrawingOutsideViewBox: true,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Pinned.fromSize(
                    bounds: Rect.fromLTWH(46.0, 5.0, 105.0, 30.0),
                    size: Size(196.0, 40.0),
                    pinTop: true,
                    pinBottom: true,
                    fixedWidth: true,
                    child: Text(
                      'Regresar',
                      style: TextStyle(
                        fontFamily: 'Sitka Display',
                        fontSize: 30,
                        color: const Color(0xffff0000),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const String _svg_3v31ds =
    '<svg viewBox="108.0 552.0 196.0 40.0" ><path transform="translate(108.0, 552.0)" d="M 0 0 L 196 0 L 196 40 L 0 40 L 0 0 Z" fill="#d1cacc" stroke="#707070" stroke-width="1" stroke-linecap="round" stroke-linejoin="bevel" /></svg>';
const String _svg_tzn9fk =
    '<svg viewBox="108.0 629.0 196.0 40.0" ><path transform="translate(108.0, 629.0)" d="M 0 0 L 196 0 L 196 40 L 0 40 L 0 0 Z" fill="#d1cacc" stroke="#707070" stroke-width="1" stroke-linecap="round" stroke-linejoin="bevel" /></svg>';
