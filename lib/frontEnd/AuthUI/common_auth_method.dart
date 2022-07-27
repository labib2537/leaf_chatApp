import 'package:flutter/material.dart';
import 'package:leaf/frontEnd/AuthUI/sign_up.dart';

import 'log_in.dart';
//import 'package:flutter/cupertino.dart';

Widget commonTextFormField({required String hintText, required String? Function(String?)? validator, required TextEditingController textEditingController, double bottomPadding = 50}) {
  return Container(
    padding: EdgeInsets.only(left: 25, right: 25, bottom: bottomPadding),
    child: TextFormField(
      validator: validator,
      controller: textEditingController,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF004d00),
            width: 2.0,
          ),
        ),
      ),
    ),
  );
}
/*
Widget authBtn(BuildContext context, String btnName) {

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
        onPressed: () async {},

      )
  );

}
*/
/*
Widget socialMediaBtn() {
  return Container(
    padding: EdgeInsets.all(40),
    width: double.maxFinite,
    //height: double.maxFinite,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){
            print("Google Pressed!");
          },
          child: Image.asset('assets/images/gl.png', width: 60,),
        ),

        SizedBox(width: 80,),
        GestureDetector(
          onTap: (){
            print("Facebook Pressed!");
          },
          child: Image.asset('assets/images/fb.png', width: 60,),
        )


      ],
    ),
  );
}
*/
Widget switchAnotherAuthPage(BuildContext context, String BtnName1, String BtnName2) {
  return ElevatedButton(
    child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(BtnName1,
            style: TextStyle(color: Colors.white, fontSize: 17, letterSpacing: 1.0,),

          ),
          Text(BtnName2, style: TextStyle(color: Colors.black,fontSize: 17,letterSpacing: 1.0),),
        ]
    ),
    style: ElevatedButton.styleFrom(
      elevation: 0.0,
      primary: Color.fromRGBO(0, 179, 119, 1),
    ),
    onPressed: () {
      if(BtnName2=="Log in"){
        Navigator.push(context, MaterialPageRoute(builder: (_) => LohInPage()));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage()));
      }

    },

  );
}

