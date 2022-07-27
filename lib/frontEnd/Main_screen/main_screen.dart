import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:leaf/frontEnd/Main_screen/chatAndActivityScreen.dart';
import 'package:leaf/frontEnd/Main_screen/general_connection_section.dart';
import 'package:leaf/frontEnd/Main_screen/logs_collection.dart';
import 'package:animations/animations.dart';
import 'package:leaf/frontEnd/MenuScreen/about_screen.dart';
import 'package:leaf/frontEnd/MenuScreen/profile_screen.dart';
import 'package:leaf/frontEnd/MenuScreen/settings_screen.dart';
import 'package:leaf/frontEnd/MenuScreen/SupportScreens/support_screen.dart';

import '../../Backend/firebase/Auth/email_and_pass_auth.dart';
import '../../Backend/firebase/Auth/fb_auth.dart';
import '../../Backend/firebase/Auth/google_auth.dart';
import '../AuthUI/log_in.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  int _currIndex = 0;

  final GoogleAuthentication _googleAuthentication = GoogleAuthentication();
  final EmailAndPassAuth _emailAndPassAuth = EmailAndPassAuth();
  final FacebookAuthentication _facebookAuthentication = FacebookAuthentication();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
        child: WillPopScope(
        onWillPop: () async {
      if (_currIndex > 0)
        return false;
      else {
        return true;
      }
    },
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(34, 48, 60, 1),
        drawer: _drawer(),
    appBar: AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu),
          color: Colors.black,
          iconSize: 30,
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
    brightness: Brightness.dark,
      backgroundColor: Color.fromRGBO(0, 179, 119, 1),
    elevation: 10.0,
    shadowColor: Color.fromRGBO(0, 179, 119, 1),
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(30.0),
    bottomRight: Radius.circular(30.0),
    ),
    side: BorderSide(width: 0.1),
    ),
    title: Text(
    "Leaf",
    style: TextStyle(
    fontSize: 25.0, fontFamily: 'Lora', letterSpacing: 1.2, color: Colors.black),
    ),
      actions: [
    Padding(
    padding: EdgeInsets.only(right: 10.0),
      child: Icon(
        Icons.search_outlined,
        color: Colors.black,
        size: 30.0,
      ),
    ),
      Padding(
        padding: EdgeInsets.only(
          right: 20.0,
        ),
        child: IconButton(
          tooltip: 'Refresh',
          icon: Icon(
            Icons.refresh_outlined,
            color: Colors.black,
            size: 30.0,
          ),
          onPressed: () async {},
        ),
      ),
      ],

      bottom: _bottom(),

    ),
      body: TabBarView(
        children: [
          ChatAndActivityScreen(),
          LogsCollection(),
          GeneralMessagingSection(),

        ],
      ),

    ),
        ),
    );
  }
  TabBar _bottom() {
    return TabBar(
      indicatorPadding: EdgeInsets.only(left: 20.0, right: 20.0),
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black38,
      indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 6.0, color: Colors.black),
          insets: EdgeInsets.symmetric(horizontal: 15.0)),
      automaticIndicatorColorAdjustment: true,
      labelStyle: TextStyle(
        fontFamily: 'Lora',
        fontWeight: FontWeight.w500,
        letterSpacing: 1.0,
      ),
      onTap: (index) {
        print("\nIndex is: $index");
        if (mounted) {
          setState(() {
            _currIndex = index;
          });
        }
      },
      tabs: [
        Tab(
          child: Text(
            "Chats",
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Lora',
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
            ),
          ),
        ),
        Tab(
          child: Text(
            "Logs",
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Lora',
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
            ),
          ),
        ),
        Tab(
          icon: Icon(
            Icons.store,
            size: 27.0,
          ),
        ),
      ],
    );
  }

  Widget _drawer() {
    return Drawer(
      elevation: 10.0,

      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: const Color.fromRGBO(34, 48, 60, 1),
        child: ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => ProfileScreen()));
              },
              child: Center(
                child: CircleAvatar(
                  backgroundImage: ExactAssetImage('assets/images/leaf.png'),
                  backgroundColor: const Color.fromRGBO(34, 48, 60, 1),
                  radius: MediaQuery.of(context).orientation == Orientation.portrait ? MediaQuery.of(context).size.height *
                      (1.2 / 8) /
                      2.5
                      : MediaQuery.of(context).size.height *
                      (2.5 / 8) /
                      2.5,
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            _menuOptions(Icons.person_outline_rounded, 'Profile'),
            SizedBox(
              height: 10.0,
            ),
            _menuOptions(Icons.settings, 'Setting'),
            SizedBox(
              height: 10.0,
            ),
            _menuOptions(Icons.support_outlined, 'Support'),
            SizedBox(
              height: 10.0,
            ),
            _menuOptions(Icons.description_outlined, 'About'),
            SizedBox(
              height: 30.0,
            ),
            exitButtonCall(),
          ],
        ),
      ),
    );
  }

  Widget _menuOptions(IconData icon, String menuOptionIs) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: Duration(
        milliseconds: 500,
      ),
      closedElevation: 0.0,
      openElevation: 3.0,
      closedColor: const Color.fromRGBO(34, 48, 60, 1),
      openColor: const Color.fromRGBO(34, 48, 60, 1),
      middleColor: const Color.fromRGBO(34, 48, 60, 1),
      onClosed: (value) {
        // print('Profile Page Closed');
        // if (mounted) {
        //   setState(() {
        //     ImportantThings.findImageUrlAndUserName();
        //   });
        // }
      },
      openBuilder: (context, openWidget) {

        if (menuOptionIs == 'Profile')
          return ProfileScreen();
        else if (menuOptionIs == 'Setting')
          return SettingsWindow();
        else if (menuOptionIs == 'Support')
          return SupportMenuMaker();
        else if (menuOptionIs == 'About') return AboutSection();
        return Center();
      },
      closedBuilder: (context, closeWidget) {
        return SizedBox(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Color.fromRGBO(0, 179, 119, 1),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                menuOptionIs,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget exitButtonCall() {
    return GestureDetector(
      onTap: () async {
        final bool googleResponse = await this._googleAuthentication.logOut();
        if(!googleResponse){
          final bool fbResponse = await this._facebookAuthentication.logOut();
          if(!fbResponse) await this._emailAndPassAuth.logOut();

        }

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LohInPage()), (route) => false);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.exit_to_app_rounded,
            color: Color.fromRGBO(0, 179, 119, 1),
          ),
          SizedBox(
            width: 10.0,
          ),
          Text(
            'Exit',
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }


}


