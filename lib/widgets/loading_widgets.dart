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
            IntrinsicHeight(
              child: Row(
                children: [
                  const Expanded(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Shimming(
                                height: 20,
                                width: 150,
                              ),
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
                                child: const Shimming(
                                  height: 15,
                                  width: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
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
                            child: const Shimming(
                              height: 20,
                              width: 40,
                            ),
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
                              const Shimming(
                                height: 15,
                                width: 80,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 3,
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
                              const Shimming(
                                height: 15,
                                width: 80,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_month_outlined,
                                size: 18,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              const Shimming(
                                height: 15,
                                width: 80,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.refresh_outlined,
                        size: 19,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "Give Feedback",
                        style: TextStyle(
                          fontSize: Responsive.getFontSize(12),
                        ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.cancel_outlined,
                        size: 19,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "Wrong Entry",
                        style: TextStyle(
                          fontSize: Responsive.getFontSize(12),
                        ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.call,
                        size: 19,
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Text(
                        "Call",
                        style: TextStyle(
                          fontSize: Responsive.getFontSize(12),
                        ),
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
