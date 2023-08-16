import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:secure_gates_project/controller/user_controller.dart';
import 'package:secure_gates_project/entities/emergency_contact.dart';
import 'package:secure_gates_project/entities/resisdent_block.dart';
import 'package:secure_gates_project/routes/app_routes_constants.dart';
import 'package:secure_gates_project/services/directory_service.dart';
import 'package:secure_gates_project/widgets/rounded_button.dart';
import 'package:secure_gates_project/widgets/rounded_text_field_second.dart';

final residentBlockProvider =
    FutureProvider.autoDispose<List<ResidentBlock>>((ref) async {
  final socCode = ref.read(userControllerProvider).currentUser!.socCode;

  final data = FormData.fromMap({'soc_code': socCode});

  final response = await Dio().post(
    "https://gatesadmin.000webhostapp.com/resident_block.php",
    data: data,
  );
  ref.keepAlive();

  final results = List<Map<String, dynamic>>.from(response.data['data']);

  List<ResidentBlock> blocks = results
      .map((blockData) => ResidentBlock.fromMap(blockData))
      .toList(growable: false);

  return blocks;
});

final emergencyContactsProvider = FutureProvider.autoDispose
    .family<List<EmergencyDirectoryContact>, String>(
        (ref, directoryType) async {
  final socCode = ref.read(userControllerProvider).currentUser!.socCode;

  final data = FormData.fromMap({
    'soc_code': socCode,
    'directory_type': directoryType,
  });

  final response = await Dio().post(
    "https://gatesadmin.000webhostapp.com/emergency_directory.php",
    data: data,
  );
  ref.keepAlive();

  final results = List<Map<String, dynamic>>.from(response.data['data']);

  List<EmergencyDirectoryContact> emergencyContact = results
      .map((blockData) => EmergencyDirectoryContact.fromMap(blockData))
      .toList(growable: false);

  return emergencyContact;
});

class DirectoryHomePage extends HookConsumerWidget {
  const DirectoryHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 5);
    final blockData = ref.watch(residentBlockProvider);
    final emergencyContacts = ref.watch(emergencyContactsProvider("Emergency"));
    final localDirectoryContacts =
        ref.watch(emergencyContactsProvider("Local"));
    final categoryTextController = useTextEditingController();
    final nameTextController = useTextEditingController();
    final mobileTextController = useTextEditingController();
    final isLoading = useState(false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFF6663),
        bottom: TabBar(
          controller: tabController,
          labelColor: Colors.white,
          isScrollable: true,
          tabs: const [
            Tab(
              text: "Resident",
            ),
            Tab(
              text: "Daily Help",
            ),
            Tab(
              text: "Local Directory",
            ),
            Tab(
              text: "Emergency No.",
            ),
            Tab(
              text: "Committee Members",
            ),
          ],
        ),
        title: const Text(
          "Directory's Page",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Resident Blocks",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              blockData.when(
                  data: (data) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: data
                              .map(
                                (item) => GestureDetector(
                                  onTap: () {
                                    context.pushNamed(
                                      MyAppRoutes.blockResidentPage,
                                      extra: item.flatBlock,
                                    );
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 15,
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.apartment,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              item.flatBlock,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w300,
                                              ),
                                            ),
                                          ),
                                          const Icon(
                                            Icons.chevron_right,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
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
          const Text("data"),
          ListView(
            padding: EdgeInsets.zero,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/local_contacts.jpg",
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "A single contact could help every neightbour",
                      ),
                    ),
                    const Text(
                      "Add contact of local doctors, plumbers, milkmen etc",
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RoundedButton(
                        onPress: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Padding(
                                padding: MediaQuery.of(context).viewInsets,
                                child: isLoading.value == true
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 15,
                                          vertical: 20,
                                        ),
                                        height: 800,
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                IconButton(
                                                  onPressed: () =>
                                                      context.pop(),
                                                  icon: const Icon(Icons.close),
                                                ),
                                                const Text(
                                                  "Add Contact",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            RoundedInputFieldSecond(
                                              hintText:
                                                  "Category - e.g. Doctor, Plumber...",
                                              isMobile: false,
                                              fieldController:
                                                  categoryTextController,
                                            ),
                                            RoundedInputFieldSecond(
                                              hintText: "Name",
                                              isMobile: false,
                                              fieldController:
                                                  nameTextController,
                                            ),
                                            RoundedInputFieldSecond(
                                              hintText: "Mobile No.",
                                              isMobile: true,
                                              fieldController:
                                                  mobileTextController,
                                            ),
                                            const SizedBox(height: 10),
                                            RoundedButton(
                                              onPress: () async {
                                                isLoading.value = true;
                                                final status = await ref
                                                    .read(
                                                        directoryServiceProvider)
                                                    .addToLocalContacts(
                                                        categoryTextController
                                                            .text
                                                            .trim(),
                                                        nameTextController.text
                                                            .trim(),
                                                        mobileTextController
                                                            .text
                                                            .trim(),
                                                        "Local")
                                                    .catchError((e, t) {
                                                  context.pop();
                                                  isLoading.value = false;
                                                  return false;
                                                });
                                                ref.refresh(
                                                    emergencyContactsProvider(
                                                            "Local")
                                                        .future);
                                                // ignore: use_build_context_synchronously
                                                context.pop();
                                                isLoading.value = false;

                                                categoryTextController.text =
                                                    "";
                                                nameTextController.text = "";
                                                mobileTextController.text = "";

                                                if (status) {
                                                  // ignore: use_build_context_synchronously
                                                  Fluttertoast.showToast(
                                                    msg: 'Contact added',
                                                    toastLength:
                                                        Toast.LENGTH_LONG,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.grey[600],
                                                    textColor: Colors.white,
                                                    fontSize: 16.0,
                                                  );
                                                } else {
                                                  Fluttertoast.showToast(
                                                    msg:
                                                        'Contact Already Present',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity:
                                                        ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.grey[600],
                                                    textColor: Colors.white,
                                                    fontSize: 16.0,
                                                  );
                                                }
                                              },
                                              buttonChild: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                ),
                                                child: Text(
                                                  "Done",
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                              );
                            },
                          );
                        },
                        buttonChild: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add,
                            ),
                            Text(
                              "Add",
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              localDirectoryContacts.when(
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
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: data
                                .map(
                                  (item) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Profession",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 15,
                                                vertical: 15,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        item.personName,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                      ),
                                                      Text(
                                                        item.personNumber,
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      const Icon(
                                                        Icons
                                                            .thumb_up_alt_outlined,
                                                      ),
                                                    ],
                                                  ),
                                                  const Icon(
                                                    Icons.phone,
                                                    color: Colors.green,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
          ListView(
            padding: EdgeInsets.zero,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Emergency Contacts",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              emergencyContacts.when(
                  data: (data) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: data
                              .map(
                                (item) => GestureDetector(
                                  onTap: () {},
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 15,
                                        vertical: 15,
                                      ),
                                      child: Row(
                                        children: [
                                          const CircleAvatar(),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.personName,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                                Text(
                                                  item.personNumber,
                                                  style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const Icon(
                                            Icons.phone,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
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
          const Text("data"),
        ],
      ),
    );
  }
}
