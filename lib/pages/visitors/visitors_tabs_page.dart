import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:secure_gates_project/entities/visitor.dart';
import 'package:secure_gates_project/widgets/loading_widgets.dart';
import 'package:secure_gates_project/widgets/visitor_card_widget.dart';

import '../homepage/home_page.dart';

final allVisitorProvider =
    FutureProvider.autoDispose<List<Visitor>>((ref) async {
  final data = FormData.fromMap(
      {'soc': 'CP', 'visitor_is_valid': '1', 'visitor_flat_no': '360'});

  final response = await Dio().post(
    "https://gatesadmin.000webhostapp.com/get_all_visitors.php",
    data: data,
  );

  final results = List<Map<String, dynamic>>.from(response.data);

  List<Visitor> visitors = results
      .map((cardData) => Visitor.fromMap(cardData))
      .toList(growable: false);

  return visitors;
});

final currentVisitorsProvider =
    FutureProvider.autoDispose<List<Visitor>>((ref) async {
  final data = FormData.fromMap(
      {'soc': 'CP', 'visitor_is_valid': '1', 'visitor_flat_no': '360'});
  final response = await Dio().post(
    "https://gatesadmin.000webhostapp.com/get_inside_visitors.php",
    data: data,
  );

  ref.keepAlive();

  final results = List<Map<String, dynamic>>.from(response.data);

  List<Visitor> visitors = results
      .map((cardData) => Visitor.fromMap(cardData))
      .toList(growable: false);

  return visitors;
});

final wrongVisitorsProvider =
    FutureProvider.autoDispose<List<Visitor>>((ref) async {
  final data = FormData.fromMap({'soc': 'CP', 'flat_no': '360'});
  final response = await Dio().post(
    "https://gatesadmin.000webhostapp.com/get_wrong_visitors.php",
    data: data,
  );

  final results = List<Map<String, dynamic>>.from(response.data);

  List<Visitor> visitors = results
      .map((cardData) => Visitor.fromMap(cardData))
      .toList(growable: false);

  return visitors;
});

final List<String> currentVisitorsOptions = [
  "Guest",
  "Delivery Boy",
  "Service Boy",
  "Cab",
  "Other",
];

