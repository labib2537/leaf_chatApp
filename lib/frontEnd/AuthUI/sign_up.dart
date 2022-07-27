import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:leaf/Backend/firebase/Auth/email_and_pass_auth.dart';
import 'package:leaf/Backend/firebase/Auth/fb_auth.dart';
import 'package:leaf/Backend/firebase/Auth/google_auth.dart';
import 'package:leaf/Global_Uses/enum_gen.dart';
import 'package:leaf/Global_Uses/reg_exp.dart';
import 'package:leaf/frontEnd/AuthUI/log_in.dart';
import 'package:leaf/frontEnd/NewUserEntry/new_user_entry.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../Main_screen/home_page.dart';
import 'common_auth_method.dart';
//import 'log_in.dart';
//import 'package:flutter/cupertino.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _signUpKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _conPass = TextEditingController();

  final EmailAndPassAuth _emailAndPassAuth = EmailAndPassAuth();
  final GoogleAuthentication _googleAuthentication = GoogleAuthentication();
  final FacebookAuthentication _facebookAuthentication = FacebookAuthentication();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromRGBO(0, 179, 119, 1),
      body: LoadingOverlay(
        isLoading: this._isLoading,
        color: Colors.black,
        child: Container(
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 90,
              ),
              Center(
                child: Text(
                  'Sign up',
                  style: TextStyle(fontSize: 35, color: Colors.black),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 40),
                child: Form(
                  key: this._signUpKey,
                  child: ListView(
                    children: [
                      commonTextFormField(
                          hintText: 'Email',
                          validator: (inputval) {
                            if (!emailRegex.hasMatch(inputval.toString()))
                              return 'Email format has not matching';
                            return null;
                          },
                          textEditingController: this._email),
                      commonTextFormField(
                          hintText: 'Password',
                          validator: (String? inputval) {
                            if (inputval!.length < 7)
                              return 'Password must be at least 7 characters';
                            return null;
                          },
                          textEditingController: this._pass),
                      commonTextFormField(
                          hintText: 'Confirm Password',
                          validator: (String? inputval) {
                            if (inputval!.length < 7)
                              return 'Confirm password must be at least 7 characters';
                            if (this._pass.text !=this._conPass.text)
                              return 'Unmatched password';
                            return null;
                          },
                          textEditingController: this._conPass),
                      SignUpAuthBtn(context, 'Sign up'),
                    ],
                  ),
                ),
              ),
              Center(
                child: Text(
                  'or continue with',
                  style: TextStyle(fontSize: 22, color: Colors.black),
                ),
              ),
              signUpSocialMediaBtn(),
              switchAnotherAuthPage(
                  context, "Already have an account? ", "Log in"),
            ],
          ),
        ),
      ),
    ));
  }

  Widget SignUpAuthBtn(BuildContext context, String btnName) {
    return Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 0.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width - 60, 30.0),
              elevation: 5.0,
              primary: Colors.black,
              padding: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 7.0,
                bottom: 7.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              )),
          child: Text(
            btnName,
            style: TextStyle(
              fontSize: 25.0,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          onPressed: () async {
            if (this._signUpKey.currentState!.validate()) {
              print('Validated');

              if(mounted){
                setState(() {
                  this._isLoading = true;
                });
              }

              SystemChannels.textInput.invokeMethod('TextInput.hide');
              final EmailSignUpResults response = await this._emailAndPassAuth.signUpAuth(email: this._email.text, pass: this._pass.text);
              if(response == EmailSignUpResults.SignUpCompleted){
                Navigator.push(context, MaterialPageRoute(builder: (_) => TakePrimaryUserData()));

              }else{
                final String msg = response == EmailSignUpResults.EmailAlreadyPresent?'Email already present':'Sign up not completed';
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
                
              }
            } else {
              print('Not Validated');
            }
            if(mounted){
              setState(() {
                this._isLoading = false;
              });
            }

          },
        )
    );
  }

  Widget signUpSocialMediaBtn() {
    return Container(
      padding: EdgeInsets.all(40),
      width: double.maxFinite,
      //height: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: ()async{
              print("Google Pressed!");
              if(mounted){
                setState(() {
                  this._isLoading = true;
                });
              }

              final GoogleSignInResults _googleSignInResults = await this._googleAuthentication.signInWithGoogle();
              String msg = '';
              if(_googleSignInResults == GoogleSignInResults.SignInCompleted){
                msg = 'Sign in completed';
              }
              else if(_googleSignInResults == GoogleSignInResults.SignInNotCompleted)
                msg = 'Sign in not Completed';
              else if(_googleSignInResults == GoogleSignInResults.AlreadySignedIn)
                msg = 'Already Google signed in';
              else
                msg = 'Unexpected Error';
              
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

              if(_googleSignInResults == GoogleSignInResults.SignInCompleted)
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => TakePrimaryUserData()), (route) => false);

              if(mounted){
                setState(() {
                  this._isLoading = false;
                });
              }
            },
            child: Image.asset('assets/images/gl.png', width: 60,),
          ),

          SizedBox(width: 80,),
          GestureDetector(
            onTap: ()async{
              print("Facebook Pressed!");
              if(mounted){
                setState(() {
                  this._isLoading = true;
                });
              }

              final FBSignInResults _fbSignInResults = await this._facebookAuthentication.facebookLogIn();
              String msg = '';
              if(_fbSignInResults == FBSignInResults.SignInCompleted){
                msg = 'Sign in completed';
              }
              else if(_fbSignInResults == FBSignInResults.SignInNotCompleted)
                msg = 'Sign in not Completed';
              else if(_fbSignInResults == FBSignInResults.AlreadySignedIn)
                msg = 'Already Google signed in';
              else
                msg = 'Unexpected Error';

              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

              if(_fbSignInResults == FBSignInResults.SignInCompleted)
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => TakePrimaryUserData()), (route) => false);

              if(mounted){
                setState(() {
                  this._isLoading = false;
                });
              }
            },
            child: Image.asset('assets/images/fb.png', width: 60,),
          )


        ],
      ),
    );
  }

}
