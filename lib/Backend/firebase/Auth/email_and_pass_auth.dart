import 'package:firebase_auth/firebase_auth.dart';
import 'package:leaf/Global_Uses/enum_gen.dart';
class EmailAndPassAuth{
 
  Future<EmailSignUpResults> signUpAuth({required String email, required String pass})async{
    try{
      final UserCredential userCredential =   await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: pass);
      if(userCredential.user!.email != Null){
        await userCredential.user!.sendEmailVerification();
        return EmailSignUpResults.SignUpCompleted;
      }
      return EmailSignUpResults.SignUpNotCompleted;
    }catch(e){
      print('Error in Email and Password Sign Up: ${e.toString()}');
      return EmailSignUpResults.EmailAlreadyPresent;
    }
  }
  Future<EmailSignInResults> signInWithEmailAndPassword({required String email, required String pass})async{

    try{
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass);
        if(userCredential.user!.emailVerified)
          return EmailSignInResults.SignInComplete;
        else{
          final bool logOutResponse = await logOut();
          if(logOutResponse)
            return EmailSignInResults.EmailNotVerified;
          return EmailSignInResults.UnexpectedError;
        }

    }catch(e){
      print('Error in sign in with Email and Password authentication: ${e.toString()}');
      return EmailSignInResults.EmailOrPasswordInvalid;
    }


  }

  Future<bool> logOut()async{
    try{
      await FirebaseAuth.instance.signOut();
      return true;

    }catch(e){
      return false;

    }
  }

}