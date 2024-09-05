import 'package:flutter/material.dart';

import '../../controller/notification_controller.dart';

class NotificatinFirebase extends StatefulWidget {
  const NotificatinFirebase({super.key});

  @override
  State<NotificatinFirebase> createState() => _NotificatinFirebaseState();
}

class _NotificatinFirebaseState extends State<NotificatinFirebase> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  NotificationController.createNewNotification();
                },
                child: const Text("SHOW NOTIFICATION")),
            ElevatedButton(
                onPressed: () {
                  NotificationController.scheduleNewNotification();
                },
                child: const Text("SHOW DELAY NOTIFICATION")),
            ElevatedButton(
                onPressed: () {
                  NotificationController.resetBadgeCounter();
                },
                child: const Text("RESET BADGE COUNTER"))
          ]),
    );
  }
}
