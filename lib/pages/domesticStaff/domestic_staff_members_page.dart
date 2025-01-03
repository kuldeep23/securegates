import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/controller/user_controller.dart';
import '../../../entities/staff.dart';

final staffMemberProvider = FutureProvider.autoDispose
    .family<List<StaffMember>, String>((ref, staffType) async {
  final socCode = ref.read(userControllerProvider).currentUser!.socCode;

  final data = FormData.fromMap({'soc': socCode, 'staff_type': staffType});

  final response = await Dio().post(
    "https://peru-heron-650794.hostingersite.com/staff_member.php",
    data: data,
  );
  ref.keepAlive();

  final results = List<Map<String, dynamic>>.from(response.data);

  List<StaffMember> staffList = results
      .map((staffData) => StaffMember.fromMap(staffData))
      .toList(growable: false);

  return staffList;
});

class DomesticStaffMembersPage extends HookConsumerWidget {
  const DomesticStaffMembersPage({super.key, required this.staffType});

  final String staffType;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffTypeMembers = ref.watch(staffMemberProvider(staffType));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          staffType,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Text(
                  "Inside",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          staffTypeMembers.when(
              data: (data) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    child: Column(
                      children: data
                          .map(
                            (item) => GestureDetector(
                              onTap: () {
                                /* context.pushNamed(
                                  MyAppRoutes.domesticStaffMembersDetailsPage,
                                  extra: item,
                                ); */
                                quickDialogue(
                                  callBack: () {},
                                  subtitle: item.staffStatus,
                                  title: item.staffName,
                                  visitormobile: item.staffMobileNo,
                                  visitorType: item.staffType,
                                  context: context,
                                  inTime: item.staffCreationDate,
                                  inDate: item.staffCreationDate,
                                  outTime: item.staffStatus ?? "Still Inside",
                                  outDate: item.staffStatus ?? "Still Inside",
                                  allowedBy: item.staffStatus,
                                  visitorTypeDetail: item.staffType,
                                  phoneNo: item.staffMobileNo,
                                  image: NetworkImage(
                                    item.staffIcon,
                                  ),
                                );
                              },
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 10,
                                      ),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 32,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        item.staffIcon,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 1,
                                                  horizontal: 5,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: item.staffStatus ==
                                                          "Inside"
                                                      ? const Color(0xffFF6663)
                                                      : Colors.green[600],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10,
                                                  ),
                                                ),
                                                child: Text(
                                                  item.staffStatus
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      item.staffName,
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 1,
                                                        horizontal: 5,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 102, 102, 216),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          5,
                                                        ),
                                                      ),
                                                      child: Text(
                                                        "ID : ${item.uid}",
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  "Rating ⭐️${item.staffRating}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  "Works in H.No. ${item.staffIsActive}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) {
                return Text(e.toString());
              }),
        ],
      ),
    );
  }

  Future<void> quickDialogue({
    Color dialogueThemeColor = const Color(0xffFF6663),
    required void Function() callBack,
    String discardTitle = 'Cancel',
    String submitTitle = 'Okay',
    required String visitorType,
    required String subtitle,
    bool onlyShow = false,
    required String title,
    required BuildContext context,
    required ImageProvider image,
    required String inTime,
    required String inDate,
    required String outTime,
    required String visitormobile,
    required String outDate,
    required String allowedBy,
    required String visitorTypeDetail,
    required String phoneNo,
  }) async {
    await showGeneralDialog(
      transitionDuration: const Duration(milliseconds: 600),
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.85),
      context: context,
      pageBuilder: (context, a1, a2) {
        return Container();
      },
      transitionBuilder: (context, a1, a2, widget) {
        return ScaleTransition(
          scale: Tween(begin: 0.5, end: 1.0).animate(a1),
          child: FadeTransition(
            opacity: Tween(begin: 0.5, end: 1.0).animate(a1),
            child: Theme(
              data: Theme.of(context)
                  .copyWith(dialogBackgroundColor: Colors.white),
              child: AlertDialog(
                contentPadding: const EdgeInsets.all(0.0),
                //insetPadding: EdgeInsets.all(5),
                titlePadding: const EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: SizedBox(
                  width: 800,
                  child: Column(
                    children: [
                      Transform.translate(
                        offset: const Offset(0, -50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 25,
                            ),
                            Text(
                              visitorType,
                              style: const TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 25,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          /* 
                          Navigator.push(
                            context,
                             MaterialPageRoute(
                            builder: (context) =>
                                HeroPhotoViewRouteWrapper(imageProvider: image),
                          ), *
                          ); */
                        },
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          child: Hero(
                            tag: image,
                            child: Image(
                              image: image,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.phone_android_outlined,
                              size: 15,
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Text(
                              phoneNo,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Divider(),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      "4 Rating",
                    ),
                    const SizedBox(height: 5),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image(
                            image: AssetImage("assets/icons/punctuality.png"),
                            height: 50,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Image(
                            image: AssetImage("assets/icons/schedule.png"),
                            height: 50,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Image(
                            image: AssetImage("assets/icons/behavior.png"),
                            height: 50,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 1,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 34, 74, 103),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: const Text(
                              "5",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 1,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 34, 74, 103),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: const Text(
                              "5",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 1,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 34, 74, 103),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                            ),
                            child: const Text(
                              "5",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Punctual",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          SizedBox(
                            width: 17,
                          ),
                          Text(
                            "Regular",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Service",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 7),
                    InkWell(
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
                          FlutterPhoneDirectCaller.callNumber(
                              '+91$visitormobile');
                        },
                        btnOkText: "Yes",
                      ).show(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: const BoxDecoration(
                                color: Color(0xffFF6663),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(
                                    20,
                                  ),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  ),
                                  Text("Call Staff",
                                      style: TextStyle(color: Colors.white))
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: const BoxDecoration(
                                color: Color(0xffFF6663),
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(
                                    20,
                                  ),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "Call User",
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
