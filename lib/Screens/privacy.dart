import 'package:flutter/material.dart';
import 'package:flutter_appwrite_auth/config.dart';
import 'package:flutter_appwrite_auth/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Privacy extends StatefulWidget {
  const Privacy({super.key});

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  WebViewController controller = WebViewController();
  
  @override
  void initState() {
    String privacyPageUrl = Config.privacyUrl;
    if (privacyPageUrl != '') {
      controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(privacyPageUrl));
    } else {
      Utils().showToast("Privacy page url not found");
      debugPrint("Url Not found.");
    }
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
      ),
      body: SafeArea(
        child: WebViewWidget(controller: controller)
      ),
    );
  }
}
