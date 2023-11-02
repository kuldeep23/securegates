import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();

  LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    // final TapGestureRecognizer _gestureRecognizer = TapGestureRecognizer()
    //   ..onTap = () {
    //     Navigator.push(
    //         context, MaterialPageRoute(builder: (context) => SignupPage()));
    //   };
    bool passwordVisible = false;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    FadeInDown(
                        delay: const Duration(milliseconds: 100),
                        duration: const Duration(milliseconds: 1500),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    FadeInDown(
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 1500),
                        child: Text(
                          "Login to your account",
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: <Widget>[
                      FadeInUp(
                        delay: const Duration(milliseconds: 300),
                        duration: const Duration(milliseconds: 1500),
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                              labelText: "Name",
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
                        height: 2,
                      ),
                      //Username
                      FadeInUp(
                        delay: const Duration(milliseconds: 300),
                        duration: const Duration(milliseconds: 1500),
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                              labelText: "Name",
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
                        height: 25,
                      ),
                      //Password
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        duration: const Duration(milliseconds: 1500),
                        child: TextField(
                          controller: pwdController,
                          obscureText: true,
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
                    ],
                  ),
                ),
                //LoginButton
                FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 1500),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        padding: const EdgeInsets.only(top: 2, left: 3),
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
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    )),
                FadeInUp(
                    delay: const Duration(milliseconds: 600),
                    duration: const Duration(milliseconds: 1500),
                    child: Center(
                      child: RichText(
                        text: const TextSpan(
                            text: "Don't have an Account ? ",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            children: [
                              // TextSpan(
                              //     text: "Register",
                              //     style: const TextStyle(
                              //       color: Colors.red,
                              //       fontSize: 17,
                              //       fontWeight: FontWeight.bold,
                              //     ),
                              //     recognizer: _gestureRecognizer)
                            ]),
                      ),
                    ))
              ],
            ),
          ),
          FadeInUp(
              delay: const Duration(milliseconds: 700),
              duration: const Duration(milliseconds: 1500),
              child: SizedBox(
                height: 250,
                child: OverflowBox(
                  child: Lottie.network(
                      'https://assets5.lottiefiles.com/packages/lf20_KU3FGB47d6.json'),
                ),
              ))
        ],
      ),
    );
  }
}
