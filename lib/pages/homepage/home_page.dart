import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rive/rive.dart';
import 'package:secure_gates_project/controller/user_controller.dart';
import 'package:secure_gates_project/entities/carousel_item.dart';
import 'package:secure_gates_project/entities/home_page_card_item.dart';
import 'package:secure_gates_project/entities/visitor.dart';
import 'package:secure_gates_project/services/auth_service.dart';
import 'package:secure_gates_project/services/dashboard_data_service.dart';
import 'package:secure_gates_project/widgets/home_page_card.dart';
import 'package:secure_gates_project/widgets/photo_view_wrapper.dart';
import 'package:secure_gates_project/widgets/skelton_widget.dart';
import 'package:flutter/src/painting/gradient.dart' as gradient;
import 'package:url_launcher/url_launcher.dart';

import '../visitors/visitors_tabs_page.dart';

final carouselDataProvider =
    FutureProvider.autoDispose<List<CarouselItem>>((ref) async {
  final data = ref.watch(dashboardServiceProvider);
  final items = data.getCarouselItems();

  return items;
});

final featuresDataProvider =
    FutureProvider.autoDispose<List<HomePageCardItem>>((ref) async {
  final data = ref.watch(dashboardServiceProvider);

  final cards = data.getHomePageCards();

  return cards;
});

final homePageVisitors = FutureProvider.autoDispose<List<Visitor>>((ref) async {
  final data = ref.watch(dashboardServiceProvider);
  final visitors = data.getLastThreeVisitors();

  return visitors;
});

late SMIBool? isMenuOpenInput;

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

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90,
            width: size.width,
            decoration: const BoxDecoration(
              color: Color(0xFF7553F6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 10),
                  child: GestureDetector(
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
                                                  MaterialStateProperty.all(
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
                          userProvider.currentUser!.ownerName,
                          speed: const Duration(milliseconds: 200),
                          textStyle: GoogleFonts.montserrat(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                      onTap: () {},
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 17,
                        child: GestureDetector(
                          child: const Icon(
                            Icons.notifications_outlined,
                            size: 20,
                          ),
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CircleAvatar(
                        radius: 17,
                        child: Text(userProvider.currentUser!.ownerName
                            .substring(0, 1)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome to Cenetral Park society, Jhansi",
                    style: GoogleFonts.sourceSansPro(
                      fontSize: 20,
                    )),
              ],
            ),
          ),
          carouselData.when(
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
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
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
                              child: Image.network(
                                item.bannerImage,
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                            ));
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: data.asMap().entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 1.7),
                          child: Icon(
                            Icons.circle,
                            size: 13,
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
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Services",
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          featureData.when(
              data: (data) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: data.sublist(0, 4).map((item) {
                          return Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const VisitorsTabsPage(),
                                  ),
                                );
                              },
                              child: HomePageCard(
                                cardColor: Color(
                                    int.parse("0xff${item.featureColor}")),
                                featureText: item.featureName,
                                image: const AssetImage(
                                  "assets/image_assets/004-visitor.png",
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: data
                            .sublist(3, 7)
                            .map((item) => Expanded(
                                  child: HomePageCard(
                                    cardColor: Color(
                                      int.parse("0xff${item.featureColor}"),
                                    ),
                                    featureText: item.featureName,
                                    image: const AssetImage(
                                        "assets/image_assets/004-visitor.png"),
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
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              horizontal: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Recent Visitors",
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VisitorsTabsPage()),
                    );
                  },
                  child: Text(
                    "See all",
                    style: GoogleFonts.montserrat(
                        color: const Color.fromARGB(255, 0, 76, 137)),
                  ),
                ),
              ],
            ),
          ),
          visitorsData.when(
              data: (data) => Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: data
                            .map((item) => GestureDetector(
                                  onTap: () {
                                    quickDialogue(
                                      callBack: () {},
                                      subtitle: item.visitorStatus,
                                      title: item.visitorName,
                                      visitorType: item.visitorType,
                                      context: context,
                                      inTime: item.visitorEnterTime,
                                      outTime: item.visitorExitTime ??
                                          "Still Inside",
                                      allowedBy: item.visitorApproveBy,
                                      visitorTypeDetail: item.visitorTypeDetail,
                                      phoneNo: item.visitorMobile,
                                      image: NetworkImage(
                                        item.visitorImage,
                                      ),
                                    );
                                  },
                                  child: Card(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 7,
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
                                                  ClipRRect(
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                50)),
                                                    child: Image(
                                                      image: NetworkImage(
                                                        item.visitorImage,
                                                      ),
                                                      height: 70,
                                                      width: 70,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const VerticalDivider(
                                              width: 15,
                                              thickness: 1,
                                              color: Colors.grey,
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                        Text(
                                                          item.visitorType,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                            item.visitorStatus
                                                                .toUpperCase(),
                                                            style: GoogleFonts
                                                                .montserrat(
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Text(
                                                      item.visitorName +
                                                          item.visitorTypeDetail,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        height: 1,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Allowed by ${item.visitorApproveBy}",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey[600],
                                                      ),
                                                    ),
                                                    Text(
                                                      "Entered at ${item.visitorEnterTime}",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey[600],
                                                      ),
                                                    ),
                                                    Text(
                                                      item.visitorExitTime!
                                                              .isEmpty
                                                          ? "Still Inside"
                                                          : "Exit at ${item.visitorExitTime}",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey[600],
                                                      ),
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
                                ))
                            .toList(),
                      ),
                    ),
                  ),
              loading: () => Expanded(
                    child: ListView.builder(
                      itemCount: 3,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return const Card(
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
                                                MainAxisAlignment.spaceBetween,
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
                        );
                      },
                    ),
                  ),
              error: (e, s) {
                return Text(e.toString());
              }),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        height: 60,
        onDestinationSelected: (value) {
          selectedIndex.value = value;
        },
        selectedIndex: selectedIndex.value,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.person),
            icon: Icon(Icons.person_outline),
            label: 'Activities',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.emergency),
            icon: Icon(Icons.emergency_outlined),
            label: 'Emergency',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.settings),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

Future<void> quickDialogue({
  Color dialogueThemeColor = Colors.white,
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
  required String outTime,
  required String allowedBy,
  required String visitorTypeDetail,
  required String phoneNo,
}) async {
  await showAnimatedDialog(
    duration: const Duration(milliseconds: 200),
    barrierDismissible: true,
    animationType: DialogTransitionType.fade,
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        titlePadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Column(
          children: [
            Transform.translate(
              offset: const Offset(0, -45),
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
                borderRadius: const BorderRadius.all(Radius.circular(50)),
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
                subtitle.toUpperCase(),
                style:
                    GoogleFonts.montserrat(fontSize: 10, color: Colors.white),
              ),
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
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
                  Text(inTime),
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
                  Text(outTime),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text("Allowed by $allowedBy"),
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
                  Text(visitorTypeDetail),
                ],
              ),
            ),
            const SizedBox(height: 7),
            InkWell(
              onTap: () async {
                Uri phoneno = Uri.parse('tel:+91$phoneNo');
                // Uri phoneno = Uri.parse('https://flutter.dev');
                if (await canLaunchUrl(phoneno)) {
                  await launchUrl(phoneno);
                } else {
                  print("cannot launch this url");
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  gradient: gradient.LinearGradient(
                    colors: [
                      Color(0xff00B4DB),
                      Color(0xff0083B0),
                    ],
                    begin: Alignment.topCenter, //begin of the gradient color
                    end: Alignment.bottomCenter, //end of the gradient color
                    //stops for individual color
                    //set the stops number equal to numbers of color
                  ),
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
      );
    },
  );
}
