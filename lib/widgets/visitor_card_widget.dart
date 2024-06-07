import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/widgets/responsive_wrap.dart';
import 'package:secure_gates_project/widgets/vertical_divider_widget.dart';

import '../pages/visitors/visitors_tabs_page.dart';

class VisitorCard extends HookConsumerWidget {
  const VisitorCard({
    super.key,
    required this.visitorApproveBy,
    required this.visitorId,
    required this.visitorEnterTime,
    required this.visitorExitTime,
    required this.visitorImage,
    required this.visitorName,
    required this.visitorStatus,
    required this.visitorType,
    required this.visitorEnterDate,
    required this.visitorTypeDetail,
    required this.visitormobile,
  });

  final String visitorImage,
      visitorId,
      visitorName,
      visitorType,
      visitorStatus,
      visitorTypeDetail,
      visitorApproveBy,
      visitorEnterTime,
      visitorEnterDate,
      visitormobile,
      visitorExitTime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);
    final feedbackController = useTextEditingController();

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 2,
        vertical: 5,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: Column(
          children: [
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            visitorImage,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 1,
                            horizontal: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xff6CB4EE),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: Text(
                            visitorStatus.toUpperCase(),
                            style: GoogleFonts.montserrat(
                                fontSize: 10, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalDivider(
                    width: 10,
                    thickness: 0.5,
                    color: Colors.grey,
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                visitorName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "ID:$visitorId",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                    height: 0.9),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xff6CB4EE),
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                ),
                                child: Text(
                                  visitorType,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 3,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xff6CB4EE),
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                ),
                                child: Text(
                                  visitorTypeDetail,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                size: 18,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                "Allowed by $visitorApproveBy",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  height: 0.9,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule_outlined,
                                size: 18,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              Text(
                                "Entered at $visitorEnterTime",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  height: 0.9,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                size: 18,
                                color: Colors.grey[600],
                              ),
                              Text(
                                visitorEnterDate,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  height: 0.9,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  // ignore: avoid_print
                  onTap: () => AwesomeDialog(
                    body: TextField(
                      maxLines: 4,
                      maxLength: 100,
                      controller: feedbackController,
                      decoration: InputDecoration(
                          hintText: "Type your feedback",
                          labelStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.shade200, width: 2),
                              borderRadius: BorderRadius.circular(10)),
                          floatingLabelStyle: const TextStyle(
                              color: Color(0xffFF6663), fontSize: 18),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xffFF6663), width: 1.5),
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    context: context,
                    transitionAnimationDuration:
                        const Duration(milliseconds: 400),
                    dialogType: DialogType.warning,
                    animType: AnimType.scale,
                    btnCancelOnPress: () {},
                    btnOkOnPress: () async {
                      // await ref
                      //     .read(visitorServiceProvider)
                      //     .visitorreview(
                      //       visitorid,
                      //       feedbackController.text.trim(),
                      //     )
                      //     .catchError((e, st) {});
                    },
                    btnOkText: "Submit",
                  ).show(),
                  child: SizedBox(
                    width: Responsive.width(context) * 0.28,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.refresh_outlined,
                          weight: 15,
                          color: Color.fromARGB(255, 242, 162, 1),
                          size: 16,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Feedback",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 242, 162, 1),
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const VerticallyDivider(
                  color: Colors.grey,
                  width: 2,
                ),
                SizedBox(
                  width: Responsive.width(context) * 0.28,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cancel_outlined,
                        color: Colors.red,
                        size: 15,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(25),
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Wrong Visitor Confirm ?",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStateProperty.all(
                                                  Colors.redAccent,
                                                ),
                                              ),
                                              onPressed: () async {
                                                final formData =
                                                    FormData.fromMap({
                                                  'visitor_id': visitorId
                                                });

                                                await Dio().post(
                                                    "https://gatesadmin.000webhostapp.com/visitor_wrong.php",
                                                    data: formData);

                                                ref.refresh(
                                                    currentVisitorsProvider
                                                        .future);
                                                ref.refresh(
                                                    wrongVisitorsProvider
                                                        .future);

                                                context.pop();
                                                Fluttertoast.showToast(
                                                  msg: 'Visitor Set Wrong',
                                                  toastLength:
                                                      Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                  backgroundColor:
                                                      Colors.grey[600],
                                                  textColor: Colors.white,
                                                  fontSize: 16.0,
                                                );
                                              },
                                              child: const Text(
                                                "Confirm Action",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: const Text("Wrong Entry",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.red,
                              height: 1.2,
                            )),
                      ),
                    ],
                  ),
                ),
                const VerticallyDivider(
                  width: 2,
                  color: Colors.grey,
                ),
                GestureDetector(
                  onTap: () => AwesomeDialog(
                    context: context,
                    transitionAnimationDuration:
                        const Duration(milliseconds: 400),
                    dialogType: DialogType.question,
                    animType: AnimType.scale,
                    title: "Call Visitor",
                    desc: "Do you really want to call visitor ?",
                    btnCancelOnPress: () {},
                    btnCancelText: "No",
                    btnOkOnPress: () {
                      FlutterPhoneDirectCaller.callNumber('+91$visitormobile');
                    },
                    btnOkText: "Yes",
                  ).show(),
                  child: SizedBox(
                    width: Responsive.width(context) * 0.28,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.call,
                          size: 15,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Text(
                          "Call",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green[600],
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
