import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:secure_gates_project/entities/visitor.dart';
import 'package:secure_gates_project/widgets/loading_widgets.dart';
import 'package:secure_gates_project/widgets/visitor_card_widget.dart';
import 'package:secure_gates_project/widgets/visitor_card_widget_second.dart';

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
      {'soc': 'CP', 'visitor_is_valid': '1', 'visitor_flat_no': '306'});
  final response = await Dio().post(
    "https://gatesadmin.000webhostapp.com/get_inside_visitors.php",
    data: data,
  );

  ref.keepAlive();

  if (response.data["code"] == "100") {
    final results = List<Map<String, dynamic>>.from(response.data["data"]);
    List<Visitor> visitors = results
        .map((cardData) => Visitor.fromMap(cardData))
        .toList(growable: false);

    return visitors;
  } else {
    return [];
  }
});

final wrongVisitorsProvider =
    FutureProvider.autoDispose<List<Visitor>>((ref) async {
  final data = FormData.fromMap({'soc': 'CP', 'flat_no': '360'});
  final response = await Dio().post(
    "https://gatesadmin.000webhostapp.com/get_wrong_visitors.php",
    data: data,
  );

  if (response.data["code"] == "100") {
    final results = List<Map<String, dynamic>>.from(response.data["data"]);
    List<Visitor> visitors = results
        .map((cardData) => Visitor.fromMap(cardData))
        .toList(growable: false);

    return visitors;
  } else {
    return [];
  }
});

//  checkForFilter (){

// }

