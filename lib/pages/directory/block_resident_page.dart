import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/controller/user_controller.dart';
import 'package:secure_gates_project/entities/resident_flat.dart';

final residentFlatsProvider = FutureProvider.autoDispose
    .family<List<ResidentFlat>, String>((ref, blockName) async {
  final socCode = ref.read(userControllerProvider).currentUser!.socCode;

  final data = FormData.fromMap({
    'soc_code': socCode,
    'flat_block': blockName,
  });

  final response = await Dio().post(
    "https://gatesadmin.000webhostapp.com/resident_flat.php",
    data: data,
  );
  ref.keepAlive();

  final results = List<Map<String, dynamic>>.from(response.data['data']);

  List<ResidentFlat> flats = results
      .map((residentData) => ResidentFlat.fromMap(residentData))
      .toList(growable: false);

  return flats;
});

class BlockResidentPage extends HookConsumerWidget {
  const BlockResidentPage({
    super.key,
    required this.blockName,
  });

  final String blockName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final residents = ref.watch(residentFlatsProvider(blockName));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Residents of $blockName",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          residents.when(
              data: (data) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Column(
                      children: data
                          // .where((e) => e.flatFloor == "FIRST")
                          .map(
                            (item) => GestureDetector(
                              onTap: () {},
                              child: Card(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 5),
                                      child: Text(
                                        "FLAT ${item.flatNumber}",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    const Divider(),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 5,
                                      ),
                                      child: Row(
                                        children: [
                                          CircleAvatar(),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Type",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                                Text(
                                                  "Resident Name",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  "Profession",
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.chevron_right,
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
