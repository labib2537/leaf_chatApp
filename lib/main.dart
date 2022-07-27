import 'package:flutter/material.dart';
//import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:leaf/frontEnd/AuthUI/log_in.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'Backend/firebase/OnlineDatabaseManagement/cloud_data_management.dart';
//import 'frontEnd/AuthUI/sign_up.dart';
import 'Global_Uses/foreground_receive_notificaion_management.dart';
import 'frontEnd/Main_screen/main_screen.dart';
import 'frontEnd/NewUserEntry/new_user_entry.dart';

Future<void> main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// Initialize Notification Settings
  await notificationInitialize();

  /// For Background Message Handling
  FirebaseMessaging.onBackgroundMessage(backgroundMsgAction);

  /// For Foreground Message Handling
  FirebaseMessaging.onMessage.listen((messageEvent) {
    print(
        "Message Data is: ${messageEvent.notification!.title}     ${messageEvent.notification!.body}");

    _receiveAndShowNotificationInitialization(
        title: messageEvent.notification!.title.toString(),
        body: messageEvent.notification!.body.toString());
  });



  runApp(
      MaterialApp(
        title: 'Leaf',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        home: await differentContextDecisionTake(),

  )
  );
}

Future<Widget> differentContextDecisionTake() async {
  if (FirebaseAuth.instance.currentUser == null) {
    return LohInPage();
  } else {
    final CloudStoreDataManagement _cloudStoreDataManagement = CloudStoreDataManagement();

    final bool _dataPresentResponse = await _cloudStoreDataManagement.userRecordPresentOrNot(email: FirebaseAuth.instance.currentUser!.email.toString());

    return _dataPresentResponse ? MainScreen() : TakePrimaryUserData();
  }
}
Future<void> notificationInitialize() async {
  /// Subscribe to a topic
  await FirebaseMessaging.instance.subscribeToTopic("Leaf_message");

  /// Foreground Notification Options Enabled
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

/// Receive And show Notification Customization
void _receiveAndShowNotificationInitialization(
    {required String title, required String body}) async {
  final ForegroundNotificationManagement _fgNotifyManagement =
  ForegroundNotificationManagement();

  print("Notification Activated");

  await _fgNotifyManagement.showNotification(title: title, body: body);
}

Future<void> backgroundMsgAction(RemoteMessage message) async {
  await Firebase.initializeApp();

  _receiveAndShowNotificationInitialization(
      title: message.notification!.title.toString(),
      body: message.notification!.body.toString());
}

