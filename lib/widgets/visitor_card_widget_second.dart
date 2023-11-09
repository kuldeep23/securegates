import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/widgets/responsive_wrap.dart';
import 'package:secure_gates_project/widgets/vertical_divider_widget.dart';

class VisitorCardSecond extends HookConsumerWidget {
  const VisitorCardSecond({
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
    required this.isDenied,
    required this.visitorExitDate,
  });

  final bool isDenied;

  final String visitorImage,
      visitorId,
      visitorName,
      visitorType,
      visitorStatus,
      visitorTypeDetail,
      visitorApproveBy,
      visitorEnterTime,
      visitorEnterDate,
      visitorExitDate,
      visitorExitTime;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(false);

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 5,
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
                          radius: 35,
                          backgroundImage: NetworkImage(
                            visitorImage,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "$visitorTypeDetail, $visitorName",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                child: Text(
                                  visitorStatus.toUpperCase(),
                                  style: GoogleFonts.montserrat(
                                      fontSize: 10, color: Colors.white),
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
                                "$visitorEnterTime - $visitorExitTime",
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
                                "Enter date: $visitorEnterDate",
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
                                "Exit date: $visitorExitDate",
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
