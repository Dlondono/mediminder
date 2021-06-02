import 'package:flutter/material.dart';
import 'package:mediminder/models/informes.dart';
import 'package:sizer/sizer.dart';
class InformeDiseno extends StatelessWidget {
  final Informe informe;
  InformeDiseno({this.informe});
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 1.0.h),
      child: GestureDetector(//padding
        onTap: (){
          /*Navigator.push(context, MaterialPageRoute(
              builder: (context)=> detallesMedicamento(medicamento:medicamento)));
        */
        },
        child: Card(
          color: Color.fromRGBO(255, 255, 255, 50),
          margin: EdgeInsets.symmetric(vertical: 1.0.h, horizontal: 3.0.h),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text(informe.nombreMedicamento+ "\n" +informe.delay+ "\n"
                    +informe.fecha.toString(),
                    style: TextStyle(fontSize: 20,color: Colors.black)),
                ),
              /*TextButton.icon(
                icon: Icon(Icons.medical_services),
                label: Text("Hora de medicamento: " + hora.toString() +
                    ":" + medicamento.hora.minute.toString() + " " + formato),
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(TextStyle(fontSize: 18,color: Colors.black)),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>
                          detallesMedicamento(medicamento: medicamento,)));
                },
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