class VisitorsTabsPage extends HookConsumerWidget {
  const VisitorsTabsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allVisitors = ref.watch(allVisitorProvider);
    final currentVisitors = ref.watch(currentVisitorsProvider);
    final wrongVisitors = ref.watch(wrongVisitorsProvider);
    final tabController = useTabController(initialLength: 4);
    final selectedFilter = useState("Guest");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFF6663),
        bottom: TabBar(
          controller: tabController,
          labelColor: Colors.white,
          isScrollable: false,
          tabs: const [
            Tab(
              text: "Current",
            ),
            Tab(
              text: "Wrong",
            ),
            Tab(
              text: "Denied",
            ),
            Tab(
              text: "All",
            ),
          ],
        ),
        title: const Text(
          "Visitor's Page",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
              ))
        ],
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          RefreshIndicator(
            onRefresh: () async {
              ref.refresh(currentVisitorsProvider.future);
            },
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Current Visitors ",
                        style: TextStyle(fontSize: 20),
                      ),
                      DropdownButton<String>(
                        underline: const SizedBox(),
                        focusColor: Colors.redAccent,
                        style: const TextStyle(color: Colors.redAccent),
                        value: selectedFilter.value,
                        items: currentVisitorsOptions.map(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (String? val) {
                          selectedFilter.value = val!;
                        },
                      ),
                    ],
                  ),
                ),
                currentVisitors.when(
                    skipLoadingOnRefresh: false,
                    data: (data) => Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
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
                                        inDate: item.visitorEnterDate,
                                        outTime: item.visitorEnterTime,
                                        outDate: item.visitorExitDate ??
                                            "Still Inside",
                                        allowedBy: item.visitorApproveBy,
                                        visitorTypeDetail:
                                            item.visitorTypeDetail,
                                        phoneNo: item.visitorMobile,
                                        image: NetworkImage(
                                          item.visitorImage,
                                        ),
                                      );
                                    },
                                    child: VisitorCard(
                                      visitorApproveBy: item.visitorApproveBy,
                                      visitorEnterTime: item.visitorEnterTime,
                                      visitorExitTime: item
                                              .visitorExitTime!.isEmpty
                                          ? "Still Inside"
                                          : "Exited at${item.visitorExitTime!}",
                                      visitorImage: item.visitorImage,
                                      visitorName: item.visitorName,
                                      visitorEnterDate: item.visitorEnterDate,
                                      visitorStatus: item.visitorStatus,
                                      visitorType: item.visitorType,
                                      visitorTypeDetail: item.visitorTypeDetail,
                                    )))
                                .toList(),
                          ),
                        ),
                    loading: () => const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              CurrentVisitorLoadingWidget(),
                              CurrentVisitorLoadingWidget(),
                              CurrentVisitorLoadingWidget(),
                              CurrentVisitorLoadingWidget(),
                            ],
                          ),
                        ),
                    error: (e, s) {
                      return Text(e.toString());
                    }),
              ],
            ),
          ),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Wrong Visitors",
                      style: TextStyle(fontSize: 20),
                    ),
                    DropdownButton<String>(
                      underline: const SizedBox(),
                      focusColor: Colors.redAccent,
                      style: const TextStyle(color: Colors.redAccent),
                      value: selectedFilter.value,
                      items: currentVisitorsOptions.map(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (String? val) {
                        selectedFilter.value = val!;
                      },
                    ),
                  ],
                ),
              ),
              wrongVisitors.when(
                  skipLoadingOnRefresh: false,
                  data: (data) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: data
                              .map((item) => Card(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 10,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 1,
                                                      horizontal: 5,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xff6CB4EE),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      item.visitorStatus
                                                          .toUpperCase(),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  CircleAvatar(
                                                    radius: 25,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      item.visitorImage,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const VerticalDivider(
                                              width: 15,
                                              thickness: 1.5,
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
                                                    Text(
                                                      item.visitorType,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      item.visitorName,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        height: 0.8,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      item.visitorTypeDetail,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Allowed by ${item.visitorApproveBy}",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey[600],
                                                        height: 0.9,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      "Entered at ${item.visitorEnterTime}",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey[600],
                                                        height: 0.9,
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
                                  ))
                              .toList(),
                        ),
                      ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, s) {
                    return Text(e.toString());
                  }),
            ],
          ),
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Denied Visitors",
                      style: TextStyle(fontSize: 20),
                    ),
                    DropdownButton<String>(
                      underline: const SizedBox(),
                      focusColor: Colors.redAccent,
                      style: const TextStyle(color: Colors.redAccent),
                      value: selectedFilter.value,
                      items: currentVisitorsOptions.map(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (String? val) {
                        selectedFilter.value = val!;
                      },
                    ),
                  ],
                ),
              ),
              allVisitors.when(
                  skipLoadingOnRefresh: false,
                  data: (data) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: data
                              .map((item) => Card(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 10,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 1,
                                                      horizontal: 5,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xff6CB4EE),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        10,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      item.visitorStatus
                                                          .toUpperCase(),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  CircleAvatar(
                                                    radius: 25,
                                                    backgroundImage:
                                                        NetworkImage(
                                                      item.visitorImage,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const VerticalDivider(
                                              width: 15,
                                              thickness: 1.5,
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
                                                    Text(
                                                      item.visitorType,
                                                      style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      item.visitorName,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        height: 0.8,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      item.visitorTypeDetail,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      "Allowed by ${item.visitorApproveBy}",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey[600],
                                                        height: 0.9,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      "Entered at ${item.visitorEnterTime}",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.grey[600],
                                                        height: 0.9,
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
                                  ))
                              .toList(),
                        ),
                      ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, s) {
                    return Text(e.toString());
                  }),
            ],
          ),
          RefreshIndicator(
            onRefresh: () async {
              ref.refresh(allVisitorProvider.future);
            },
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "All Visitors",
                        style: TextStyle(fontSize: 20),
                      ),
                      DropdownButton<String>(
                        underline: const SizedBox(),
                        focusColor: Colors.redAccent,
                        style: const TextStyle(color: Colors.redAccent),
                        value: selectedFilter.value,
                        items: currentVisitorsOptions.map(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (String? val) {
                          selectedFilter.value = val!;
                        },
                      ),
                    ],
                  ),
                ),
                allVisitors.when(
                    skipLoadingOnRefresh: false,
                    data: (data) => data.isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                // const Text("This is an empty list"),
                                Lottie.asset("assets/mt_list.json"),
                              ],
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: data
                                  .map((item) => Card(
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                          vertical: 10,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: IntrinsicHeight(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          vertical: 1,
                                                          horizontal: 5,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                              0xff6CB4EE),
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
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      CircleAvatar(
                                                        radius: 25,
                                                        backgroundImage:
                                                            NetworkImage(
                                                          item.visitorImage,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const VerticalDivider(
                                                  width: 15,
                                                  thickness: 1.5,
                                                  color: Colors.grey,
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
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
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          item.visitorName,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            height: 0.8,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          item.visitorTypeDetail,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Allowed by ${item.visitorApproveBy}",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors
                                                                .grey[600],
                                                            height: 0.9,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        Text(
                                                          "Entered at ${item.visitorEnterTime}",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors
                                                                .grey[600],
                                                            height: 0.9,
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
                                      ))
                                  .toList(),
                            ),
                          ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, s) {
                      return Text(e.toString());
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
