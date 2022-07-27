import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(34, 48, 60, 1),


      body: Container(


        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,

        child: ListView(
          shrinkWrap: true,
          children: [
            _image(),
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),


              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'About Leaf',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 20.0, left: 20.0, right: 20.0, top: 10.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "A Private, Secure, End-to-End Encrypted Messaging app that helps you to connect with your connections without any Ads, promotion. No other third party person, organization, or even Generation Team can't read your messages. Nobody can't take screenshot or can't do screen recording of this app.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.white70, fontSize: 16.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 20.0, left: 20.0, right: 20.0, top: 10.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Alert:  If you registered your mobile number and if any connection will call you, your number will visible in their call Logs.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.redAccent, fontSize: 16.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 20.0, left: 20.0, right: 20.0, top: 10.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Messages and Activity except Audio Calling\nare End-to-End Encrypted',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.amber, fontSize: 16.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 20.0, left: 20.0, right: 20.0, top: 30.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Hope You will Enjoy this application\n( فريحان )',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 18.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 20.0, left: 20.0, right: 20.0, top: 50.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Creator\nSayed Farhan Labib Karib',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color.fromRGBO(0, 179, 119, 1), fontSize: 18.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _image() {
    return Center(
    child: CircleAvatar(
    backgroundImage: ExactAssetImage('assets/images/leaf.png'),
    backgroundColor: const Color.fromRGBO(34, 48, 60, 1),
    radius: 30,
    /*radius: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height *
    (1.2 / 8) /
    2.5
        : MediaQuery.of(context).size.height *
    (2.5 / 8) /
    2.5,*/
    ),
    );
  }
}