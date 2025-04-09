import 'package:flutter/material.dart';
import 'package:flutter_appwrite_auth/Widgets/drawer.dart';
import 'package:flutter_appwrite_auth/config.dart';

class AfterLogin extends StatefulWidget {
  const AfterLogin({super.key});

  @override
  State<AfterLogin> createState() => _AfterLoginState();
}

class _AfterLoginState extends State<AfterLogin> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer:const SideMenu(),
      appBar: Config.appBar(context, Config.name, leading: false),
      body: const Center(
        child: Text("After Login Screen"),
      ),
    );
  }
}