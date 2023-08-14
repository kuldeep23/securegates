import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:secure_gates_project/routes/app_routes_config.dart';

class ErrorHandler {
  static final navKey = MyAppRouterConfig.rootNavigatorKey;
  //error dialogs
  static Future<dynamic> errorDialog(e) {
    return showCupertinoDialog(
        context: (navKey.currentState!.overlay!.context),
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: const Text('Authentication Error'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Center(
                      child: Text(e),
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                    child: Row(
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Okay'))
                      ],
                    ),
                  )
                ],
              ));
        });
  }
}
