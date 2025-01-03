import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:secure_gates_project/controller/user_controller.dart';
import 'package:secure_gates_project/entities/carousel_item.dart';
import 'package:secure_gates_project/entities/home_page_card_item.dart';
import 'package:secure_gates_project/entities/visitor.dart';
import 'package:secure_gates_project/main.dart';
import 'package:secure_gates_project/entities/visitor_from_notification.dart';
import 'package:secure_gates_project/routes/app_routes_config.dart';
import 'package:secure_gates_project/services/auth_service.dart';
import 'package:secure_gates_project/services/dashboard_data_service.dart';
import 'package:secure_gates_project/widgets/home_page_card.dart';
import 'package:secure_gates_project/widgets/photo_view_wrapper.dart';
import 'package:secure_gates_project/widgets/skelton_widget.dart';

import '../../routes/app_routes_constants.dart';
import '../../services/notification_service.dart';
import '../visitors/visitors_tabs_page.dart';

final carouselDataProvider =
    FutureProvider.autoDispose<List<CarouselItem>>((ref) async {
  final data = ref.read(dashboardServiceProvider);
  final items = data.getCarouselItems();

  return items;
});

final featuresDataProvider =
    FutureProvider.autoDispose<List<HomePageCardItem>>((ref) async {
  final data = ref.read(dashboardServiceProvider);

  final cards = data.getHomePageCards();

  return cards;
});

final homePageVisitors = FutureProvider.autoDispose<List<Visitor>>((ref) async {
  final data = ref.read(dashboardServiceProvider);
  final visitors = data.getLastThreeVisitors();

  return visitors;
});

