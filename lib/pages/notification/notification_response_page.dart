import 'package:flutter/material.dart';

class NotificationResponsePage extends StatelessWidget {
  final String visitorName;
  final String visitorImage;
  const NotificationResponsePage({
    super.key,
    required this.visitorImage,
    required this.visitorName,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notification Screen",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text("Notifiation Received"),
            ),
            Center(
              child: Text(visitorName),
            ),
            // Center(
            //   child: Image.network(visitorImage),
            // ),
          ],
        ),
      ),
    );
  }
}

void onAccept() {
  print("accepted");
}

void onDeny() {
  print("denied");
}
