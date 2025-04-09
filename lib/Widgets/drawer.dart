import 'package:flutter_appwrite_auth/Screens/after_login.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_appwrite_auth/Screens/login.dart';
import 'package:flutter_appwrite_auth/Services/user.dart';
import 'package:flutter_appwrite_auth/config.dart';
import 'package:flutter_appwrite_auth/utils.dart';
import 'package:flutter/material.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  Utils utils = Utils();
  UserService userService = UserService();
  String email = "Loading...";
  String name = "Loading...";
  String userType = Config.userTypeFree;

  @override
  void initState() {
    super.initState();
    Box box = Hive.box(HiveKeys.login);
    email = box.containsKey('email') ? box.get('email') : email;
    name = box.containsKey('name') ? box.get('name') : name;
    userType = box.containsKey('type') ? box.get('type') : Config.userTypeFree;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      child: ListView(
        children: [
          Container(
            height: 100,
            color: Theme.of(context).primaryColor,
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
              ),
              accountEmail: Text(
                email,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              accountName: Text(
                name,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          Container(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.black
                : Colors.white,
            height: utils.getWidth(context).size.height - 190,
            child: Column(
              children: [
                _createDrawerItem(
                    icon: Icons.contacts,
                    text: 'After Login Screen',
                    onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AfterLogin(),
                            ),
                          )
                        }),
                _createDrawerItem(
                  icon: Icons.sync,
                  text: 'Google Sheet Sync',
                  onTap: () => {
                    Utils().showToast('Coming soon'),
                  },
                ),
                _createDrawerItem(
                  icon: Icons.calendar_month_outlined,
                  text: 'Subscription',
                  onTap: () => {},
                ),
                _createDrawerItem(
                  icon: Icons.mail,
                  text: 'Email Data',
                  onTap: () {},
                ),
                const Divider(),
                _createDrawerItem(
                  icon: Icons.collections_bookmark,
                  text: 'How to use?',
                  onTap: () {},
                ),
                _createDrawerItem(
                  icon: Icons.contacts,
                  text: 'Contact Us',
                  onTap: () {},
                ),
                _createDrawerItem(
                  icon: Icons.policy,
                  text: 'Terms & Conditions',
                  onTap: () {},
                ),
                // _createDrawerItem(icon: Icons.face, text: 'Authors'),
                // _createDrawerItem(
                //     icon: Icons.stars, text: 'Rate Us', onTap: rateUs),
                const Divider(),
                _createDrawerItem(
                  icon: Icons.logout_outlined,
                  text: 'Logout',
                  onTap: () async {
                    bool isLogout = await userService.logout(context);
                    if (isLogout) {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                        (route) => false,
                      );
                      return;
                    }
                    Utils().showToast('Something went wrong');
                  },
                )
              ],
            ),
          ),
          ListTile(
            title: Text("Version: ${Config.appVersion}"),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
