import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hand_one/Navigation/navigation_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();

  const InitializationSettings initializationSettings =
      InitializationSettings(iOS: initializationSettingsIOS);
  await FlutterLocalNotificationsPlugin().initialize(initializationSettings);
  await FlutterLocalNotificationsPlugin()
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  bool initialized = true;

  void setUpFirebaseListner() {
    FirebaseFirestore.instance
        .collection('categories')
        .orderBy('timestamp', descending: true)
        .limit(10)
        .snapshots()
        .listen((event) {
      if (initialized) {
        initialized = false;
        return;
      }
      event.docChanges.forEach((element) {
        if (element.type == DocumentChangeType.added) {
          final data = element.doc.data();
          if (data != null) {
            shoNotification(data);
          }
        }
      });
    });
  }

  void shoNotification(Map<String, dynamic> data) async {
    const DarwinNotificationDetails iOS = DarwinNotificationDetails();
    const platform = NotificationDetails(iOS: iOS);
    await FlutterLocalNotificationsPlugin().show(
      0,
      data['name'],
      data['address'],
      platform,
      payload: data['address'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BottomNavigationPage(),
    );
  }
}
