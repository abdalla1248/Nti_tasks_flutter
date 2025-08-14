import 'package:flutter/material.dart';
import 'package:todapp/core/utils/app_assets.dart';
import 'ChangePass.dart';
import 'UserUpdate.dart';
import 'settings_screen.dart';
import 'widget/ProfileCard.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key, required this.name, this.password});
  final String name;
  final String ? password;

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:8.0,left: 8),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(AppAssets.flag),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Hello!", style: TextStyle(fontSize: 16)),
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ProfileCard(
              icon: Icons.person_outlined,
              title: 'Profile',
              onTap: () {
               Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => Userupdate()),
               );
              },
            ),
            ProfileCard(
              icon: Icons.lock_outline,
              title: 'Change password',
              onTap: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => Changepass(name: widget.name,password:  widget.password),
                   ),
                 );
              },
            ),
            ProfileCard(
              icon: Icons.settings_outlined,
              title: 'Settings',
              onTap: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => SettingsScreen(selectedLanguage: '',)),
                 );
              },
            ),
          ],
        ),
      ),
    );
  }
}
