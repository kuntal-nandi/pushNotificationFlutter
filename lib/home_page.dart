import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'notification service/notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState(){

    super.initState();

    FirebaseMessaging.instance.getInitialMessage().then((value) {
      print('************************${value!.data}');
      if(value!=null){
        print('new notification');
      }
    });

    // this will call when you are using your app and get a notification
    FirebaseMessaging.onMessage.listen((message) {
      if(message.notification!=null){
        LocalNotificationService.display(message);
        print('@@@@@@@@@@@@@@@@@@@@@');
        print(message.notification!.title);
        print(message.notification!.body);
        print(message.data);
          Future.delayed(Duration.zero);
          showSnackBar(context,message.notification!.title?? 'New Notification',message.notification!.body?? 'anonymous');
        
      }
    });

    
    // this will call when your app is on background and you clicked on recieved notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if(message.notification!=null){
        print('%%%%%%%%%%%%%%%%%%%%%%%');
        print(message.notification!.title);
        print(message.notification!.body);
        print(message.data);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Push Notification'),
      ),
      body: const Center(
        child:  Text('push Notification'),
      ),
    );
  }
}

void showSnackBar(BuildContext context,String message,String sub) {
    final snackBar = SnackBar(
      action: SnackBarAction(label: 'close',textColor: Colors.black, onPressed: (){
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }),
      content: Column(
        children: [
          Text(message),
          Text(sub),
        ],
      ),
      backgroundColor: Colors.teal,
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
