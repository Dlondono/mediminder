import 'package:mediminder/models/alarmaMedicamento.dart';
import 'package:mediminder/services/database.dart';

class Informe {
  String fecha;
  String idMedicamento;
  String nombreMedicamento;
  String delay;
  String idPaciente;
  Informe({this.fecha,this.idPaciente,this.idMedicamento,this.nombreMedicamento,this.delay});

  final DatabaseService _database=DatabaseService();

  void crearInforme(String idPaciente, String nombrePaciente,
      AlarmaMedicamento medicamento,String delay) {
      _database.addInforme(idPaciente,medicamento, delay);
  }
  String calcularDelay(DateTime horaMed,DateTime horaToma){
    int delay=horaToma.difference(horaMed).inHours.abs();
    return delay.toString();
  }
}