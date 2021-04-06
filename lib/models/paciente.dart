import 'package:mediminder/models/medicamento.dart';

class Paciente{
  final String nombre;
  final String id;
  final List<Medicamento> medicina;

  Paciente({this.nombre,this.id,this.medicina});

}