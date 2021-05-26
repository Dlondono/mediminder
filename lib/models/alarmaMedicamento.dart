class AlarmaMedicamento{
    String medicamentoNombre;
    String descripcion;
    int cantidad;
    DateTime hora;
    int periodo;
    String idPaciente;
    int dosis;
    String uid;

    AlarmaMedicamento({this.medicamentoNombre,this.descripcion,this.cantidad,
        this.hora, this.periodo, this.idPaciente,this.dosis,this.uid});
    setTime(DateTime t){
        this.hora = t;
    }
}