class VisitorsTabsPage extends HookConsumerWidget {
  const VisitorsTabsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allVisitors = ref.watch(allVisitorProvider);
    final currentVisitors = ref.watch(currentVisitorsProvider);
    final wrongVisitors = ref.watch(wrongVisitorsProvider);
    final tabController = useTabController(initialLength: 4);
    final selectedFilter = useState("All");
    final currentTabName = useState("Current");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFF6663),
        bottom: TabBar(
          controller: tabController,
          labelColor: Colors.white,
          onTap: (value) {
            switch (value) {
              case 0:
                currentTabName.value = "Current";
                break;
              case 1:
                currentTabName.value = "Past";
                break;
              case 2:
                currentTabName.value = "Wrong";
                break;
              case 3:
                currentTabName.value = "Denied";
                break;
              default:
                currentTabName.value = "Current";
            }
          },
          isScrollable: false,
          tabs: const [
            Tab(
              text: "Current",
            ),
            Tab(
              text: "Past",
            ),
            Tab(
              text: "Wrong",
            ),
            Tab(
              text: "Denied",
            ),
          ],
        ),
        title: Text(
          "${currentTabName.value} Visitors",
          style: const TextStyle(color: Colors.white),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: const Icon(
        //         Icons.search,
        //       ))
        // ],
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Filters",
                          style: TextStyle(fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 20,
                                        ),
                                        height: 250,
                                        child: GridView.count(
                                          crossAxisCount: 4,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                selectedFilter.value =
                                                    "Delivery";
                                                context.pop();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      color: Colors.amber,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: const Icon(
                                                        Icons.electric_bike),
                                                  ),
                                                  const Text("Delivery")
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                selectedFilter.value = "Cab";
                                                context.pop();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      color: Colors.redAccent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: const Icon(
                                                        Icons.directions_car),
                                                  ),
                                                  const Text("Cab")
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                selectedFilter.value = "Guest";
                                                context.pop();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: const Icon(Icons
                                                        .person_2_outlined),
                                                  ),
                                                  const Text("Guest")
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                selectedFilter.value =
                                                    "Services";
                                                context.pop();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      color: Colors.cyanAccent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child:
                                                        const Icon(Icons.list),
                                                  ),
                                                  const Text("Sercices")
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                selectedFilter.value = "Parcel";
                                                context.pop();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      color: Colors.greenAccent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: const Icon(Icons
                                                        .inventory_2_outlined),
                                                  ),
                                                  const Text("Parcel")
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                selectedFilter.value = "Others";
                                                context.pop();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      color: Colors.orange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: const Icon(
                                                        Icons.summarize),
                                                  ),
                                                  const Text("Others")
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.tune),
                                      const SizedBox(width: 10),
                                      Text(
                                        selectedFilter.value,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(width: 5),
                                      const Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            GestureDetector(
                              onTap: () {
                                selectedFilter.value = "All";
                              },
                              child: const Icon(
                                Icons.close,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                currentVisitors.when(
                    skipLoadingOnRefresh: false,
                    data: (data) {
                      if (data.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              // const Text("This is an empty list"),
                              Lottie.asset("assets/mt_list.json"),
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: selectedFilter.value == "All"
                                ? data.map((item) {
                                    return GestureDetector(
                                      onTap: () {
                                        quickDialogue(
                                          callBack: () {},
                                          subtitle: item.visitorStatus,
                                          title: item.visitorName,
                                          visitorType: item.visitorType,
                                          context: context,
                                          visitormobile: item.visitorMobile,
                                          inTime: item.visitorEnterTime,
                                          inDate: item.visitorEnterDate,
                                          outTime: item.visitorEnterTime,
                                          outDate: item.visitorExitDate ??
                                              "Still Inside",
                                          allowedBy: item.visitorAppRejBy,
                                          visitorTypeDetail:
                                              item.visitorTypeDetail,
                                          phoneNo: item.visitorMobile,
                                          image: NetworkImage(
                                            item.visitorImage,
                                          ),
                                        );
                                      },
                                      child: VisitorCard(
                                        visitormobile: item.visitorMobile,
                                        visitorId: item.visitorId,
                                        visitorApproveBy: item.visitorAppRejBy,
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
                                        visitorTypeDetail:
                                            item.visitorTypeDetail,
                                      ),
                                    );
                                  }).toList()
                                : data
                                    .where((e) =>
                                        e.visitorType == selectedFilter.value)
                                    .map((item) {
                                    return GestureDetector(
                                      onTap: () {
                                        quickDialogue(
                                          callBack: () {},
                                          subtitle: item.visitorStatus,
                                          title: item.visitorName,
                                          visitorType: item.visitorType,
                                          context: context,
                                          visitormobile: item.visitorMobile,
                                          inTime: item.visitorEnterTime,
                                          inDate: item.visitorEnterDate,
                                          outTime: item.visitorEnterTime,
                                          outDate: item.visitorExitDate ??
                                              "Still Inside",
                                          allowedBy: item.visitorAppRejBy,
                                          visitorTypeDetail:
                                              item.visitorTypeDetail,
                                          phoneNo: item.visitorMobile,
                                          image: NetworkImage(
                                            item.visitorImage,
                                          ),
                                        );
                                      },
                                      child: VisitorCard(
                                        visitormobile: item.visitorMobile,
                                        visitorId: item.visitorId,
                                        visitorApproveBy: item.visitorAppRejBy,
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
                                        visitorTypeDetail:
                                            item.visitorTypeDetail,
                                      ),
                                    );
                                  }).toList(),
                          ),
                        );
                      }
                    },
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
          RefreshIndicator(
            onRefresh: () async {
              ref.refresh(allVisitorProvider.future);
            },
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Past Visitors",
                          style: TextStyle(fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 20,
                                        ),
                                        height: 250,
                                        child: GridView.count(
                                          crossAxisCount: 4,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                selectedFilter.value =
                                                    "Delivery";
                                                context.pop();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      color: Colors.amber,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: const Icon(
                                                        Icons.electric_bike),
                                                  ),
                                                  const Text("Delivery")
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                selectedFilter.value = "Cab";
                                                context.pop();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      color: Colors.redAccent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: const Icon(
                                                        Icons.directions_car),
                                                  ),
                                                  const Text("Cab")
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                selectedFilter.value = "Guest";
                                                context.pop();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: const Icon(Icons
                                                        .person_2_outlined),
                                                  ),
                                                  const Text("Guest")
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                selectedFilter.value =
                                                    "Services";
                                                context.pop();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      color: Colors.cyanAccent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child:
                                                        const Icon(Icons.list),
                                                  ),
                                                  const Text("Sercices")
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                selectedFilter.value = "Parcel";
                                                context.pop();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      color: Colors.greenAccent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: const Icon(Icons
                                                        .inventory_2_outlined),
                                                  ),
                                                  const Text("Parcel")
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                selectedFilter.value = "Others";
                                                context.pop();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      color: Colors.orange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: const Icon(
                                                        Icons.summarize),
                                                  ),
                                                  const Text("Others")
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.tune),
                                      const SizedBox(width: 10),
                                      Text(
                                        selectedFilter.value,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(width: 5),
                                      const Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            const Icon(
                              Icons.refresh,
                              color: Colors.blueGrey,
                            ),
                          ],
                        ),
                      ],
                    ),
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
                                  .map(
                                    (item) => VisitorCardSecond(
                                      isDenied: false,
                                      visitorId: item.visitorId,
                                      visitorApproveBy: item.visitorAppRejBy,
                                      visitorEnterTime: item.visitorEnterTime,
                                      visitorExitDate: item.visitorExitDate!,
                                      visitorExitTime:
                                          item.visitorExitTime!.isEmpty
                                              ? "Still Inside"
                                              : item.visitorExitTime!,
                                      visitorImage: item.visitorImage,
                                      visitorName: item.visitorName,
                                      visitorEnterDate: item.visitorEnterDate,
                                      visitorStatus: item.visitorStatus,
                                      visitorType: item.visitorType,
                                      visitorTypeDetail: item.visitorTypeDetail,
                                    ),
                                  )
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
          RefreshIndicator(
            onRefresh: () async {
              ref.refresh(wrongVisitorsProvider.future);
            },
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Wrong Visitors",
                          style: TextStyle(fontSize: 20),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding:
                                          MediaQuery.of(context).viewInsets,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 20,
                                        ),
                                        height: 250,
                                        child: GridView.count(
                                          crossAxisCount: 4,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                selectedFilter.value =
                                                    "Delivery";
                                                context.pop();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      color: Colors.amber,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: const Icon(
                                                        Icons.electric_bike),
                                                  ),
                                                  const Text("Delivery")
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                selectedFilter.value = "Cab";
                                                context.pop();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      color: Colors.redAccent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: const Icon(
                                                        Icons.directions_car),
                                                  ),
                                                  const Text("Cab")
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                selectedFilter.value = "Guest";
                                                context.pop();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: const Icon(Icons
                                                        .person_2_outlined),
                                                  ),
                                                  const Text("Guest")
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                selectedFilter.value =
                                                    "Services";
                                                context.pop();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      color: Colors.cyanAccent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child:
                                                        const Icon(Icons.list),
                                                  ),
                                                  const Text("Sercices")
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                selectedFilter.value = "Parcel";
                                                context.pop();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      color: Colors.greenAccent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: const Icon(Icons
                                                        .inventory_2_outlined),
                                                  ),
                                                  const Text("Parcel")
                                                ],
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                selectedFilter.value = "Others";
                                                context.pop();
                                              },
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    decoration: BoxDecoration(
                                                      color: Colors.orange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                    ),
                                                    child: const Icon(
                                                        Icons.summarize),
                                                  ),
                                                  const Text("Others")
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 5),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.tune),
                                      const SizedBox(width: 10),
                                      Text(
                                        selectedFilter.value,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      const SizedBox(width: 5),
                                      const Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 15),
                            const Icon(
                              Icons.refresh,
                              color: Colors.blueGrey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                wrongVisitors.when(
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
                                  .map(
                                    (item) => VisitorCardSecond(
                                      isDenied: false,
                                      visitorId: item.visitorId,
                                      visitorApproveBy: item.visitorAppRejBy,
                                      visitorEnterTime: item.visitorEnterTime,
                                      visitorExitDate: item.visitorExitDate!,
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
                                    ),
                                  )
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 20,
                                    ),
                                    height: 250,
                                    child: GridView.count(
                                      crossAxisCount: 4,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            selectedFilter.value = "Delivery";
                                            context.pop();
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                  color: Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: const Icon(
                                                    Icons.electric_bike),
                                              ),
                                              const Text("Delivery")
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            selectedFilter.value = "Cab";
                                            context.pop();
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                  color: Colors.redAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: const Icon(
                                                    Icons.directions_car),
                                              ),
                                              const Text("Cab")
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            selectedFilter.value = "Guest";
                                            context.pop();
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: const Icon(
                                                    Icons.person_2_outlined),
                                              ),
                                              const Text("Guest")
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            selectedFilter.value = "Services";
                                            context.pop();
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                  color: Colors.cyanAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: const Icon(Icons.list),
                                              ),
                                              const Text("Sercices")
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            selectedFilter.value = "Parcel";
                                            context.pop();
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                  color: Colors.greenAccent,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: const Icon(
                                                    Icons.inventory_2_outlined),
                                              ),
                                              const Text("Parcel")
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            selectedFilter.value = "Others";
                                            context.pop();
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child:
                                                    const Icon(Icons.summarize),
                                              ),
                                              const Text("Others")
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 5),
                              child: Row(
                                children: [
                                  const Icon(Icons.tune),
                                  const SizedBox(width: 10),
                                  Text(
                                    selectedFilter.value,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        const Icon(
                          Icons.refresh,
                          color: Colors.blueGrey,
                        ),
                      ],
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
                              .map(
                                (item) => VisitorCardSecond(
                                  isDenied: true,
                                  visitorExitDate: item.visitorExitDate!,
                                  visitorId: item.visitorId,
                                  visitorApproveBy: item.visitorAppRejBy,
                                  visitorEnterTime: item.visitorEnterTime,
                                  visitorExitTime: item.visitorExitTime!.isEmpty
                                      ? "Still Inside"
                                      : "Exited at${item.visitorExitTime!}",
                                  visitorImage: item.visitorImage,
                                  visitorName: item.visitorName,
                                  visitorEnterDate: item.visitorEnterDate,
                                  visitorStatus: item.visitorStatus,
                                  visitorType: item.visitorType,
                                  visitorTypeDetail: item.visitorTypeDetail,
                                ),
                              )
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
        ],
      ),
    );
  }
}
