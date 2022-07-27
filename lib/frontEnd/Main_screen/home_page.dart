import 'package:flutter/material.dart';
import 'package:leaf/Backend/firebase/Auth/email_and_pass_auth.dart';
import 'package:leaf/Backend/firebase/Auth/fb_auth.dart';
import 'package:leaf/Backend/firebase/Auth/google_auth.dart';
import 'package:leaf/frontEnd/AuthUI/log_in.dart';
//import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GoogleAuthentication _googleAuthentication = GoogleAuthentication();
  final EmailAndPassAuth _emailAndPassAuth = EmailAndPassAuth();
  final FacebookAuthentication _facebookAuthentication = FacebookAuthentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          child: Text('Log out'),
          onPressed: ()async{
            final bool googleResponse = await this._googleAuthentication.logOut();
            if(!googleResponse){
              final bool fbResponse = await this._facebookAuthentication.logOut();
              if(!fbResponse) await this._emailAndPassAuth.logOut();

            }
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LohInPage()), (route) => false);

          },
        ),
      ),
    );
  }
}
