import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appwrite_auth/config.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  
  static TextFormField getFormField(String hint, validation, controller, Icon icon,
      {keyboardType, bool obscureText = false, suffixIcon}) {
    var validations = checkValidation(validation, hint);
    return TextFormField(
      obscureText: obscureText,
      style: const TextStyle(
        fontSize: 18.0,
      ),
      validator: validations,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
        prefixIcon: icon,
        hintText: hint,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 32.0),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      autofocus: false,
      controller: controller,
      keyboardType: keyboardType,
      onSaved: (value) {
        controller.text = value;
      },
      textInputAction: TextInputAction.next,
    );
  }

  static checkValidation(String validation, String hint) {
    if (validation == "email") {
      return (value) {
        if (value.isEmpty) {
          return 'Email cannot be empty';
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      };
    } else if (validation == "password") {
      return (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value.isEmpty) {
          return ("Password is required.");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Password (Min. 6 Character)");
        }
      };
    } else if (validation == "phone") {
      return (value) {
        RegExp regex = RegExp(r'^-?[0-9]+$');
        if (value.isEmpty) {
          return ("Phone no is required.");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid Phone No.");
        }
        int length = '$value'.length; // 7
        if (length != 10) {
          return ("Phone No. is not valid.");
        }
      };
    } else if (validation == "required") {
      return (value) {
        if (value.isEmpty) {
          return ("$hint field is required.");
        }
      };
    } else {
      return (value) {};
    }
  }

  static String trimText(String text, int length) {
    if (text.length > length) {
      return "${text.substring(0, length)} ...";
    } else {
      return text;
    }
  }

  //Print Toast
  showToast(String errorMsg) {
    Fluttertoast.showToast(
      msg: errorMsg.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 14.0,
    );
  }

  static Widget loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  static Widget apiError() {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 20),
      child: const Text("Error while Getting Error"),
    );
  }

  static notProductFound(context, String title, String body) {
    Utils utils = Utils();
    MediaQueryData width = utils.getWidth(context);
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: width.size.width - 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/not-found.png"),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                // decoration: TextDecoration.underline,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              body,
              style: TextStyle(
                fontSize: 16,
                // decoration: TextDecoration.underline,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> showMyDialog(context, title, body, actions) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: title,
          content: SingleChildScrollView(
            child: body,
          ),
          actions: actions,
        );
      },
    );
  }

  MediaQueryData getWidth(context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return queryData;
  }

  Future<bool> checkUserLogin(context) async {
    try {
      Client client = Client();
      client
          .setEndpoint(Config.appWriteUrl)
          .setProject(Config.appWriteProjectId);
      Account account = Account(client);
      await account.getSession(sessionId: 'current');
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  int getTimeStamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  static Color statusColor(String status) {
    switch (status) {
      case 'pending':
        return Colors.blueAccent;
      case 'complete':
        return Colors.green;
      case 'fail':
        return Colors.red;
      default:
        return Colors.red;
    }
  }

  static IconData statusIcon(String status) {
    switch (status) {
      case 'pending':
        return Icons.pending;
      case 'complete':
        return Icons.done;
      case 'fail':
        return Icons.error;
      default:
        return Icons.pending;
    }
  }

  static String formatDate(DateTime dateTime) {
    Duration difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 365) {
      return "${(difference.inDays / 365).floor()} years ago";
    } else if (difference.inDays > 30) {
      return "${(difference.inDays / 30).floor()} months ago";
    } else if (difference.inDays > 0) {
      return "${difference.inDays} days ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours} hours ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes} minutes ago";
    } else {
      return "just now";
    }
  }
}
