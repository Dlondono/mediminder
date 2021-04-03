import 'package:flutter/material.dart';
import 'package:mediminder/services/auth.dart';
class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  //text field state
  String email="";
  String password="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        elevation: 1.0,
        title: Text('Registro supervisor?'),
        actions: <Widget>[
          TextButton.icon(
            icon: Icon(Icons.person),
            label: Text("Iniciar sesion"),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.black),
            ),

            onPressed: (){
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                  onChanged: (val){
                    setState(()=>email=val);
                  }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                onChanged:(val){
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                child: Text("Registrarse",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async{
                  print(email);
                  print(password);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
