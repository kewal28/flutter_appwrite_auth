import 'package:flutter/material.dart';

class Config {
  static String appVersion = "1.0.1";
  static String billingPieLogo = 'https://billingpie.in/assets/images/logo-dark.png';
  static String appWriteUrl = 'https://cloud.appwrite.io/v1';
  static String privacyUrl = '6754b2a1003a99934a3d';
  static String razorpayKey = 'rzp_test_VNBfHwi60ScPaV';

  static String appWriteProjectId = '67f6241c003e2878fa2e';
  static String appWriteDatabase = '67f624ca002ab6665a17';
  static String appWriteUserCollection = '67f624d9000d4d108cab';

  static String userTypeFree = 'free';
  static String userTypeUnlimited = 'unlimited';

  static String name = "Flutter Appwrite Auth";
  static String loginMsg = "Login Successfully";
  static String signUpMsg = "Signup Successfully";
  static String logoutMsg = "Logout Successfully";
  static String forgetMsg = "Reset password link send on you Email id.";
  static String noInternetMessage = "No Internet Connection";

  static PreferredSizeWidget appBar(context, title,
      {Row? home, bool leading = true, List<Widget>? actions}) {
    return AppBar(
      automaticallyImplyLeading: true,
      centerTitle: true,
      leading: leading
          ? InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
              ),
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          letterSpacing: 1,
        ),
      ),
      actions: actions,
    );
  }
}

class HiveKeys {
  static String login = "user";
  static String settings = "settings";
}
