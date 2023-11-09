import 'dart:convert';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:secure_gates_project/utils/pick_new_image.dart';

import '../../widgets/rouned_square_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  List data = [];
  String dropdownValue = "Loading...";
  final userType = ["Owner", "Tenant"];
  String userValue = "Owner";

  @override
  void initState() {
    getData() async {
      Future.delayed(const Duration(seconds: 2));
      final res = await http.get(Uri.parse(
          "https://gatesadmin.000webhostapp.com/society_details.php"));
      data = jsonDecode(res.body);

      setState(() {
        dropdownValue = data[0]["soc_name"];
      });
    }

    getData();
    super.initState();
  }

  final TextEditingController firtsNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController flatHouseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TapGestureRecognizer gestureRecognizer = TapGestureRecognizer()
      ..onTap = () {};
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    FadeInDown(
                        delay: const Duration(milliseconds: 300),
                        duration: const Duration(milliseconds: 1500),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    FadeInDown(
                        delay: const Duration(milliseconds: 300),
                        duration: const Duration(milliseconds: 1500),
                        child: Text(
                          "Fill all the Mandatory details",
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: <Widget>[
                    RoundedSquareButton(
                        icon: Icons.image,
                        onPress: () async {
                          if (!Platform.isIOS) {
                            final pickedFile = await pickNewImage(false);

                            final pickedImageInBytes =
                                await pickedFile.readAsBytes();

                            // imageBaseCode.value =
                            //     base64.encode(pickedImageInBytes);
                          } else {
                            Fluttertoast.showToast(
                                msg: "This is a simulator",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                fontSize: 16.0);
                          }
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      duration: const Duration(milliseconds: 1500),
                      child: InputDecorator(
                        decoration: InputDecoration(
                            labelText: "Select Society",
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            prefixIcon: const Icon(
                              Iconsax.home,
                              color: Colors.black,
                              size: 18,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade200, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            floatingLabelStyle: const TextStyle(
                                color: Color(0xffFF6663), fontSize: 18),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffFF6663), width: 1.5),
                                borderRadius: BorderRadius.circular(10))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              value: dropdownValue,
                              elevation: 8,
                              isDense: true,
                              items: data.map((e) {
                                return DropdownMenuItem<String>(
                                  value: e["soc_name"],
                                  child: Text(e["soc_name"]),
                                );
                              }).toList(),
                              onChanged: (value) {
                                //_valud = value as int;

                                setState(() {
                                  dropdownValue = value.toString();
                                });
                              }),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    //Username
                    FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      duration: const Duration(milliseconds: 1500),
                      child: InputDecorator(
                        decoration: InputDecoration(
                            labelText: "Owner / Tenant",
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            prefixIcon: const Icon(
                              Iconsax.user,
                              color: Colors.black,
                              size: 18,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade200, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            floatingLabelStyle: const TextStyle(
                                color: Color(0xffFF6663), fontSize: 18),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffFF6663), width: 1.5),
                                borderRadius: BorderRadius.circular(10))),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              value: userValue,
                              elevation: 8,
                              isDense: true,
                              items: userType.map((e) {
                                return DropdownMenuItem<String>(
                                  value: e,
                                  child: Text(e),
                                );
                              }).toList(),
                              onChanged: (value) {
                                //_valud = value as int;

                                setState(() {
                                  userValue = value.toString();
                                });
                              }),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //Username
                    FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      duration: const Duration(milliseconds: 1500),
                      child: TextField(
                        controller: firtsNameController,
                        decoration: InputDecoration(
                            labelText: "Resident First Name",
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            prefixIcon: const Icon(
                              Iconsax.user,
                              color: Colors.black,
                              size: 18,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade200, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            floatingLabelStyle: const TextStyle(
                                color: Color(0xffFF6663), fontSize: 18),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffFF6663), width: 1.5),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //Username
                    FadeInUp(
                      delay: const Duration(milliseconds: 300),
                      duration: const Duration(milliseconds: 1500),
                      child: TextField(
                        controller: lastNameController,
                        decoration: InputDecoration(
                            labelText: "Resident Last Name",
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            prefixIcon: const Icon(
                              Iconsax.user,
                              color: Colors.black,
                              size: 18,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.shade200, width: 2),
                                borderRadius: BorderRadius.circular(10)),
                            floatingLabelStyle: const TextStyle(
                                color: Color(0xffFF6663), fontSize: 18),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xffFF6663), width: 1.5),
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    //Mobile
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 1500),
                      child: TextField(
                        controller: mobController,
                        maxLength: 10,
                        keyboardType: TextInputType.phone,
                        // obscureText: passwordVisible,
                        decoration: InputDecoration(
                            labelText: "Mobile No",
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            prefixIcon: const Icon(
                              Iconsax.call,
                              color: Colors.black,
                              size: 18,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
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
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    //Password
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 1500),
                      child: TextField(
                        controller: pwdController,
                        // obscureText: passwordVisible,
                        decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            prefixIcon: const Icon(
                              Iconsax.key,
                              color: Colors.black,
                              size: 18,
                            ),
                            suffixIcon: const Icon(
                              Iconsax.eye,
                              color: Colors.black,
                              size: 18,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
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
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    //Address
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 1500),
                      child: TextField(
                        controller: flatHouseController,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.visiblePassword,
                        // obscureText: passwordVisible,
                        decoration: InputDecoration(
                            labelText: "Flat/House No",
                            labelStyle: const TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            prefixIcon: const Icon(
                              Iconsax.home,
                              color: Colors.black,
                              size: 18,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
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
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                //SignUpButton
                FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    duration: const Duration(milliseconds: 1500),
                    child: Container(
                      padding: const EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: const Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                          )),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {},
                        color: const Color(0xffFF6663),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 15,
                ),
                FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    duration: const Duration(milliseconds: 1500),
                    child: Center(
                        child: RichText(
                      text: TextSpan(
                          text: "Already have an Account ? ",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          children: [
                            TextSpan(
                                text: "Login",
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                                recognizer: gestureRecognizer)
                          ]),
                    ))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
