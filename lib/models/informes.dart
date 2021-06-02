import 'package:mediminder/models/alarmaMedicamento.dart';
import 'package:mediminder/services/database.dart';

class Informe {
  DateTime fecha;
  String idMedicamento;
  String nombreMedicamento;
  String delay;
  Informe({this.fecha,this.idMedicamento,this.nombreMedicamento,this.delay});

  final DatabaseService _database=DatabaseService();

  void crearInforme(String idPaciente, String nombrePaciente,
      AlarmaMedicamento medicamento,String delay) {
      _database.addInforme(idPaciente,medicamento, delay);
  }
  String calcularDelay(DateTime horaMed,DateTime horaToma){
    int delay=horaToma.difference(horaMed).inHours;
    return delay.toString();
  }
}