// class HomePage extends StatefulHookConsumerWidget {
//   const HomePage({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
// }
// class _HomePageState extends ConsumerState<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final carouselData = ref.watch(carouselDataProvider);
    final featureData = ref.watch(featuresDataProvider);
    final visitorsData = ref.watch(homePageVisitors);
    final userProvider = ref.watch(userControllerProvider);
    final selectedIndex = useState(0);
    final currentCarouselIndex = useState(0);
    final CarouselController carouselController = CarouselController();
    final isConnectedToNetwork = useState(false);
    final isLoadingNetworkRequest = useState(false);
    final connectivity = Connectivity();

    Future<void> getTappedFunction() async {
      var details = await FlutterLocalNotificationsPlugin()
          .getNotificationAppLaunchDetails();
      if (details != null && details.didNotificationLaunchApp) {
        // Fluttertoast.showToast(
        //     msg: "${details.payload!} : toast message payload");
        MyAppRouterConfig.rootNavigatorKey.currentContext?.pushNamed(
          MyAppRoutes.notificationResponsePage,
          extra: VisitorFromNotification.fromMap(
            jsonDecode(details.notificationResponse!.payload!),
          ),
        );
      } else {
        // Fluttertoast.showToast(msg: "not launched from notification");
      }
    }

    useEffect(() {
      isLoadingNetworkRequest.value = true;
      final networkSubscription = connectivity.onConnectivityChanged
          .listen((ConnectivityResult result) {
        switch (result) {
          case ConnectivityResult.mobile:
            isConnectedToNetwork.value = true;
            return;
          case ConnectivityResult.bluetooth:
            return;
          case ConnectivityResult.ethernet:
            return;
          case ConnectivityResult.vpn:
            return;
          case ConnectivityResult.other:
            return;
          case ConnectivityResult.wifi:
            isConnectedToNetwork.value = true;
            return;
          case ConnectivityResult.none:
            isConnectedToNetwork.value = false;
            return;
        }
      });

      getTappedFunction();
      if (Platform.isAndroid) {
        FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
            log("FirebaseMessaging.instance.getInitialMessage ${message?.data}");
            if ((message?.data ?? {}).isNotEmpty) {
              context.pushNamed(MyAppRoutes.notificationResponsePage,
                  extra: VisitorFromNotification.fromMap(message?.data ?? {}));
            }
          },
        );

        // 2. This method only call when App in forground it mean app must be opened
        FirebaseMessaging.onMessage.listen(
          (message) {
            log("FirebaseMessaging.onMessage.listen ${message.notification?.title}");
            log("FirebaseMessaging.onMessage.listen ${message.notification?.toMap()}");
            log("message.data11 ${message.data}");
            Fluttertoast.showToast(msg: "FirebaseMessaging.onMessage.listen");

            context.pushNamed(MyAppRoutes.notificationResponsePage,
                extra: VisitorFromNotification.fromMap(message.data));
          },
        );
        // 3. This method only call when App in background and not terminated(not closed)
        FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
            print("+++++++++++++++++On Message Opened App++++++++++++++ ");
            log("FirebaseMessaging.onMessageOpenedApp.listen ${message.data}");
            Fluttertoast.showToast(
                msg: "FirebaseMessaging.onMessageOpenedApp.listen");
            context.pushNamed(MyAppRoutes.notificationResponsePage,
                extra: VisitorFromNotification.fromMap(message.data));
          },
        );
      }
      return () {
        networkSubscription.cancel();
      };
    }, [isConnectedToNetwork]);

    if (isConnectedToNetwork.value) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: GestureDetector(
              onLongPress: () {
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
                                  "Log Out Confirm ?",
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
                                          Colors.deepPurple,
                                        ),
                                      ),
                                      onPressed: () async {
                                        await ref
                                            .read(authServiceProvider)
                                            .signOut()
                                            .then((value) =>
                                                Navigator.pop(context));
                                      },
                                      child: const Text(
                                        "Log Out",
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
                    });
              },
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    "Hello ${userProvider.currentUser!.ownerFirstName}",
                    speed: const Duration(milliseconds: 200),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
                onTap: () {},
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 17,
                      child: GestureDetector(
                        child: const Icon(
                          Icons.notifications_outlined,
                          size: 20,
                        ),
                        onTap: () async {
                          // await NotificationService.sendNotification(
                          //   title: "Test Notification",
                          //   subject: "Test Notification",
                          //   topic: "testingNotificaions",
                          //   fbID:
                          //       "fKXK-BieQkStC5EE9GJPM9:APA91bEHTbcudzc3DbxgVNNjPK0-peVUFc9xC2VGQNJ68rOMnM_HeQlpSSNE5cr8SrrkaMGXFB4qOXLvnGaOCzVf2O7U6LvhnD0FKCTXfidfbAn_HG30T_5PlLweKIKBmsZwMMG18aFO",
                          // );
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      radius: 17,
                      child: Text(userProvider.currentUser!.ownerFirstName
                          .substring(0, 1)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              ref.refresh(carouselDataProvider.future);
              ref.refresh(featuresDataProvider.future);
              ref.refresh(homePageVisitors.future);
            },
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 6,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome to ${userProvider.currentUser!.socName}",
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                carouselData.when(
                    skipLoadingOnRefresh: false,
                    data: (data) {
                      return Column(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                                height: 120,
                                viewportFraction: 0.6,
                                autoPlay: true,
                                autoPlayInterval: const Duration(
                                  seconds: 6,
                                ),
                                onPageChanged: (index, reason) {
                                  currentCarouselIndex.value = index;
                                }),
                            carouselController: carouselController,
                            items: data.map((item) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HeroPhotoViewRouteWrapper(
                                                imageProvider: NetworkImage(
                                                    item.bannerImage),
                                              )));
                                },
                                child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF9CC5FF),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          10,
                                        ),
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: FastCachedImage(
                                        url: item.bannerImage,
                                        fit: BoxFit.fill,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(Icons.error);
                                        },
                                      ),
                                    )),
                              );
                            }).toList(),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: data.asMap().entries.map((entry) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1.7),
                                child: Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: currentCarouselIndex.value == entry.key
                                      ? Colors.grey[600]
                                      : Colors.grey[300],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      );
                    },
                    loading: () => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Shimming(
                            height: 120,
                            width: size.width,
                          ),
                        ),
                    error: (e, s) {
                      return Text(e.toString());
                    }),
                // end fo carousel
                const SizedBox(
                  height: 5,
                ),
                // Starting Services
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Services",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "See all",
                        style:
                            TextStyle(color: Color.fromARGB(255, 0, 76, 137)),
                      ),
                    ],
                  ),
                ),
                featureData.when(
                    skipLoadingOnRefresh: false,
                    data: (data) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: data.sublist(0, 4).map((item) {
                                return Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      context.pushNamed(item.featureRoute);
                                    },
                                    child: HomePageCard(
                                      cardColor: Color(int.parse(
                                          "0xff${item.featureColor}")),
                                      featureText: item.featureName,
                                      image: NetworkImage(item.featureIcon),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: data
                                  .sublist(4, 8)
                                  .map((item) => Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            context
                                                .pushNamed(item.featureRoute);
                                          },
                                          child: HomePageCard(
                                            cardColor: Color(
                                              int.parse(
                                                  "0xff${item.featureColor}"),
                                            ),
                                            featureText: item.featureName,
                                            image:
                                                NetworkImage(item.featureIcon),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ],
                      );
                    },
                    loading: () => Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.filled(4, 0, growable: true)
                                      .sublist(0, 4)
                                      .map((item) => const Column(
                                            children: [
                                              Shimming(
                                                height: 80,
                                                width: 80,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Shimming(
                                                height: 10,
                                                width: 60,
                                              ),
                                            ],
                                          ))
                                      .toList(),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.filled(10, 0, growable: true)
                                      .sublist(3, 7)
                                      .map((item) => const Column(
                                            children: [
                                              Shimming(
                                                height: 80,
                                                width: 80,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Shimming(
                                                height: 10,
                                                width: 60,
                                              ),
                                            ],
                                          ))
                                      .toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                    error: (e, s) {
                      return Text(e.toString());
                    }),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Recent Visitors",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const VisitorsTabsPage()),
                          );
                        },
                        child: const Text(
                          "See all",
                          style:
                              TextStyle(color: Color.fromARGB(255, 0, 76, 137)),
                        ),
                      ),
                    ],
                  ),
                ),
                visitorsData.when(
                    skipLoadingOnRefresh: false,
                    data: (data) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        child: Column(
                          children: data
                              .map((item) => Card(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 5,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              HeroPhotoViewRouteWrapper(
                                                            imageProvider:
                                                                NetworkImage(
                                                              item.visitorImage,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(
                                                          50,
                                                        ),
                                                      ),
                                                      child: Image(
                                                        image: NetworkImage(
                                                          item.visitorImage,
                                                        ),
                                                        height: 70,
                                                        width: 70,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const VerticalDivider(
                                              width: 15,
                                              thickness: 0.5,
                                              color: Colors.grey,
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: GestureDetector(
                                                onTap: () {
                                                  quickDialogue(
                                                    callBack: () {},
                                                    subtitle:
                                                        item.visitorStatus ??
                                                            "",
                                                    title: item.visitorName,
                                                    visitormobile:
                                                        item.visitorMobile,
                                                    visitorType:
                                                        item.visitorType,
                                                    context: context,
                                                    inTime:
                                                        item.visitorEnterTime ??
                                                            "",
                                                    inDate:
                                                        item.visitorEnterDate ??
                                                            "",
                                                    outTime:
                                                        item.visitorExitTime ??
                                                            "Still Inside",
                                                    outDate:
                                                        item.visitorExitDate ??
                                                            "Still Inside",
                                                    allowedBy:
                                                        item.visitorAppRejBy ??
                                                            "",
                                                    visitorTypeDetail:
                                                        item.visitorTypeDetail,
                                                    phoneNo: item.visitorMobile,
                                                    image: NetworkImage(
                                                      item.visitorImage,
                                                    ),
                                                  );
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 7,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            item.visitorName,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                              vertical: 1,
                                                              horizontal: 5,
                                                            ),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: item.visitorStatus ==
                                                                      "Inside"
                                                                  ? const Color(
                                                                      0xffEA7255)
                                                                  : const Color(
                                                                      0xff43E36A),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10,
                                                              ),
                                                            ),
                                                            child: Text(
                                                              item.visitorStatus!
                                                                  .toUpperCase(),
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(3),
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .blue
                                                                        .shade200,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      5,
                                                                    )),
                                                            child: Text(
                                                              item.visitorType,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Colors
                                                                        .purple
                                                                        .shade200,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      5,
                                                                    )),
                                                            child: Text(
                                                              item.visitorTypeDetail,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .check_circle_outline,
                                                            size: 12,
                                                            color: Colors
                                                                .grey[600],
                                                          ),
                                                          const SizedBox(
                                                            width: 2,
                                                          ),
                                                          Text(
                                                            "Allowed by ${item.visitorAppRejBy}",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey[600],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .login_outlined,
                                                            size: 12,
                                                            color: Colors
                                                                .grey[600],
                                                          ),
                                                          const SizedBox(
                                                            width: 2,
                                                          ),
                                                          Text(
                                                            "${item.visitorEnterTime!.toUpperCase()}, ",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey[600],
                                                            ),
                                                          ),
                                                          Text(
                                                            item.visitorEnterDate ??
                                                                "",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey[600],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          RotatedBox(
                                                            quarterTurns: 2,
                                                            child: Icon(
                                                              Icons.logout,
                                                              size: 12,
                                                              color: Colors
                                                                  .grey[600],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 2,
                                                          ),
                                                          Text(
                                                            item.visitorExitTime
                                                                    .isEmpty
                                                                ? "Still Inside"
                                                                : "${item.visitorExitTime.toUpperCase()}, ",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey[600],
                                                            ),
                                                          ),
                                                          Text(
                                                            item.visitorExitDate!
                                                                    .isEmpty
                                                                ? ""
                                                                : "${item.visitorExitDate}",
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .grey[600],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      );
                    },
                    loading: () => const Column(
                          children: [
                            Card(
                              margin: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 7,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircleSkeleton(
                                              size: 70,
                                            ),
                                          ],
                                        ),
                                      ),
                                      VerticalDivider(
                                        width: 15,
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Shimming(
                                                    height: 20,
                                                    width: 170,
                                                  ),
                                                  Shimming(
                                                    height: 10,
                                                    width: 40,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Shimming(
                                                height: 15,
                                                width: 150,
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Shimming(
                                                height: 15,
                                                width: 150,
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Shimming(
                                                height: 15,
                                                width: 150,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              margin: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 7,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircleSkeleton(
                                              size: 70,
                                            ),
                                          ],
                                        ),
                                      ),
                                      VerticalDivider(
                                        width: 15,
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Shimming(
                                                    height: 20,
                                                    width: 170,
                                                  ),
                                                  Shimming(
                                                    height: 10,
                                                    width: 40,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Shimming(
                                                height: 15,
                                                width: 150,
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Shimming(
                                                height: 15,
                                                width: 150,
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Shimming(
                                                height: 15,
                                                width: 150,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Card(
                              margin: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 7,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircleSkeleton(
                                              size: 70,
                                            ),
                                          ],
                                        ),
                                      ),
                                      VerticalDivider(
                                        width: 15,
                                        thickness: 1,
                                        color: Colors.grey,
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Shimming(
                                                    height: 20,
                                                    width: 170,
                                                  ),
                                                  Shimming(
                                                    height: 10,
                                                    width: 40,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Shimming(
                                                height: 15,
                                                width: 150,
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Shimming(
                                                height: 15,
                                                width: 150,
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              Shimming(
                                                height: 15,
                                                width: 150,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                    error: (e, s) {
                      return Text(e.toString());
                    }),
              ],
            ),
          ),
          bottomNavigationBar: NavigationBar(
            height: 60,
            onDestinationSelected: (value) {
              selectedIndex.value = value;
            },
            selectedIndex: selectedIndex.value,
            destinations: const [
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.home,
                ),
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.person,
                ),
                icon: Icon(
                  Icons.person_outline,
                ),
                label: 'Activities',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.emergency,
                ),
                icon: Icon(
                  Icons.emergency_outlined,
                ),
                label: 'Emergency',
              ),
              NavigationDestination(
                selectedIcon: Icon(
                  Icons.settings,
                ),
                icon: Icon(
                  Icons.settings_outlined,
                ),
                label: 'Settings',
              ),
            ],
          ));
    } else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: GestureDetector(
            onLongPress: () {
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
                              "Log Out Confirm ?",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      Colors.deepPurple,
                                    ),
                                  ),
                                  onPressed: () async {
                                    await ref
                                        .read(authServiceProvider)
                                        .signOut()
                                        .then(
                                            (value) => Navigator.pop(context));
                                  },
                                  child: const Text(
                                    "Log Out",
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
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  "Hello ${userProvider.currentUser!.ownerFirstName}",
                  speed: const Duration(milliseconds: 200),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
              onTap: () {},
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 17,
                    child: GestureDetector(
                      child: const Icon(
                        Icons.notifications_outlined,
                        size: 20,
                      ),
                      onTap: () async {
                        print(await FirebaseMessaging.instance.getToken());
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 17,
                    child: Text(userProvider.currentUser!.ownerFirstName
                        .substring(0, 1)),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  child: Lottie.asset("assets/no_connection.json"),
                ),
              ),
              const SizedBox(height: 10),
              const CircularProgressIndicator(),
            ],
          ),
        ),
        bottomNavigationBar: NavigationBar(
          height: 60,
          onDestinationSelected: (value) {
            selectedIndex.value = value;
          },
          selectedIndex: selectedIndex.value,
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(
                Icons.home,
              ),
              icon: Icon(
                Icons.home_outlined,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.person,
              ),
              icon: Icon(
                Icons.person_outline,
              ),
              label: 'Activities',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.emergency,
              ),
              icon: Icon(
                Icons.emergency_outlined,
              ),
              label: 'Emergency',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                Icons.settings,
              ),
              icon: Icon(
                Icons.settings_outlined,
              ),
              label: 'Settings',
            ),
          ],
        ),
      );
    }
  }
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
  showGeneralDialog(
    transitionDuration: const Duration(milliseconds: 400),
    barrierDismissible: true,
    barrierLabel: "true",
    barrierColor: Colors.black.withOpacity(0.85),
    context: context,
    pageBuilder: (context, anime1, anime2) {
      return Container();
    },
    transitionBuilder: (context, a1, a2, widget) {
      return ScaleTransition(
        scale: Tween(begin: 0.5, end: 1.0).animate(a1),
        child: FadeTransition(
          opacity: Tween(begin: 0.5, end: 1.0).animate(a1),
          child: Theme(
            data:
                Theme.of(context).copyWith(dialogBackgroundColor: Colors.white),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HeroPhotoViewRouteWrapper(imageProvider: image),
                          ),
                        );
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
                  const SizedBox(height: 5),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 3,
                        ),
                        decoration: BoxDecoration(
                          color: subtitle == "Inside"
                              ? const Color(0xffEA7255)
                              : Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                        ),
                        child: Text(
                          subtitle.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        phoneNo,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.logout,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${inTime.toUpperCase()}, ",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          inDate,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const RotatedBox(
                          quarterTurns: 2,
                          child: Icon(
                            Icons.logout,
                            size: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                            outTime.isEmpty
                                ? "Still Inside"
                                : "${outTime.toUpperCase()}, ",
                            style: const TextStyle(
                              fontSize: 16,
                            )),
                        Text(outDate,
                            style: const TextStyle(
                              fontSize: 16,
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.person_outline,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text("Allowed by $allowedBy",
                            style: const TextStyle(
                              fontSize: 16,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.store,
                          size: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(visitorTypeDetail,
                            style: const TextStyle(
                              fontSize: 16,
                            )),
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
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: const BoxDecoration(
                        color: Color(0xffFF6663),
                        // gradient: gradient.LinearGradient(
                        //   colors: [
                        //     Color(0xffFF6663),
                        //     Color(0xff0083B0),
                        //   ],
                        //   begin: Alignment.topCenter, //begin of the gradient color
                        //   end: Alignment.bottomCenter, //end of the gradient color
                        //   //stops for individual color
                        //   //set the stops number equal to numbers of color
                        // ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            20,
                          ),
                          bottomRight: Radius.circular(
                            20,
                          ),
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                      ),
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
