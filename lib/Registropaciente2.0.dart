import 'package:flutter/material.dart';
import 'screens/home/home.dart';
import 'package:sizer/sizer.dart';

class Registropaciente extends StatefulWidget {
  @override
  _RegistropacienteState createState() => _RegistropacienteState();
}

class _RegistropacienteState extends State<Registropaciente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text("Registro paciente"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
              child: Center(
                child: Container(
                    width: 60.0.w,
                    height: 30.0.h,
                    child: Image.asset('assets/Medico.png')),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 3.0.h),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Documento de identidad',
                    hintText: 'Entre solo numeros sin puntos.'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 3.0.h),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Codigo',
                    hintText: 'Entre el codigo dado'),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 3.0.h),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Repita el codigo',
                    hintText: 'Repita el codigo dado'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 60.0.w,
              height: 7.0.h,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Home()));
                },
                child: Text(
                  'Completar registro',
                  style: TextStyle(color: Colors.white, fontSize: 15.0.sp),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 60.0.w,
              height: 7.0.h,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Home()));
                },
                child: Text(
                  'Regresar',
                  style: TextStyle(color: Colors.white, fontSize: 15.0.sp),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
