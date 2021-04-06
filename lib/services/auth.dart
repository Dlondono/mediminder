import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediminder/models/userLocal.dart';
import 'package:mediminder/services/database.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //crear objeto de user con base en el de firebase
  UserLocal _userFromFirebaseUser(User user){
    return user !=null? UserLocal(uid:user.uid): null;
  }
  //deteccion de auth --- main detecta get user
  Stream<UserLocal> get user{
    return _auth.authStateChanges().map(_userFromFirebaseUser);
        //.map((User user)=> _userFromFirebaseUser(user));
  }


  //sign anon
  Future signInAnon() async {
    try{
      UserCredential result =  await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
}
  //sign with email and password
  Future signInEmailPass(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }

  //register email and password
  Future registerEmailPass(String email, String password, String nombre, String id) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      //creacion de documento en firestore por uid
      await DatabaseService(uid:user.uid).updateUserData(nombre,id);

      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }

  Future signOut()async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}