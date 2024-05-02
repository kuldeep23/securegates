import 'package:flutter/material.dart';
import 'package:secure_gates_project/widgets/responsive_wrap.dart';
import 'package:secure_gates_project/widgets/skelton_widget.dart';
import 'package:secure_gates_project/widgets/vertical_divider_widget.dart';

class CurrentVisitorLoadingWidget extends StatelessWidget {
  const CurrentVisitorLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
        ),
        child: Column(
          children: [
            const IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleSkeleton(
                          size: 70,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Shimming(
                          height: 15,
                          width: 50,
                        ),
                      ],
                    ),
                  ),
                  VerticalDivider(
                    width: 15,
                    thickness: 1.5,
                    color: Colors.grey,
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Shimming(
                                height: 20,
                                width: 75,
                              ),
                              Shimming(
                                height: 20,
                                width: 75,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Shimming(
                            height: 20,
                            width: 75,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Shimming(
                                height: 15,
                                width: 150,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Shimming(
                                height: 15,
                                width: 150,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Shimming(
                                height: 15,
                                width: 150,
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
                SizedBox(
                  width: Responsive.width(context) * 0.28,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Shimming(
                        height: 20,
                        width: 75,
                      ),
                    ],
                  ),
                ),
                const VerticallyDivider(
                  color: Colors.grey,
                  width: 2,
                ),
                SizedBox(
                  width: Responsive.width(context) * 0.28,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Shimming(
                        height: 20,
                        width: 75,
                      ),
                    ],
                  ),
                ),
                const VerticallyDivider(
                  width: 2,
                  color: Colors.grey,
                ),
                SizedBox(
                  width: Responsive.width(context) * 0.28,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Shimming(
                        height: 20,
                        width: 75,
                      ),
                    ],
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

class RecentVisitorsLoadingWidget extends StatelessWidget {
  const RecentVisitorsLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
  }
}
