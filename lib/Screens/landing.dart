import 'package:flutter_appwrite_auth/Screens/after_login.dart';
import 'package:flutter_appwrite_auth/Screens/login.dart';
import 'package:flutter_appwrite_auth/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appwrite_auth/utils.dart';

class Landing extends StatefulWidget {
  const Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  Utils utils = Utils();

  @override
  void initState() {
    super.initState();
    isUserLogin(context);
  }

  isUserLogin(context) async {
    bool isLogged = await utils.checkUserLogin(context);
    if (!isLogged) {
      return Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const Login(),
        ),
      );
    }
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const AfterLogin(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _landing(),
    );
  }

  Widget _landing() {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/app-logo.png',
                width: 200,
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(
              ),
              const SizedBox(height: 30),
              Text(
                Config.name,
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
