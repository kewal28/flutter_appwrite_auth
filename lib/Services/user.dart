import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_appwrite_auth/config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_appwrite_auth/utils.dart';

class UserService {
  Client client = Client();
  late Account account;
  String? errorMessage;

  singIn(String email, String password) async {
    try {
      client
          .setEndpoint(Config.appWriteUrl)
          .setProject(Config.appWriteProjectId);
      Account account = Account(client);
      await account.createEmailPasswordSession(
        email: email,
        password: password,
      );
      User user = await account.get();
      Databases databases = Databases(client);
      Document userDetails = await databases.getDocument(
        databaseId: Config.appWriteDatabase,
        collectionId: Config.appWriteUserCollection,
        documentId: user.$id,
      );
      Box box = Hive.box(HiveKeys.login);
      String type = Config.userTypeFree;
      if (userDetails.data['type'] != "") {
        type = userDetails.data['type'];
      }
      box.put('uuid', user.$id);
      box.put('email', userDetails.data['email']);
      box.put('name', userDetails.data['name']);
      box.put('type', type);
      if (userDetails.data['expired_at'] != "") {
        box.put('expireAt', userDetails.data['expired_at']);
      } else {
        box.put('expireAt', "");
      }
      return true;
    } on AppwriteException catch (e) {
      debugPrint(e.toString());
      Utils().showToast(e.message ?? "Something went wrong");
      return false;
    }
  }

  singUp(String email, String password, String name, String phone) async {
    try {
      Databases databases = Databases(client);
      client
          .setEndpoint(Config.appWriteUrl)
          .setProject(Config.appWriteProjectId);
      Account account = Account(client);

      User result = await account.create(
        email: email,
        password: password,
        userId: 'unique()',
        name: name,
      );
      databases.createDocument(
        databaseId: Config.appWriteDatabase,
        collectionId: Config.appWriteUserCollection,
        documentId: result.$id,
        data: {
          'name': name,
          'email': email,
          'phone_no': phone,
          'type': Config.userTypeFree,
        },
      );
      await singIn(email, password);
      return true;
    } on AppwriteException catch (e) {
      debugPrint(e.toString());
      Utils().showToast(e.message ?? "Something went wrong");
      return false;
    }
  }

  forgetPassword(email) async {
    try {
      client
          .setEndpoint(Config.appWriteUrl)
          .setProject(Config.appWriteProjectId);
      Account account = Account(client);
      await account.createRecovery(
        email: email,
        url: 'http://143.110.251.50/',
      );
      Utils().showToast(Config.forgetMsg);
      return true;
    } on AppwriteException catch (e) {
      debugPrint(e.toString());
      Utils().showToast(e.message ?? "Something went wrong");
      return false;
    }
  }

  Future<bool> logout(context) async {
    try {
      client
          .setEndpoint(Config.appWriteUrl)
          .setProject(Config.appWriteProjectId);
      Account account = Account(client);
      await account.deleteSession(sessionId: 'current');
      Box box = Hive.box(HiveKeys.login);
      box.delete('name');
      box.delete('email');
      box.delete('type');
      box.delete('uuid');
      return true;
    } on AppwriteException catch (error) {
      debugPrint(error.message);
      return false;
    }
  }
}
