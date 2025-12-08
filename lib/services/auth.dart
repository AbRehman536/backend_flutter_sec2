import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{
  //register user
  Future<User> registerUser({
    required String email,required String password}) async{
    try{
      UserCredential userCred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      userCred.user!.sendEmailVerification();
      return userCred.user!;
    }catch(e){
      throw e.toString();
    }
  }
  //login user
  Future<User> loginUser({
    required String email,required String password}) async{
    try{
      UserCredential userCred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCred.user!;
    }catch(e){
      throw e.toString();
    }
  }
  //reset password
  Future resetPasswrod(String email) async{
    try{
      return await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email);
    }catch(e){
      throw e.toString();
    }
  }
}