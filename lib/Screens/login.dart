import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:flutter_appwrite_auth/Screens/after_login.dart';
import 'package:flutter_appwrite_auth/Screens/privacy.dart';
import 'package:flutter_appwrite_auth/Screens/forget_password.dart';
import 'package:flutter_appwrite_auth/Screens/signup.dart';
import 'package:flutter_appwrite_auth/Services/user.dart';
import 'package:flutter_appwrite_auth/config.dart';
import 'package:flutter_appwrite_auth/utils.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  UserService userService = UserService();
  Utils utils = Utils();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  final _fromLogin = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? errorMessage;
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    String validationEmail = "email";
    final emailField = Utils.getFormField("Email", validationEmail,
        emailController, const Icon(Icons.email_outlined),
        keyboardType: TextInputType.emailAddress);
    String validationPassword = "password";
    final passwordField = Utils.getFormField("Password", validationPassword,
        passwordController, const Icon(Icons.password_rounded),
        keyboardType: TextInputType.emailAddress,
        obscureText: _isObscure,
        suffixIcon: IconButton(
          icon: Icon(
            _isObscure ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ));

    final loginButton = Material(
      child: ElevatedButton(
        child: (isLoading)
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(),
              )
            : const Text("Login"),
        onPressed: () async {
          if (isLoading) {
            return;
          }
          isLoading = true;
          setState(() {});
          if (emailController.text.isEmpty) {
            isLoading = false;
            setState(() {});
            Utils().showToast("Please enter email");
            return;
          }
          if (passwordController.text.isEmpty) {
            isLoading = false;
            setState(() {});
            Utils().showToast("Please enter password");
            return;
          }
          if (_fromLogin.currentState!.validate()) {
            bool isLogin = await userService.singIn(
              emailController.text,
              passwordController.text,
            );
            if (isLogin) {
              Utils().showToast(Config.loginMsg);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const AfterLogin(),
                ),
              );
            }
          }
          isLoading = false;
          setState(() {});
        },
      ),
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
                    key: _fromLogin,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Text(
                          "Please sign in to continue.",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        emailField,
                        const SizedBox(
                          height: 20,
                        ),
                        passwordField,
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            const Text("By clicking logging you agree to the "),
                            GestureDetector(
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const Privacy(),
                                    ))
                              },
                              child: Text(
                                "Privacy & Terms",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        loginButton,
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () => {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgetPassword(),
                              ),
                            )
                          },
                          child: Text(
                            "Forget password?",
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                            ),
                          ),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account?",
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
                      builder: (context) => const SignUp(),
                    ),
                  )
                },
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
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
