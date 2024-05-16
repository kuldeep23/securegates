import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/controller/user_controller.dart';
import 'package:secure_gates_project/widgets/circular_button.dart';
import 'package:secure_gates_project/widgets/vertical_divider_widget.dart';

import '../../entities/visitor_from_notification.dart';

class NotificationResponsePage extends HookConsumerWidget {
  final VisitorFromNotification notificationVisitor;

  const NotificationResponsePage({
    super.key,
    required this.notificationVisitor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final socName = ref.read(userControllerProvider).currentUser!.socName;

    return Scaffold(
      body: Column(
        children: [
          Container(
            width: size.width,
            height: size.height / 1.7,
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              top: 30,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
              gradient: LinearGradient(
                  colors: [
                    Color(0xFFf7625c),
                    Color(0xFFffa8bc),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Secure Gates",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      90,
                    ),
                  ),
                  child: Image(
                    image: NetworkImage(
                      notificationVisitor.visitorImage,
                    ),
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  notificationVisitor.visitorName,
                  style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      notificationVisitor.visitorType,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const VerticallyDivider(
                      color: Colors.white,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "${notificationVisitor.visitorTypeDetail} is",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const Text(
                  "waiting at the door",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 25),
                Transform.translate(
                  offset: const Offset(0, 40),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.redAccent,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        socName,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CircularButton(
                      color: Colors.redAccent,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Deny Visitor",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CircularButton(
                      color: Colors.lightGreen,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Accept Visitor",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.lightGreen,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    CircularButton(
                      color: Colors.orangeAccent,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Leave at the gate",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
