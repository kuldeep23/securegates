import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:secure_gates_project/pages/authentication/signup_page.dart';
import 'package:secure_gates_project/widgets/oauth_login_button.dart';
import 'package:secure_gates_project/widgets/rounded_text_field.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isLoading = useState(false);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: isLoading.value == true
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                width: size.width,
                height: size.height,
                child: ListView(
                  physics: const ClampingScrollPhysics(),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          child: Text(
                            "Log in",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Log in with one of the following options.",
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Expanded(
                                    child: OAuthLoginButton(
                                      icon: const Icon(FontAwesomeIcons.google),
                                      onPressed: () async {
                                        // isLoading.value = true;

                                        // await ref
                                        //     .read(authServiceProvider)
                                        //     .signInWithGoogle(context)
                                        //     .catchError((e, st) {
                                        //   if (e is CustomExeption) {
                                        //     isLoading.value = false;
                                        //   }
                                        // });

                                        // isLoading.value = false;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: const Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  thickness: 2,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "Or Connect with",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  thickness: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Email",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    RoundedTextField(
                                      controller: emailController,
                                      hintText: 'Your Email',
                                      secureIt: false,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Password",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    RoundedTextField(
                                      controller: passwordController,
                                      hintText: 'Enter your Password',
                                      secureIt: true,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            GestureDetector(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    left: 30,
                                    right: 30,
                                    bottom: 30,
                                    top: 10,
                                  ),
                                  height: 55,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    color: Colors.red,
                                    gradient: LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [
                                        // ignore: use_full_hex_values_for_flutter_colors
                                        Color(0xff6a3093),
                                        Color(0xffa044ff),
                                      ],
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.lock_outlined,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        'Log in Securely',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () async {
                                  // isLoading.value = true;

                                  // await ref
                                  //     .read(authServiceProvider)
                                  //     .signInWithEmail(
                                  //         _emailController.text.trim(),
                                  //         _passwordController.text.trim(),
                                  //         context)
                                  //     .catchError((e, st) {
                                  //   isLoading.value = false;
                                  // });

                                  // isLoading.value = false;
                                }),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(color: Colors.black),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SignupPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Sign up",
                                    style: TextStyle(
                                        color: Colors.deepPurple,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
