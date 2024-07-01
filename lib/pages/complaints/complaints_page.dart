import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:secure_gates_project/widgets/rounded_button.dart';
import 'package:secure_gates_project/widgets/rounded_text_field_second.dart';

final List<String> currentVisitorsOptions = [
  "Guest",
  "Delivery Boy",
  "Service Boy",
  "Cab",
  "Other",
];

class ComplaintsPage extends HookConsumerWidget {
  const ComplaintsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final subjectController = useTextEditingController();
    final textAreaController = useTextEditingController();
    final selectedFilter = useState("Option 2");

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Complaints",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey
                            .withOpacity(0.6), // Slightly darker shadow color
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: const Offset(
                            0, 5), // Offset in (dx, dy) from top-left
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Enter your complaint here",
                          style: TextStyle(fontSize: 28),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // RoundedSquareButton(
                        //     icon: Icons.image,
                        //     onPress: () async {
                        //       // if (!Platform.isIOS) {
                        //       //   final pickedFile = await pickNewImage(false);
                        //       //   imagePath.value = pickedFile.path;
                        //       // } else {
                        //       //   Fluttertoast.showToast(
                        //       //       msg: "This is a simulator",
                        //       //       toastLength: Toast.LENGTH_SHORT,
                        //       //       gravity: ToastGravity.BOTTOM,
                        //       //       timeInSecForIosWeb: 1,
                        //       //       fontSize: 16.0);
                        //       // }
                        //     }),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Fill your complaint:",
                          style: TextStyle(fontSize: 25),
                        ),
                        RoundedInputFieldSecond(
                          hintText: "Complaint Subject",
                          isMobile: false,
                          leadingIcon: Iconsax.activity,
                          fieldController: subjectController,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: DropdownButton<String>(
                                    value: selectedFilter.value,
                                    onChanged: (newValue) {
                                      selectedFilter.value = newValue!;
                                    },
                                    items: const [
                                      DropdownMenuItem(
                                        value: 'Option 1',
                                        child: Text('Option 1'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Option 2',
                                        child: Text('Option 2'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Option 3',
                                        child: Text('Option 3'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: textAreaController,
                          maxLines: 10,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              labelText: "Describe your complaint",
                              labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300, width: 2),
                                  borderRadius: BorderRadius.circular(10)),
                              floatingLabelStyle: const TextStyle(
                                  color: Color(0xffFF6663), fontSize: 18),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0xffFF6663), width: 1.5),
                                  borderRadius: BorderRadius.circular(10))),
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: RoundedButton(
                                onPress: () async {
                                  //   try {
                                  //     final formData = FormData.fromMap({
                                  //       "Visitor_Type": "Guest",
                                  //       "Visitor_Name":
                                  //           nameTextController.text.trim(),
                                  //       "Visitor_Mobile":
                                  //           mobileTextController.text.trim(),
                                  //       "Visitor_Flat_No":
                                  //           flatNumberTextController.text.trim(),
                                  //       "Visitor_Image":
                                  //           ""
                                  //     });
                                  //     final Dio dio = Dio();
                                  //     final userResponse = await dio.post(
                                  //       "${ref.read(generalUrlPathProvider)}/jh_visitors.php",
                                  //       data: formData,
                                  //     );
                                  //     if (userResponse.data["status"] == 1) {
                                  //       await FlutterTts().setLanguage("en-Us");
                                  //       await FlutterTts().setVolume(1.0);
                                  //       await FlutterTts().setSpeechRate(0.5);
                                  //       await FlutterTts().setPitch(1.0);
                                  //       await FlutterTts()
                                  //           .speak("Visitor Enter Successfully");
                                  //       // ignore: use_build_context_synchronously
                                  //       AwesomeDialog(
                                  //         context: context,
                                  //         transitionAnimationDuration:
                                  //             const Duration(milliseconds: 400),
                                  //         dialogType: DialogType.question,
                                  //         animType: AnimType.scale,
                                  //         title: "Visitor Entered Successfully",
                                  //         desc:
                                  //             "Do you want to enter more visitor ?",
                                  //         btnCancelOnPress: () {
                                  //           Navigator.of(context).pop();
                                  //         },
                                  //         btnCancelText: "No",
                                  //         btnOkOnPress: () {
                                  //           nameTextController.clear();
                                  //           flatNumberTextController.clear();
                                  //           mobileTextController.clear();
                                  //         },
                                  //         btnOkText: "Yes",
                                  //       ).show();
                                  //     } else if (userResponse.data["status"] ==
                                  //         0) {
                                  //       Fluttertoast.showToast(
                                  //           msg: "Visitor Enter faied !!!",
                                  //           toastLength: Toast.LENGTH_LONG,
                                  //           gravity: ToastGravity.CENTER,
                                  //           timeInSecForIosWeb: 1,
                                  //           textColor: Colors.white,
                                  //           backgroundColor: Colors.red,
                                  //           fontSize: 30.0);
                                  //       return ErrorHandlers.errorDialog(
                                  //           userResponse.data["status"]);
                                  //     }
                                  //   } catch (e) {
                                  //     throw ErrorHandlers.errorDialog(e);
                                  //   }
                                  // },
                                },
                                buttonChild: const Text("Submit"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
