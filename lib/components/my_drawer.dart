import 'package:chat/services/auth/auth_service.dart';
import 'package:chat/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() async {
    //get auth
    final authservice = AuthService();
    //signout
    try {
      await authservice.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          DrawerHeader(
              child: Center(
                  child: Icon(
            Icons.messenger,
            color: Theme.of(context).colorScheme.primary,
            size: 64,
          ))),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: ListTile(
              title: Text(
                "H O M E",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () {
                // Navigate to Home Screen
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: ListTile(
              title: Text(
                "S E T T I N G S",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Settings Screen
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsPage()));
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: ListTile(
              title: Text(
                "L O G O U T",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.primary,
              ),
              onTap: () {
                // logout
                logout();
              },
            ),
          )
        ],
      ),
    );
  }
}
