import 'dart:async';
import 'dart:ffi';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/controller/user_controller.dart';
import 'package:secure_gates_project/widgets/circular_button.dart';
import 'package:secure_gates_project/widgets/vertical_divider_widget.dart';

import '../../entities/visitor_from_notification.dart';

// late Timer? _timer;

class NotificationResponsePage extends HookConsumerWidget {
  final VisitorFromNotification notificationVisitor;

  const NotificationResponsePage({
    super.key,
    required this.notificationVisitor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final currentUser = ref.read(userControllerProvider).currentUser!;
    final remainingTime = useState<int>(15);
    final timer = useState<Timer?>(null);

    useEffect(() {
      void tick(Timer timer) {
        if (remainingTime.value > 1) {
          remainingTime.value -= 1;
        } else {
          timer.cancel();
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
        }
      }

      timer.value = Timer.periodic(const Duration(seconds: 1), tick);

      return () {
        timer.value?.cancel();
      };
    }, []);

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
                        currentUser.socName,
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
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final data = FormData.fromMap({
                          "uid": notificationVisitor.visitorId,
                          "visitor_app_rej": "Denied",
                          "visitor_app_rej_by": "Owner",
                          "visitor_app_rej_by_name": currentUser.ownerFirstName,
                        });

                        final Dio dio = Dio();
                        final response = await dio.post(
                          "https://gatesadmin.000webhostapp.com/visitor_app_rej_update.php",
                          data: data,
                        );
                        if (context.mounted) {
                          context.pop();
                        }

                        print(response.data["msg"]);
                      },
                      child: const CircularButton(
                        color: Colors.redAccent,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
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
                    GestureDetector(
                      onTap: () async {
                        final data = FormData.fromMap({
                          "uid": notificationVisitor.visitorId,
                          "visitor_app_rej": "Allowed",
                          "visitor_app_rej_by": "Owner",
                          "visitor_app_rej_by_name": currentUser.ownerFirstName,
                        });

                        final Dio dio = Dio();
                        final response = await dio.post(
                          "https://gatesadmin.000webhostapp.com/visitor_app_rej_update.php",
                          data: data,
                        );
                        if (context.mounted) {
                          context.pop();
                        }
                        print(response.data["msg"]);
                      },
                      child: const CircularButton(
                        color: Colors.lightGreen,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
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
          Padding(
            padding: const EdgeInsets.only(
              top: 100,
            ),
            child: Text(
              "This page will pop after ${remainingTime.value} seconds",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
