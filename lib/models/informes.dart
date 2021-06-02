import 'package:mediminder/models/alarmaMedicamento.dart';
import 'package:mediminder/services/database.dart';

class Informe {
  String nombrePaciente;
  AlarmaMedicamento medicamento;
  Informe({this.nombrePaciente, this.medicamento});

  final DatabaseService _database=DatabaseService();

  void crearInforme(String idPaciente, String nombrePaciente,
      AlarmaMedicamento medicamento,String delay) {
      _database.addInforme(idPaciente,medicamento, nombrePaciente, delay);
  }
  String calcularDelay(DateTime horaMed,DateTime horaToma){
    int delay=horaToma.difference(horaMed).inHours;
    return delay.toString();
  }
}