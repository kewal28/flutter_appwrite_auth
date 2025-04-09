import 'package:flutter_appwrite_auth/Screens/login.dart';
import 'package:flutter_appwrite_auth/Services/user.dart';
import 'package:flutter_appwrite_auth/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  Utils utils = Utils();
  UserService userService = UserService();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  final _fromForgetPassword = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    String validationEmail = "email";
    final emailField = Utils.getFormField("Email", validationEmail,
        emailController, const Icon(Icons.email_outlined),
        keyboardType: TextInputType.emailAddress);

    final forgetPasswordButton = Material(
      child: ElevatedButton(
          child: (isLoading)
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                )
              : const Text('Forget Password'),
          onPressed: () async {
            if (isLoading) {
              return;
            }
            if (_fromForgetPassword.currentState!.validate()) {
              isLoading = true;
              setState(() {});
              Utils().showToast("Forget Password is not working");
              isLoading = false;
              setState(() {});
              // await userService.forgetPassword(emailController.text);
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const Login(),
              //   ),
              // );
            }
          }),
    );
    double width = 400;
    MediaQueryData mediaQuery;
    if (!kIsWeb) {
      mediaQuery = utils.getWidth(context);
      width = mediaQuery.size.width;
    }
    return KeyboardDismisser(
      gestures: const [GestureType.onTap, GestureType.onVerticalDragDown],
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: width,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                    key: _fromForgetPassword,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: Text(
                            "Forget Password",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Text(
                          "Please sign in to continue.",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        emailField,
                        const SizedBox(
                          height: 30,
                        ),
                        forgetPasswordButton,
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
          height: 100,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              "Already have an account?",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
                onTap: () => {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login(),),)
                    },
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 18),
                )),
            const SizedBox(
              height: 20,
            )
          ]),
        ),
      ),
    );
  }
}
