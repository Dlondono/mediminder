import 'package:firebase_auth/firebase_auth.dart';
import 'package:mediminder/models/user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  //crear objeto de user con base en el de firebase
  UserLocal _userFromFirebaseUser(User user){
    return user !=null? UserLocal(uid:user.uid): null;
  }
  //sign anon
  Future signInAnon() async {
    try{
      UserCredential result =  await _auth.signInAnonymously();
      User user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
}
  //sign with email and password


}