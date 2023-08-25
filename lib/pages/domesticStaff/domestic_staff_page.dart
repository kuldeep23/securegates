import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/entities/staff_list.dart';

import '../../controller/user_controller.dart';

final staffListProvider =
    FutureProvider.autoDispose<List<StaffList>>((ref) async {
  final socCode = ref.read(userControllerProvider).currentUser!.socCode;

  final data = FormData.fromMap({'soc': socCode});

  final response = await Dio().post(
    "https://gatesadmin.000webhostapp.com/staff_list.php",
    data: data,
  );
  ref.keepAlive();

  final results = List<Map<String, dynamic>>.from(response.data);

  List<StaffList> staffList = results
      .map((staffData) => StaffList.fromMap(staffData))
      .toList(growable: false);

  return staffList;
});

class DomesticStaffPage extends HookConsumerWidget {
  const DomesticStaffPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffList = ref.watch(staffListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Staff List",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          staffList.when(
              data: (data) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Column(
                      children: data
                          .map(
                            (item) => Column(
                              children: [
                                GestureDetector(
                                  onTap: () {},
                                  child: ListTile(
                                    title: Text(item.staffName),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                              ],
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
}
