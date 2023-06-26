import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/entities/visitor.dart';

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
final currentVisitors = FutureProvider.autoDispose<List<Visitor>>((ref) async {
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

class VisitorsTabsPage extends HookConsumerWidget {
  const VisitorsTabsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allVisitors = ref.watch(allVisitorProvider);
    final tabController = useTabController(initialLength: 4);

    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: tabController,
          isScrollable: true,
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
        title: const Text("Visitor's Page"),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          allVisitors.when(
              data: (data) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView(
                      children: data
                          .map((item) => Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 10,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 1,
                                                  horizontal: 5,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff6CB4EE),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10,
                                                  ),
                                                ),
                                                child: Text(
                                                  item.visitorStatus
                                                      .toUpperCase(),
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundImage: NetworkImage(
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
                                            padding: const EdgeInsets.symmetric(
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
                                                    fontWeight: FontWeight.bold,
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
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  item.visitorTypeDetail,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
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
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) {
                return Text(e.toString());
              }),
          allVisitors.when(
              data: (data) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView(
                      children: data
                          .map((item) => Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 10,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 1,
                                                  horizontal: 5,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff6CB4EE),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10,
                                                  ),
                                                ),
                                                child: Text(
                                                  item.visitorStatus
                                                      .toUpperCase(),
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundImage: NetworkImage(
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
                                            padding: const EdgeInsets.symmetric(
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
                                                    fontWeight: FontWeight.bold,
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
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  item.visitorTypeDetail,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
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
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) {
                return Text(e.toString());
              }),
          allVisitors.when(
              data: (data) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView(
                      children: data
                          .map((item) => Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 10,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 1,
                                                  horizontal: 5,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff6CB4EE),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10,
                                                  ),
                                                ),
                                                child: Text(
                                                  item.visitorStatus
                                                      .toUpperCase(),
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundImage: NetworkImage(
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
                                            padding: const EdgeInsets.symmetric(
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
                                                    fontWeight: FontWeight.bold,
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
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  item.visitorTypeDetail,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
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
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) {
                return Text(e.toString());
              }),
          allVisitors.when(
              data: (data) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView(
                      children: data
                          .map((item) => Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 10,
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 1,
                                                  horizontal: 5,
                                                ),
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xff6CB4EE),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    10,
                                                  ),
                                                ),
                                                child: Text(
                                                  item.visitorStatus
                                                      .toUpperCase(),
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              CircleAvatar(
                                                radius: 25,
                                                backgroundImage: NetworkImage(
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
                                            padding: const EdgeInsets.symmetric(
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
                                                    fontWeight: FontWeight.bold,
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
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  item.visitorTypeDetail,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
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
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) {
                return Text(e.toString());
              }),
        ],
      ),
    );
  }
}
