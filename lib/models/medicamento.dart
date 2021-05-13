class Medicamento{
  final String medicamentoNombre;
  final String idPaciente;
  int cantidad;
  int hora;
  int minuto;
  final int periodo;
  final String recomendacion;
  final int dosis;


  Medicamento({this.medicamentoNombre,this.idPaciente,this.cantidad,this.hora,this.minuto,this.periodo, this.recomendacion, this.dosis});
  setTime(int h, int m){
    hora = h;
    minuto = m;
  }

}