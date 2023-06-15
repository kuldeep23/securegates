import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../homepage/home_page.dart';

class VisitorsTabsPage extends HookConsumerWidget {
  const VisitorsTabsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visitorsData = ref.watch(homePageVisitors);

    return DefaultTabController(
      length: 3,
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                surfaceVariant: Colors.transparent,
              ),
        ),
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.transparent,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(12), // Creates border
                color: Colors.greenAccent,
              ), //Chan
              tabs: const [
                Tab(
                  text: "All Visitors",
                ),
                Tab(
                  text: "Wrong Visitors",
                ),
                Tab(
                  text: "Inside Visitors",
                ),
              ],
            ),
            title: const Text("Visitor's Page"),
          ),
          body: TabBarView(
            children: [
              visitorsData.when(
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
              const Icon(Icons.directions_transit, size: 350),
              const Icon(Icons.directions_car, size: 350),
            ],
          ),
        ),
      ),
    );
  }
}
